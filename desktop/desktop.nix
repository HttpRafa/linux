{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./kde.nix
    ./hyprland.nix
    ./displayManager/sddm.nix
    ./displayManager/lightdm.nix
  ];
}
