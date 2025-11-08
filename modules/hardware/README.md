# Hardware Modules

This directory contains hardware-specific configurations for NixOS, organized by category and manufacturer.

## Directory Structure

```
hardware/
├── graphics-cards/
│   ├── intel/          # Intel integrated and discrete GPUs
│   ├── amd/            # AMD Radeon GPUs
│   └── nvidia/         # NVIDIA GeForce/RTX GPUs
└── wifi-cards/
    ├── intel/          # Intel WiFi adapters
    ├── mediatek/       # MediaTek WiFi adapters
    ├── broadcom/       # Broadcom WiFi adapters
    └── realtek/        # Realtek WiFi adapters
```

## WiFi Cards

Choose **one** WiFi module based on your WiFi card manufacturer:

### `wifi-cards/intel`
For Intel WiFi cards (e.g., Intel Wireless 8265, AX200, AX210, etc.)
- Includes stability fixes for iwlwifi driver
- Configures power management and bus mastering
- Recommended backend: wpa_supplicant

### `wifi-cards/mediatek`
For MediaTek WiFi cards (e.g., MT7921, MT7922, MT76 series)
- Supports mt7921e and mt76 drivers
- Includes ASPM workarounds
- Works with most modern MediaTek cards

### `wifi-cards/broadcom`
For Broadcom WiFi cards
- Uses proprietary `wl` driver (broadcom_sta)
- Blacklists conflicting open-source drivers
- May require additional firmware for some models

### `wifi-cards/realtek`
For Realtek WiFi cards (e.g., RTL8822CE, RTL8852AE, RTW89 series)
- Supports rtw88 and rtw89 driver families
- Includes ASPM workarounds
- Modern driver support for newer Realtek cards

## Graphics Cards

Choose **one** GPU module based on your graphics card:

### `graphics-cards/intel`
For Intel integrated graphics (e.g., UHD, Iris Xe, Arc)
- Enables VA-API hardware acceleration
- Supports GuC/HuC firmware
- Includes 32-bit support for gaming
- OpenCL compute support

### `graphics-cards/amd`
For AMD graphics cards (Radeon, RX series)
- Enables AMDGPU driver
- Supports both RADV (Mesa) and AMDVLK drivers
- Hardware video acceleration
- ROCm OpenCL support
- Full power management features

### `graphics-cards/nvidia`
For NVIDIA graphics cards (GeForce, RTX series)
- Proprietary NVIDIA driver
- Hardware video acceleration
- Wayland compatibility settings
- Configurable power management
- NVIDIA Settings GUI included

## Usage

In your `hosts/nixos.nix`, uncomment only the modules that match your hardware:

```nix
imports = [
  # WiFi Cards - choose ONE
  ../modules/hardware/wifi-cards/intel
  # ../modules/hardware/wifi-cards/mediatek
  # ../modules/hardware/wifi-cards/broadcom
  # ../modules/hardware/wifi-cards/realtek

  # Graphics Cards - choose ONE (or none for server setups)
  # ../modules/hardware/graphics-cards/intel
  # ../modules/hardware/graphics-cards/amd
  # ../modules/hardware/graphics-cards/nvidia
];
```

## Detecting Your Hardware

To identify your WiFi card:
```bash
lspci | grep -i network
# or
lspci | grep -i wireless
```

To identify your GPU:
```bash
lspci | grep -i vga
# or
lspci | grep -i 3d
```

## Notes

- **WiFi**: Only enable ONE WiFi module to avoid conflicts
- **GPU**: Only enable ONE GPU module (for systems with multiple GPUs, enable the primary one)
- **Laptops with hybrid graphics**: You may need additional configuration for NVIDIA Optimus or AMD switchable graphics
- After changing hardware modules, rebuild with: `sudo nixos-rebuild switch --flake .#nixos`
