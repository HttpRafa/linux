{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.software.homelab;
in {
  options.software.homelab = {
    enable = lib.mkEnableOption "enable homelab software";
  };

  config = lib.mkIf cfg.enable {
    # List packages installed in system profile. To search, run:
    # $ nix search vim
    environment.systemPackages = with pkgs; [
      # Kubernetes
      kubectl
      kubernetes-helm

      # Terraform
      #terraform
      #cf-terraforming

      # 3D Printing
      # blender
      bambu-studio

      # Raspberry PI
      #rpi-imager

      # Networking
      #wireshark
    ];

    # Install wireshark
    programs.wireshark.enable = false;
  };
}
