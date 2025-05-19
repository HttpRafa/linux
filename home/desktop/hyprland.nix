{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.home.hyprland;

  spacecraft-wallpaper = builtins.path {
    path = ../wallpaper/${cfg.background};
  };
in {
  options.software.home.hyprland = {
    enable = lib.mkEnableOption "enable hyprland customizations";
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
      (callPackage ../../nixpkgs/pkgs/monochrome-kde-theme.nix {inherit pkgs;}) # Install Monochrome theme
    ];

    # Enable hyprland home-manager module
    wayland.windowManager.hyprland = {
      # Whether to enable Hyprland wayland compositor
      enable = true;
      # Whether to enable XWayland
      xwayland.enable = true;

      settings = {
        # Programs
        "$terminal" = "kitty";
        "$fileManager" = "dolphin";
        "$menu" = "wofi --show drun";

        # Autostart
        exec-once = ["waybar"];

        # Keybindings
        "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

        bind = [
          # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
          "$mainMod, Q, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, $menu"
          "$mainMod, P, pseudo"
          "$mainMod, J, togglesplit"

          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
        ];

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        # Input
        input = {
          kb_layout = "de";
        };
      };
    };

    # Install waybar and the wallpaper
    programs.waybar = {
      enable = true;
    };

    programs.wofi = {
      enable = true;
    };
  };
}
