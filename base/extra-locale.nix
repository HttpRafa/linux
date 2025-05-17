{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra-locate;
in {
  options.extra-locate = lib.mkOption {
    default = "en_US.UTF-8";
    description = ''
      extraLocaleSettings
    '';
  };

  config = {
    i18n.extraLocaleSettings = {
      LC_ALL = cfg; # Set all LC_*
      LC_CTYPE = cfg;
      LC_ADDRESS = cfg;
      LC_MEASUREMENT = cfg;
      LC_MESSAGES = cfg;
      LC_MONETARY = cfg;
      LC_NAME = cfg;
      LC_NUMERIC = cfg;
      LC_PAPER = cfg;
      LC_TELEPHONE = cfg;
      LC_TIME = cfg;
      LC_COLLATE = cfg;
    };
  };
}
