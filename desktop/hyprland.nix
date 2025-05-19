{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.desktop.hyprland;
in {
  imports = [
    ./displayManager/sddm.nix
  ];

  options.desktop.hyprland = {
    enable = lib.mkEnableOption "enable hyprland desktop";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      # Enable hyprland
      enable = true;
      # Whether to enable XWayland
      xwayland.enable = true;
      # UWSM
      withUWSM = true;
    };

    environment.systemPackages = with pkgs; [
      kitty # Terminal Emulator

      # KDE packages
      kdePackages.dolphin
    ];
  };
}
