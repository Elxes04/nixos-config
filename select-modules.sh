#!/usr/bin/env bash

# NixOS Module Selector - TUI for selecting modules to activate
# Elxes NixOS Configuration

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="/etc/nixos"
MODULES_DIR="$CONFIG_DIR/modules"
HOST_CONFIG="$CONFIG_DIR/hosts/nixos.nix"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Array to track selected modules
declare -A SELECTED_MODULES

# Function to print header
print_header() {
    clear
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                    🎛️  NixOS Module Selector                  ║${NC}"
    echo -e "${BLUE}║                   Select modules to activate                 ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Function to list modules available by category
list_modules_by_category() {
    local category="$1"
    local category_path="$MODULES_DIR/$category"
    
    if [[ -d "$category_path" ]]; then
        echo -e "${YELLOW}📁 $category/${NC}"
        for module_file in "$category_path"/*.nix; do
            if [[ -f "$module_file" ]]; then
                local module_name=$(basename "$module_file" .nix)
                local status="❌"
                if [[ "${SELECTED_MODULES[$category/$module_name]:-false}" == "true" ]]; then
                    status="✅"
                fi
                echo "   $status $module_name"
            fi
        done
        echo ""
    fi
}

# Function to read current configuration
read_current_config() {
    # Initialize all modules as not selected
    for category in apps desktop system development creative tools entertainment; do
        local category_path="$MODULES_DIR/$category"
        if [[ -d "$category_path" ]]; then
            for module_file in "$category_path"/*.nix; do
                if [[ -f "$module_file" ]]; then
                    local module_name=$(basename "$module_file" .nix)
                    SELECTED_MODULES["$category/$module_name"]="false"
                fi
            done
        fi
    done
    
    # Read currently activated modules from configuration file
    if [[ -f "$HOST_CONFIG" ]]; then
        while IFS= read -r line; do
            if [[ "$line" =~ \.\./modules/([^/]+)/([^/]+)\.nix ]]; then
                local category="${BASH_REMATCH[1]}"
                local module="${BASH_REMATCH[2]}"
                SELECTED_MODULES["$category/$module"]="true"
            fi
        done < "$HOST_CONFIG"
    fi
}

# Function to toggle module
toggle_module() {
    local category="$1"
    local module="$2"
    local key="$category/$module"
    
    if [[ "${SELECTED_MODULES[$key]:-false}" == "true" ]]; then
        SELECTED_MODULES["$key"]="false"
    else
        SELECTED_MODULES["$key"]="true"
    fi
}

# Function to show main menu
show_menu() {
    print_header
    
    echo -e "${GREEN}Available modules:${NC}"
    echo ""
    
    # Show modules by category
    list_modules_by_category "apps"
    list_modules_by_category "desktop" 
    list_modules_by_category "system"
    list_modules_by_category "development"
    list_modules_by_category "creative"
    list_modules_by_category "tools"
    list_modules_by_category "entertainment"
    
    echo -e "${BLUE}Available commands:${NC}"
    echo "  toggle <category>/<module>  - Toggle module on/off"
    echo "  apply                       - Apply configuration"
    echo "  quit                        - Exit without saving"
    echo ""
}

# Function to generate new configuration
generate_config() {
    local temp_file="/tmp/nixos_new_config.nix"
    
    # Copy base configuration
    cp "$HOST_CONFIG" "$temp_file"
    
    # Find imports section and replace it
    cat > "/tmp/imports_section.nix" << 'EOF'
  imports = [
    ../hardware-configuration.nix

    # System modules
    ../modules/system/base.nix
    ../modules/system/network.nix
    ../modules/system/users.nix

    # Desktop environment modules
    ../modules/desktop/gnome.nix
    ../modules/desktop/pipewire.nix
    ../modules/desktop/flatpak.nix

    # Applications and tools
EOF

    # Add selected modules
    for key in "${!SELECTED_MODULES[@]}"; do
        if [[ "${SELECTED_MODULES[$key]}" == "true" ]]; then
            echo "    ../modules/$key.nix" >> "/tmp/imports_section.nix"
        fi
    done
    
    echo "  ];" >> "/tmp/imports_section.nix"
    
    # Replace imports section
    awk '
    /imports = \[/ { 
        system("cat /tmp/imports_section.nix")
        skip=1
        next
    }
    /\];/ && skip { 
        skip=0
        next
    }
    !skip
    ' "$HOST_CONFIG" > "$temp_file"
    
    echo "$temp_file"
}

# Function to apply configuration
apply_config() {
    echo -e "${YELLOW}Generating new configuration...${NC}"
    local new_config=$(generate_config)
    
    echo -e "${YELLOW}Configuration preview:${NC}"
    echo "----------------------------------------"
    grep -A 20 "imports = \[" "$new_config" || true
    echo "----------------------------------------"
    echo ""
    
    read -p "Apply this configuration? [y/N]: " confirm
    
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Backing up current configuration...${NC}"
        cp "$HOST_CONFIG" "$HOST_CONFIG.backup.$(date +%Y%m%d_%H%M%S)"
        
        echo -e "${YELLOW}Applying new configuration...${NC}"
        cp "$new_config" "$HOST_CONFIG"
        
        echo -e "${GREEN}Configuration saved!${NC}"
        
        read -p "Do you want to run nixos-rebuild switch now? [y/N]: " rebuild
        if [[ "$rebuild" =~ ^[Yy]$ ]]; then
            sudo nixos-rebuild switch --flake .#nixos
        fi
    fi
}

# Main loop
main() {
    read_current_config
    
    while true; do
        show_menu
        
        echo -n "Command: "
        read -r command args
        
        case "$command" in
            "toggle")
                if [[ "$args" =~ ^([^/]+)/([^/]+)$ ]]; then
                    local category="${BASH_REMATCH[1]}"
                    local module="${BASH_REMATCH[2]}"
                    
                    if [[ -f "$MODULES_DIR/$category/$module.nix" ]]; then
                        toggle_module "$category" "$module"
                        echo -e "${GREEN}Toggled $category/$module${NC}"
                        sleep 1
                    else
                        echo -e "${RED}Module $category/$module not found!${NC}"
                        sleep 2
                    fi
                else
                    echo -e "${RED}Wrong format. Use: toggle category/module${NC}"
                    sleep 2
                fi
                ;;
            "apply")
                apply_config
                ;;
            "quit")
                echo -e "${BLUE}Exiting without saving.${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Unknown command: $command${NC}"
                sleep 2
                ;;
        esac
    done
}

# Check if script is run as root for system modifications
if [[ $EUID -ne 0 ]] && [[ "$1" != "--dry-run" ]]; then
    echo -e "${YELLOW}This script requires root privileges to modify the configuration.${NC}"
    echo "Relaunching with sudo..."
    exec sudo "$0" "$@"
fi

main "$@"