.PHONY: help switch test boot update check clean gc optimize fmt

HOST ?= nixos

help:
	@echo "NixOS Configuration Management"
	@echo ""
	@echo "Usage:"
	@echo "  make switch       - Rebuild and switch to new configuration"
	@echo "  make test         - Test configuration without switching"
	@echo "  make boot         - Set configuration for next boot"
	@echo "  make update       - Update flake inputs"
	@echo "  make check        - Check flake configuration"
	@echo "  make clean        - Clean old generations (keeps last 5)"
	@echo "  make gc           - Aggressive garbage collection"
	@echo "  make optimize     - Optimize nix store"
	@echo "  make fmt          - Format nix files"
	@echo ""
	@echo "Options:"
	@echo "  HOST=<name>       - Specify host (default: nixos)"

switch:
	sudo nixos-rebuild switch --flake .#$(HOST)

test:
	sudo nixos-rebuild test --flake .#$(HOST)

boot:
	sudo nixos-rebuild boot --flake .#$(HOST)

update:
	nix flake update

check:
	nix flake check

clean:
	sudo nix-env --delete-generations +5 --profile /nix/var/nix/profiles/system
	sudo nix-collect-garbage

gc:
	sudo nix-collect-garbage -d
	sudo nix-store --gc

optimize:
	sudo nix-store --optimize

fmt:
	find . -name "*.nix" -type f -exec nixpkgs-fmt {} \;

list-generations:
	sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

show-diff:
	nix profile diff-closures --profile /nix/var/nix/profiles/system

backup:
	@echo "Creating backup of current configuration..."
	sudo cp -r /etc/nixos /etc/nixos.backup-$$(date +%Y%m%d-%H%M%S)
	@echo "Backup created!"
