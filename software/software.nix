{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./sound.nix
    ./gaming.nix
    ./vpn.nix
    ./development.nix
    ./homelab.nix
    ./virtualization/virtualization.nix
    ./application/uxplay.nix
    ./application/ollama.nix
    ./application/obs.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search <some package>
  environment.systemPackages = with pkgs; [
    # Appimages
    appimage-run

    # File sharing
    localsend # AirDrop alternative

    # Editors
    kdePackages.kate
    #obsidian

    # Media editors/players
    mpv # Best media player on linux
    #ffmpeg-full # Video editor
    gimp3 # Picture editor
    #scrcpy

    # Networking
    # ciscoPacketTracer8

    # Chat/Voice clients
    vesktop # Discord but better
    discord
    teamspeak6-client
    # Matrix Client: element-desktop

    # E-Mail clients
    # thunderbird
    protonmail-desktop

    # Music
    spotify

    # Webbrowser
    google-chrome
    #firefox

    # Libreoffice with spell checking for english and german
    #libreoffice-qt6-fresh
    #hunspell
    #hunspellDicts.en_US
    #hunspellDicts.de_DE

    # Yubikey
    yubioath-flutter

    # Disk tools
    #mediawriter
    #parted

    # This is required to be a linux user
    fastfetch
    btop
    nvtopPackages.full
  ];

  # Change some chromium settings
  programs.chromium = {
    enable = true;
    enablePlasmaBrowserIntegration = true;
    extensions = [
      "cimiefiiaegbelhefglklhhakcgmhkai" # Plasma Browser Integration
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden PasswordManager
      "bkkmolkhemgaeaeggcmfbghljjjoofoh" # Catppuccin Chrome Theme - Mocha Theme
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "gebbhagfogifgggkldgodflihgfeippi" # Return YouTube Dislike
      "ifbmcpbgkhlpfcodhjhdbllhiaomkdej" # Office - Enable Copy and Paste
    ];
    extraOpts = {
      "SyncDisabled" = true;
      "PasswordManagerEnabled" = false;
      "BuiltInDnsClientEnabled" = false;
      "CloudPrintSubmitEnabled" = false;
    };
  };

  # Install Ladybird
  programs.ladybird.enable = false;

  # Install partition manager
  programs.partition-manager.enable = true;

  # Install OpenRGB and other tools
  services.hardware.openrgb.enable = true;
  #services.ratbagd.enable = true;

  # Enable pcscd service
  services.pcscd.enable = true;

  # Enable flatpak
  services.flatpak.enable = true;

  # Run unpatched dynamic binaries
  programs.nix-ld.enable = true;
}
