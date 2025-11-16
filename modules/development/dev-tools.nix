{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Version Control & Collaboration
    lazygit              # Terminal UI for git
    gh                   # GitHub CLI
    gitui               # Terminal git UI (alternative to lazygit)
    
    # Terminal & Shell Tools
    tmux                # Terminal multiplexer
    zellij              # Modern terminal workspace
    starship            # Modern shell prompt
    zoxide              # Smarter cd command
    fzf                 # Fuzzy finder
    ripgrep             # Fast grep alternative (rg)
    fd                  # Fast find alternative
    bat                 # Cat with syntax highlighting
    eza                 # Modern ls replacement
    
    # File Management
    # ranger              # Terminal file manager
    yazi                # Modern terminal file manager
    trash-cli           # Safe rm with trash
    
    # Development Tools
    postman             # API testing
    insomnia            # REST/GraphQL client
    dbeaver-bin         # Universal database tool
    
    # Container & Virtualization
    distrobox           # Run any Linux distribution
    podman-compose      # Docker-compose for Podman
    
    # Network Tools
    nmap                # Network scanner
    wireshark           # Network protocol analyzer
    netcat-gnu          # Network utility
    
    # Text Editors & IDEs
    neovim              # Modern vim
    helix               # Modern modal editor
    
    # Build Tools
    direnv              # Load environment per directory
    just                # Command runner (like make)
    
    # Documentation
    tldr                # Simplified man pages
    cheat               # Create and view interactive cheatsheets
    
    # Performance & Profiling
    valgrind            # Memory debugging & profiling
    linuxPackages.perf  # Performance analysis tools
    
    # File Transfer
    rsync               # Fast file transfer
    rclone              # Cloud storage sync
  ];

  # Enable direnv for automatic environment loading
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
