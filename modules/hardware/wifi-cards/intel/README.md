# Intel WiFi Cards

This module provides support for Intel WiFi cards using the `iwlwifi` driver.

## Supported Hardware

- Intel Wireless 3160/3165/3168
- Intel Wireless 7260/7265
- Intel Wireless 8260/8265
- Intel Wireless 9260/9560
- Intel Wi-Fi 6 AX200/AX201/AX210/AX211
- Intel Wi-Fi 6E AX210/AX211
- Intel Wi-Fi 7 BE200

## Features

- Stability fixes for iwlwifi driver
- Power management optimization
- PCI bus mastering configuration
- Bluetooth coexistence settings
- 802.11n/ac/ax support

## Usage

Import this module in your `hosts/nixos.nix`:
```nix
../modules/hardware/wifi-cards/intel
```
