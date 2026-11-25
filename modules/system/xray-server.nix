
{ config, pkgs, ... }:

{
  environment.etc."xray/config.json".text = builtins.toJSON {
    log = {
      loglevel = "warning";
    };

    inbounds = [
      {
        listen = "0.0.0.0";
        port = 443;
        protocol = "vless";

        settings = {
          clients = [
            {
              id = "ada5be60-00b9-4df3-b1df-86a2ba248ae8";
              flow = "xtls-rprx-vision";
            }
          ];
          decryption = "none";
        };

        streamSettings = {
          network = "raw";
          security = "reality";

          realitySettings = {
            show = false;
            target = "www.microsoft.com:443";
            xver = 0;

            serverNames = [ "www.microsoft.com" ];

            privateKey = "gFZJLMEXkItpeQEyC1sqda-YFb5WFdftFn9aFQ7UxmY";
            shortIds = [ "623ec6e6c5720b2b" ];
          };
        };
      }
    ];

    outbounds = [
      {
        protocol = "freedom";
        tag = "direct";
      }
    ];
  };

  environment.systemPackages = [ pkgs.xray ];

  networking.firewall.allowedTCPPorts = [ 443 ];

  systemd.services.xray-server = {
    description = "Xray VLESS REALITY server";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      ExecStart =
        "${pkgs.xray}/bin/xray run -config /etc/xray/config.json";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
