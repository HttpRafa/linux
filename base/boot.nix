{
  lib,
  config,
  pkgs,
  ...
}: {
  # Change kernel to the zen kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Blacklist kernel modules.
  boot.blacklistedKernelModules = [
    "hid_nintendo" # Disable Nintendo Switch Controller support
  ];

  # Change kernel to the CachyOS kernel
  # boot.kernelPackages = pkgs.linuxPackages_cachyos;
  # chaotic.scx.enable = true; # by default uses scx_rustland scheduler
  # chaotic.scx.scheduler = "scx_rusty";

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    devices = ["nodev"];
    efiSupport = true;
    useOSProber = true;
  };
}
