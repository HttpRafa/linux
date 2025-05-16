{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra-locate;
in {
  options.extra-locate = lib.mkOption {
    default = "de_DE.UTF-8";
    description = ''
      extraLocaleSettings
    '';
  };

  config = {
    i18n.extraLocaleSettings = {
      LC_ADDRESS = cfg;
      LC_IDENTIFICATION = cfg;
      LC_MEASUREMENT = cfg;
      LC_MONETARY = cfg;
      LC_NAME = cfg;
      LC_NUMERIC = cfg;
      LC_PAPER = cfg;
      LC_TELEPHONE = cfg;
      LC_TIME = cfg;
    };
  };
}
