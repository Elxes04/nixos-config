# NVIDIA Graphics Cards

This module provides support for NVIDIA graphics cards using the proprietary NVIDIA driver.

## Supported Hardware

### GeForce Series
- GeForce 600 series and newer
- GeForce GTX 10/16/20 series
- GeForce RTX 20/30/40 series

### Professional
- Quadro series
- Tesla compute cards
- RTX A-series

## Features

- Proprietary NVIDIA driver (stable branch)
- Kernel mode setting
- Hardware video acceleration (NVENC/NVDEC)
- NVIDIA Settings GUI
- Wayland compatibility configurations
- Power management options (disabled by default)
- 32-bit library support for gaming/Wine/Steam
- DRM kernel mode setting

## Driver Version

By default, this module uses the stable driver. You can change to other versions:

```nix
package = config.boot.kernelPackages.nvidiaPackages.beta;
# or
package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
```

Available versions:
- `stable` - Latest stable (recommended)
- `beta` - Beta/new feature branch
- `legacy_470` - For older GPUs (Kepler)
- `legacy_390` - For very old GPUs
- `legacy_340` - For ancient GPUs

## Power Management

Power management is disabled by default for stability. To enable:

```nix
hardware.nvidia.powerManagement.enable = true;
```

For Turing and newer GPUs with fine-grained power management:

```nix
hardware.nvidia.powerManagement.finegrained = true;
```

## Open Source Kernel Module

For newer GPUs (Turing+), you can try the open-source kernel module:

```nix
hardware.nvidia.open = true;
```

## Usage

Import this module in your `hosts/nixos.nix`:
```nix
../modules/hardware/graphics-cards/nvidia
```

## Wayland Support

This module includes Wayland compatibility settings. If you experience cursor issues on Wayland, the `WLR_NO_HARDWARE_CURSORS=1` variable is already set.

## Testing

Check NVIDIA driver status:
```bash
nvidia-smi
```

Verify hardware acceleration:
```bash
vainfo
```

## Notes

- Requires `allowUnfree = true` in nixpkgs config (already set in flake.nix)
- May have issues with suspend/resume (disable power management if needed)
- For laptops with hybrid graphics, see NixOS wiki for Optimus/PRIME setup
