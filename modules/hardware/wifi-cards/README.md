# WiFi Cards

Hardware support modules for various WiFi card manufacturers.

## Available Modules

### Intel (`intel/`)
- **Supported Cards**: Intel Wireless 8265, AX200, AX210, AX211, BE200, etc.
- **Driver**: iwlwifi
- **Features**: 
  - Power management optimization
  - Bus mastering fixes
  - Bluetooth coexistence settings
  - Stability improvements

### MediaTek (`mediatek/`)
- **Supported Cards**: MT7921, MT7922, MT76xx series
- **Driver**: mt7921e, mt76
- **Features**:
  - ASPM workarounds
  - Modern WiFi 6/6E support
  - Power efficiency optimizations

### Broadcom (`broadcom/`)
- **Supported Cards**: BCM43xx series
- **Driver**: wl (proprietary broadcom_sta)
- **Features**:
  - Proprietary driver for better compatibility
  - Blacklists conflicting open-source drivers
  - Firmware loading support

### Realtek (`realtek/`)
- **Supported Cards**: RTL8822CE, RTL8852AE, RTW88/RTW89 series
- **Driver**: rtw88_pci, rtw89_pci
- **Features**:
  - Modern driver support
  - WiFi 6 compatibility
  - ASPM workarounds

## How to Choose

1. **Identify your WiFi card**:
   ```bash
   lspci | grep -i network
   # or
   lspci | grep -i wireless
   ```

2. **Look for the manufacturer** in the output:
   - Intel: `Intel Corporation Wireless`
   - MediaTek: `MediaTek Inc.` or `MEDIATEK Corp.`
   - Broadcom: `Broadcom Inc.` or `Broadcom Corporation`
   - Realtek: `Realtek Semiconductor Co., Ltd.`

3. **Import the corresponding module** in `hosts/nixos.nix`:
   ```nix
   ../modules/hardware/wifi-cards/intel
   ```

## Notes

- Only enable **ONE** WiFi module at a time
- All modules use NetworkManager with wpa_supplicant backend
- WiFi power saving is disabled by default for stability
- See individual module files for specific configuration options
