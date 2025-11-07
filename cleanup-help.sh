#!/usr/bin/env bash

# Quick NixOS Cleanup Commands Reference

echo "🧹 Quick NixOS Cleanup Commands:"
echo ""

echo "📦 Nix Store & Generations:"
echo "  nix-collect-garbage -d                    # Delete all old user generations"
echo "  sudo nix-collect-garbage -d               # Delete all old system generations"
echo "  sudo nix-collect-garbage --delete-older-than 7d  # Keep only last 7 days"
echo ""

echo "🗄️ Nix Store Optimization:"
echo "  sudo nix-store --optimise                 # Deduplicate identical files"
echo "  nix-store --gc                            # Garbage collect unreferenced paths"
echo ""

echo "📋 System Information:"
echo "  nix-env --list-generations                # Show user generations"
echo "  sudo nix-env --list-generations --profile /nix/var/nix/profiles/system  # Show system generations"
echo "  du -sh /nix/store                         # Show Nix store size"
echo ""

echo "🗃️ Application Caches:"
echo "  rm -rf ~/.cache/*                         # Clear user cache"
echo "  sudo journalctl --vacuum-time=7d          # Clean systemd logs"
echo "  rm -rf ~/.local/share/Trash/*             # Empty trash"
echo ""

echo "🔄 Boot Cleanup:"
echo "  sudo /run/current-system/bin/switch-to-configuration boot  # Clean old boot entries"
echo ""

echo "🚀 Full Cleanup One-liner:"
echo "  sudo nix-collect-garbage -d && sudo nix-store --optimise && sudo journalctl --vacuum-time=7d"
echo ""

echo "💡 Use ./cleanup.sh for interactive cleanup!"