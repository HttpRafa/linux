{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.development;
in {
  options.software.development = {
    enable = lib.mkEnableOption "enable development software";
  };

  config = lib.mkIf cfg.enable {
    # Allow dotnet6 to be able to use godot mono / remove if https://github.com/NixOS/nixpkgs/issues/365975 is fixed
    nixpkgs.config.permittedInsecurePackages = [
      "dotnet-sdk-6.0.428"
    ];

    # List packages installed in system profile. To search, run:
    # $ nix search vim
    environment.systemPackages = with pkgs; [
      # IDEs
      #arduino-ide
      #jetbrains.gateway
      #android-studio

      # Engines
      ## C#
      dotnetCorePackages.dotnet_9.sdk

      ## Godot
      godot_4-mono

      # CI testing
      #act

      # File sharing
      filezilla # WinSCP alternative

      # API testing
      #postman

      # Redis
      #redisinsight

      # MongoDB
      #mongodb-compass

      # Minecraft
      #mcaselector
      #blockbench

      # Reverse Engineering
      #ghidra-bin

      # Linux headers
      #linuxHeaders
    ];
  };
}
