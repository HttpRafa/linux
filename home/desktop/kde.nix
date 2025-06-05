{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.home.kde;

  custom-wallpaper = builtins.path {
    path = ../../wallpaper/${cfg.background};
  };
in {
  options.software.home.kde = {
    enable = lib.mkEnableOption "enable kde customizations";
    background = lib.mkOption {
      default = false;
      description = "Background image to use";
      type = with lib.types; uniq str;
    };
    theme = lib.mkOption {
      default = false;
      description = "Theme to use";
      type = with lib.types; uniq str;
    };
    iconTheme = lib.mkOption {
      default = false;
      description = "Icontheme to use";
      type = with lib.types; uniq str;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      papirus-icon-theme # Install Papirus icon theme
      nordic # Install Nordic theme
      #(callPackage ../../nixpkgs/pkgs/monochrome-kde-theme.nix {inherit pkgs;}) # Install Monochrome theme
    ];

    programs.plasma = {
      enable = true;

      workspace = {
        clickItemTo = "select";
        theme = cfg.theme;
        colorScheme = cfg.theme;
        lookAndFeel = cfg.theme;
        iconTheme = cfg.iconTheme;
        wallpaper = custom-wallpaper;
      };

      kwin = {
        effects = {
          shakeCursor.enable = false;
        };
      };

      configFile = {
        kscreenlockerrc = {
          Greeter.WallpaperPlugin = "org.kde.image";
          "Greeter/Wallpaper/org.kde.image/General".Image = custom-wallpaper;
        };
      };
    };
  };
}
