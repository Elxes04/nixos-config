# AMD Graphics Cards

This module provides support for AMD graphics cards using the `amdgpu` driver.

## Supported Hardware

### Radeon HD Series
- Radeon HD 7000 series and newer (GCN 1.0+)

### Radeon RX Series
- RX 400/500 (Polaris)
- RX 5000 (RDNA 1)
- RX 6000 (RDNA 2)
- RX 7000 (RDNA 3)

### Professional
- Radeon Pro WX series
- Radeon Pro W series

## Features

- Open-source AMDGPU kernel driver
- RADV (Mesa) Vulkan driver (default, recommended)
- AMDVLK (AMD official) Vulkan driver (alternative)
- ROCm OpenCL support for compute workloads
- Full power management features (ppfeaturemask)
- Hardware video acceleration
- 32-bit library support for gaming/Wine/Steam

## Vulkan Driver Selection

By default, this module uses AMDVLK. To switch to RADV (Mesa), edit the module and uncomment:

```nix
AMD_VULKAN_ICD = "RADV";
```

RADV generally provides better gaming performance, while AMDVLK may be more stable for some applications.

## Usage

Import this module in your `hosts/nixos.nix`:
```nix
../modules/hardware/graphics-cards/amd
```

## Testing

Verify Vulkan support:
```bash
vulkaninfo | grep -i amd
```

Check hardware acceleration:
```bash
vainfo
```
