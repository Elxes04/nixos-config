# Broadcom WiFi Cards

This module provides support for Broadcom WiFi cards using the proprietary `wl` driver.

## Supported Hardware

- BCM4311, BCM4312, BCM4313
- BCM4321, BCM4322
- BCM4331, BCM4352, BCM4360
- BCM43142, BCM43228, BCM43602
- And other BCM43xx series cards

## Features

- Proprietary Broadcom STA driver (`wl`)
- Blacklists conflicting open-source drivers (b43, bcma, ssb)
- Better compatibility than open-source alternatives
- Supports both PCIe and USB variants

## Usage

Import this module in your `hosts/nixos.nix`:
```nix
../modules/hardware/wifi-cards/broadcom
```

## Notes

This module uses the proprietary Broadcom driver which may provide better stability than the open-source alternatives for certain cards.
