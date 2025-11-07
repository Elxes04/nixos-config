{ config, lib, pkgs, ... }:

{
  # Enable ccache system-wide for faster recompilation
  programs.ccache.enable = true;
  
  environment.systemPackages = [
    (pkgs.handbrake.overrideAttrs (oldAttrs: {
      # Disable hardening to allow native CPU optimizations
      hardeningDisable = [ "all" ];
      
      nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.ccache ];
      
      preConfigure = ''
        ${oldAttrs.preConfigure or ""}
        
        export CCACHE_DIR=/var/cache/ccache
        export CCACHE_NOCOMPRESS=1
        
        # Force native CPU optimization flags
        export NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1
        export NIX_CFLAGS_COMPILE="-O3 -pipe -march=native -mtune=native $NIX_CFLAGS_COMPILE"
        export CFLAGS="-O3 -pipe -march=native -mtune=native"
        export CXXFLAGS="-O3 -pipe -march=native -mtune=native"
        export LDFLAGS="-O3 -march=native $LDFLAGS"
        
        export CC="ccache gcc"
        export CXX="ccache g++"
      '';
      
      configureFlags = (oldAttrs.configureFlags or []) ++ [
        "--optimize=speed"
        "--enable-gtk"
      ];
    }))
  ];
  
  # ccache directory
  systemd.tmpfiles.rules = [
    "d /var/cache/ccache 0755 root root -"
  ];
}
