# MediaTek WiFi Cards

This module provides support for MediaTek WiFi cards using the `mt76` and `mt7921e` drivers.

## Supported Hardware

- MT7921 (WiFi 6)
- MT7922 (WiFi 6E)
- MT7615
- MT7663
- MT7668
- MT76xx series

## Features

- Modern WiFi 6/6E support
- ASPM workaround for stability
- Power efficiency optimizations
- Kernel module configuration

## Usage

Import this module in your `hosts/nixos.nix`:
```nix
../modules/hardware/wifi-cards/mediatek
```
