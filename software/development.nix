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

      # 3D Modelling
      blender

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
