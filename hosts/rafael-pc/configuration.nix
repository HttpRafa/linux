# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./host.nix
    ../../base/base.nix
    ../../software/software.nix
    ../../desktop/desktop.nix
    inputs.home-manager.nixosModules.default # Home manager
  ];

  # Select desktop
  desktop.kde.enable = true;
  displayManager.sddm.enable = true;

  # Software
  software.development.enable = true; # Enable jetbrains etc
  software.gaming.enable = true; # Enable steam und lutris
  software.vpn.enable = true; # Enable mullvad and other tools

  # Set username
  main-user.userName = "rafael";
  main-user.userDescription = "Rafael";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Set extraLocaleSettings option
  extra-locate = "de_DE.UTF-8";

  # Configure console keymap
  console.keyMap = "de";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Firewall
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
