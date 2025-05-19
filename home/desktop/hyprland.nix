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
      (catppuccin-kvantum.override {
        accent = "blue";
        variant = "mocha";
      })
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      papirus-folders
    ];

    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Mocha-Standard-Blue-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = ["blue"];
          size = "standard";
          variant = "mocha";
        };
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "mocha";
          accent = "blue";
        };
      };
      cursorTheme = {
        name = "Catppuccin-Mocha-Dark-Cursors";
        package = pkgs.catppuccin-cursors.mochaDark;
      };
      gtk3 = {
        extraConfig.gtk-application-prefer-dark-theme = true;
      };
    };

    home.pointerCursor = {
      gtk.enable = true;
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 16;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Catppuccin-Mocha-Standard-Blue-Dark";
        color-scheme = "prefer-dark";
      };

      # For Gnome shell
      "org/gnome/shell/extensions/user-theme" = {
        name = "Catppuccin-Mocha-Standard-Blue-Dark";
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };

    xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
      General.theme = "Catppuccin-Mocha-Blue";
    };

    # Enable hyprland home-manager module
    wayland.windowManager.hyprland = {
      # Whether to enable Hyprland wayland compositor
      enable = true;
      # Whether to enable XWayland
      xwayland.enable = true;
      # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
      package = null;
      portalPackage = null;

      settings = {
        # Programs
        "$terminal" = "kitty";
        "$fileManager" = "dolphin";
        "$menu" = "wofi --show drun";

        # Monitors
        monitor = [
          "DP-3, 1920x1080@120, -1920x0, 1"
          "DP-2, 1920x1080@120, 0x0, 1"
          "DP-1, 1920x1080@120, 1920x0, 1"
        ];

        # Env
        env = [
        ];

        # Autostart
        exec-once = ["waybar & hyprpaper"];

        # Keybindings
        "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

        bind = [
          # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
          "$mainMod, Q, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, F, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, X, exec, $menu"
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

        # Look and Feel
        # https://wiki.hyprland.org/Configuring/Variables/#general
        general = {
          gaps_in = 5;
          gaps_out = 20;

          border_size = 2;

          # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";

          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = false;

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = true;

          layout = "dwindle";
        };

        # https://wiki.hyprland.org/Configuring/Variables/#decoration
        decoration = {
          rounding = 10;
          rounding_power = 2;

          # Change transparency of focused and unfocused windows
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };

          # https://wiki.hyprland.org/Configuring/Variables/#blur
          blur = {
            enabled = true;
            size = 3;
            passes = 1;

            vibrancy = 0.1696;
          };
        };

        # https://wiki.hyprland.org/Configuring/Variables/#animations
        animations = {
          enabled = true;

          # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];

          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
          ];
        };

        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        dwindle = {
          pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # You probably want this
        };

        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        master = {
          new_status = "master";
        };

        # https://wiki.hyprland.org/Configuring/Variables/#misc
        misc = {
          force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
          disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
        };

        # Input
        input = {
          kb_layout = "de";
        };
      };
    };

    # Install waybar
    programs.waybar = {
      enable = true;
    };

    # Install wofi
    programs.wofi = {
      enable = true;
    };

    # Install hyprpaper
    services.hyprpaper = {
      enable = true;
    };
  };
}
