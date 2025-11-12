{ config, pkgs, lib, ... }:
{
  # Common environment variables for cargo builds (can tune further)
  environment.variables = {
    RUSTFLAGS = "-C opt-level=3 -C codegen-units=1"; # aggressive optimization
    CARGO_PROFILE_RELEASE_LTO = "true";
    CARGO_PROFILE_RELEASE_CODEGEN_UNITS = "1";
    CARGO_INCREMENTAL = "0";
    # Use sccache transparently with cargo builds
    RUSTC_WRAPPER = "${pkgs.sccache}/bin/sccache";
    # Per-user cache directory (works well outside Nix builds)
    SCCACHE_DIR = "$HOME/.cache/sccache";
    # Tweak cache size as desired
    SCCACHE_CACHE_SIZE = "10G";
  };

  environment.systemPackages = with pkgs; [
    # Core Rust toolchain components (rustc via rustup for flexibility)
    rustup
    cargo
    rust-analyzer
    clippy
    rustfmt

    # Useful cargo subcommands / helpers
    cargo-edit          # adds cargo add/rm/upd
    cargo-outdated      # show outdated deps
    cargo-audit         # security audit of dependencies
    cargo-deny          # license / advisory checks
    cargo-watch         # watch & rebuild
    cargo-binutils      # llvm tools integration
    cargo-llvm-lines    # codegen statistics

    # Build tooling
    pkg-config
    cmake
    ninja

    # Compilers / linkers / debuggers
    gcc
    clang
    lld
    lldb
    gdb

    # Performance / caching
    sccache

    # Libraries frequently needed for crates (crypto, compression, etc.)
    openssl
    openssl.dev
    zlib
    zlib.dev

  # Profiling / analysis
  linuxPackages.perf
    hyperfine
    flamegraph

    # Optional: static analysis & formatting extras
    shellcheck
  ];

  # Provide a simple wrapper script to bootstrap a stable toolchain on first use
  # (Users can still run `rustup toolchain install nightly` etc.)
  system.activationScripts.rustupBootstrap.text = ''
    if [ ! -d /root/.rustup ]; then
      echo "Initializing system rustup stable toolchain (root)" >&2
      ${pkgs.rustup}/bin/rustup toolchain install stable --profile minimal || true
    fi
  '';
}
