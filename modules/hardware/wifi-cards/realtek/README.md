# Realtek WiFi Cards

This module provides support for Realtek WiFi cards using the `rtw88` and `rtw89` drivers.

## Supported Hardware

### RTW88 Series (WiFi 5/802.11ac)
- RTL8822BE, RTL8822CE
- RTL8821CE
- RTL8723DE

### RTW89 Series (WiFi 6/802.11ax)
- RTL8852AE (WiFi 6)
- RTL8852BE (WiFi 6)
- RTL8852CE (WiFi 6E)

## Features

- Modern driver support for WiFi 5/6/6E
- ASPM workarounds for stability
- Power management configuration
- Supports both PCIe variants

## Usage

Import this module in your `hosts/nixos.nix`:
```nix
../modules/hardware/wifi-cards/realtek
```

## Notes

This module uses the modern `rtw88`/`rtw89` drivers. For older Realtek cards (RTL8188, RTL8192), you may need additional configuration.
