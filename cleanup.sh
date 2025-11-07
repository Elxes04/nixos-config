#!/usr/bin/env bash

# NixOS Cleanup Script - Clean caches and unused packages
# Removes old generations, unused packages, and various caches

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                    🧹 NixOS Cleanup Tool                     ║${NC}"
    echo -e "${BLUE}║              Clean caches and unused packages                ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

show_current_usage() {
    echo -e "${YELLOW}Current disk usage:${NC}"
    echo "Nix store size:"
    du -sh /nix/store 2>/dev/null || echo "Could not read /nix/store"
    echo ""
    echo "System generations:"
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -5
    echo ""
}

clean_user_cache() {
    echo -e "${YELLOW}🧹 Cleaning user caches...${NC}"
    
    # Clean user profile old generations
    echo "Cleaning user profile generations..."
    nix-collect-garbage --delete-older-than 7d
    
    # Clean home-manager generations
    if command -v home-manager &> /dev/null; then
        echo "Cleaning home-manager generations..."
        home-manager expire-generations "-7 days" 2>/dev/null || true
    fi
    
    echo -e "${GREEN}✅ User caches cleaned${NC}"
}

clean_system_cache() {
    echo -e "${YELLOW}🧹 Cleaning system caches...${NC}"
    
    # Clean system generations (requires sudo)
    echo "Cleaning old system generations..."
    sudo nix-collect-garbage --delete-older-than 7d
    
    # Clean systemd boot entries
    echo "Cleaning old boot entries..."
    sudo /run/current-system/bin/switch-to-configuration boot 2>/dev/null || true
    
    echo -e "${GREEN}✅ System caches cleaned${NC}"
}

clean_nix_store() {
    echo -e "${YELLOW}🧹 Optimizing Nix store...${NC}"
    
    # Optimize store (deduplicate identical files)
    echo "Deduplicating Nix store..."
    sudo nix-store --optimise
    
    echo -e "${GREEN}✅ Nix store optimized${NC}"
}

clean_application_caches() {
    echo -e "${YELLOW}🧹 Cleaning application caches...${NC}"
    
    # Clean common application caches
    local cache_dirs=(
        "$HOME/.cache"
        "$HOME/.local/share/Trash"
        "$HOME/.thumbnails"
        "/tmp"
    )
    
    for cache_dir in "${cache_dirs[@]}"; do
        if [[ -d "$cache_dir" ]]; then
            echo "Cleaning $cache_dir..."
            find "$cache_dir" -type f -atime +7 -delete 2>/dev/null || true
        fi
    done
    
    # Clean browser caches if they exist
    if [[ -d "$HOME/.cache/mozilla" ]]; then
        echo "Cleaning Firefox cache..."
        rm -rf "$HOME/.cache/mozilla/firefox/*/cache*" 2>/dev/null || true
    fi
    
    if [[ -d "$HOME/.cache/google-chrome" ]]; then
        echo "Cleaning Chrome cache..."
        rm -rf "$HOME/.cache/google-chrome/*/Cache*" 2>/dev/null || true
    fi
    
    echo -e "${GREEN}✅ Application caches cleaned${NC}"
}

clean_logs() {
    echo -e "${YELLOW}🧹 Cleaning old logs...${NC}"
    
    # Clean systemd journals older than 1 week
    sudo journalctl --vacuum-time=7d
    
    echo -e "${GREEN}✅ Logs cleaned${NC}"
}

show_menu() {
    print_header
    show_current_usage
    
    echo -e "${BLUE}Cleanup options:${NC}"
    echo "  1) Quick clean (user cache only)"
    echo "  2) Full clean (everything)"
    echo "  3) System only (requires sudo)"
    echo "  4) Nix store optimization only"
    echo "  5) Application caches only"
    echo "  6) Show disk usage only"
    echo "  q) Quit"
    echo ""
}

main() {
    while true; do
        show_menu
        
        read -p "Choose option [1-6, q]: " choice
        echo ""
        
        case "$choice" in
            "1")
                clean_user_cache
                ;;
            "2")
                clean_user_cache
                clean_system_cache
                clean_nix_store
                clean_application_caches
                clean_logs
                ;;
            "3")
                clean_system_cache
                clean_nix_store
                ;;
            "4")
                clean_nix_store
                ;;
            "5")
                clean_application_caches
                ;;
            "6")
                show_current_usage
                ;;
            "q"|"Q")
                echo -e "${BLUE}Goodbye! 👋${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid option: $choice${NC}"
                sleep 2
                ;;
        esac
        
        echo ""
        echo -e "${YELLOW}After cleanup:${NC}"
        show_current_usage
        
        read -p "Press Enter to continue..."
    done
}

main "$@"