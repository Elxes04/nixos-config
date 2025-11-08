# Graphics Cards

Hardware support modules for various GPU manufacturers.

## Available Modules

### Intel (`intel/`)
- **Supported GPUs**: 
  - Integrated: UHD Graphics, Iris Xe, Iris Plus
  - Discrete: Arc A-series (A380, A750, A770)
- **Driver**: i915 (kernel), intel-media-driver (userspace)
- **Features**:
  - VA-API hardware video acceleration
  - GuC/HuC firmware support
  - OpenCL compute support
  - 32-bit library support for gaming

### AMD (`amd/`)
- **Supported GPUs**: 
  - Radeon HD 7000 and newer
  - RX 400/500/5000/6000/7000 series
  - Radeon Pro series
- **Driver**: amdgpu (kernel), RADV/AMDVLK (Vulkan)
- **Features**:
  - Open-source RADV (Mesa) Vulkan driver
  - Official AMDVLK Vulkan driver option
  - ROCm OpenCL support
  - Full power management (ppfeaturemask)
  - Hardware video acceleration
  - 32-bit library support for gaming

### NVIDIA (`nvidia/`)
- **Supported GPUs**: 
  - GeForce 600 series and newer
  - RTX 20/30/40 series
  - Quadro/Tesla professional cards
- **Driver**: nvidia (proprietary)
- **Features**:
  - Latest stable NVIDIA driver
  - Hardware video acceleration
  - NVIDIA Settings GUI
  - Wayland compatibility settings
  - Configurable power management
  - 32-bit library support for gaming

## How to Choose

1. **Identify your GPU**:
   ```bash
   lspci | grep -i vga
   # or for detailed info
   lspci | grep -i '3d\|vga'
   ```

2. **Look for the manufacturer** in the output:
   - Intel: `Intel Corporation` (usually integrated)
   - AMD: `Advanced Micro Devices, Inc. [AMD/ATI]`
   - NVIDIA: `NVIDIA Corporation`

3. **Import the corresponding module** in `hosts/nixos.nix`:
   ```nix
   ../modules/hardware/graphics-cards/amd
   ```

## Special Cases

### Laptop with Hybrid Graphics (NVIDIA Optimus)
For laptops with both Intel/AMD integrated + NVIDIA discrete GPU:
- Consider using NVIDIA PRIME or optimus-manager
- You may need to enable both modules with special configuration
- See NixOS wiki for hybrid graphics setup

### Multiple GPUs (Desktop)
- Enable the module for your primary GPU
- For multi-GPU setups (e.g., gaming + rendering), you may need custom configuration

### Server/Headless Systems
- No GPU module needed for headless servers
- Keep all GPU modules commented out

## Notes

- Only enable **ONE** GPU module in most cases
- All modules include hardware acceleration support
- 32-bit support is enabled for Steam/Wine compatibility
- NVIDIA requires proprietary drivers (unfree packages must be allowed)
- AMD and Intel use fully open-source drivers
