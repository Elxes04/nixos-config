# Intel Graphics Cards

This module provides support for Intel integrated and discrete graphics using the `i915` driver.

## Supported Hardware

### Integrated Graphics
- Intel HD Graphics (Gen 7+)
- Intel UHD Graphics (Gen 9+)
- Intel Iris Graphics
- Intel Iris Xe Graphics (Gen 12+)

### Discrete Graphics
- Intel Arc A-series (A380, A750, A770)

## Features

- VA-API hardware video acceleration
- GuC/HuC firmware support for improved performance
- Intel iHD media driver (newer GPUs)
- Intel i965 VA-API driver (legacy support)
- OpenCL compute support via intel-compute-runtime
- Frame Buffer Compression (FBC)
- 32-bit library support for gaming/Wine/Steam

## Video Acceleration

The module sets `LIBVA_DRIVER_NAME=iHd` for modern Intel GPUs. If you experience issues, you can switch to the legacy driver:

```nix
environment.sessionVariables.LIBVA_DRIVER_NAME = "i965";
```

## Usage

Import this module in your `hosts/nixos.nix`:
```nix
../modules/hardware/graphics-cards/intel
```

## Testing

Verify hardware acceleration:
```bash
vainfo
```
