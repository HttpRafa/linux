{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.main-user;
in {
  options.main-user = {
    userName = lib.mkOption {
      default = "mainuser";
      description = "Username";
    };
    userDescription = lib.mkOption {
      default = "Main User";
      description = "Description of the user";
    };
  };

  config = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."${cfg.userName}" = {
      isNormalUser = true;
      description = cfg.userDescription;
      extraGroups = ["networkmanager" "wheel" "libvirtd" "docker" "dialout" "wireshark"];
      shell = pkgs.nushell;
      packages = with pkgs; []; # User packages
    };
    environment.shells = [pkgs.nushell];

    home-manager = {
      extraSpecialArgs = {inherit inputs;};
      backupFileExtension = "backup";
      users = {
        "${cfg.userName}" = import ../users/${cfg.userName}.nix;
      };
    };
  };
}
