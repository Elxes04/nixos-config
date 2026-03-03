{ config, pkgs, ... }:

let
  openjdk25-native = pkgs.openjdk25.overrideAttrs (old: {
    pname = "openjdk25-native";

    env = (old.env or {}) // {
      NIX_CFLAGS_COMPILE = (old.env.NIX_CFLAGS_COMPILE or "") + " -O3 -march=native -mtune=native";
      NIX_CXXFLAGS_COMPILE = (old.env.NIX_CXXFLAGS_COMPILE or "") + " -O3 -march=native -mtune=native";
    };
  });
in
{
  # Development services
  services = {
    # PostgreSQL (disabled by default)
    postgresql = {
      enable = false;
      package = pkgs.postgresql_16;
    };
  };

  # Virtualization
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
    
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
      onBoot = "start";
    };
  };

  # Enable virt-manager program
  programs.virt-manager = {
    enable = true;
  };

  # Auto-start libvirt default network
  systemd.services.libvirt-network-autostart = {
    description = "Auto-start libvirt default network";
    after = [ "libvirtd.service" ];
    wants = [ "libvirtd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
    };
    script = ''
      set -e
      # Give libvirtd time to start
      sleep 2
      # Start default network if it exists
      ${pkgs.libvirt}/bin/virsh net-list --all | grep -q "default" && ${pkgs.libvirt}/bin/virsh net-start default 2>/dev/null || true
    '';
  };

  # System-level development packages
  environment.systemPackages = with pkgs; [
    # Java
    openjdk25-native

    # Version control
    git
    gh
    
    # Programming languages
    # Python
    python312
    python312Packages.pip
    python312Packages.virtualenv
    unstable.uv
    
    # Node.js
    unstable.nodejs_22
    unstable.nodePackages.npm
    unstable.nodePackages.pnpm
    unstable.yarn
    unstable.bun
    
    # Rust
    unstable.rustup
    
    # Go
    unstable.go
    unstable.gopls
    
    # C/C++
    gcc
    clang
    cmake
    gnumake
    
    # Build tools
    meson
    ninja
    unstable.just

    # IDE
    vscode
    
    # Container tools
    docker-compose
    
    # Network tools
    dnsmasq
    wget
    curl
    
    # System tools
    tmux
    screen
    
    # Documentation
    man-pages
    man-pages-posix
  ];

  # Enable documentation
  documentation = {
    enable = true;
    dev.enable = false;
    man.enable = true;
  };
  
  # Enable direnv system-wide
  programs.direnv = {
    enable = true;
  };
}
