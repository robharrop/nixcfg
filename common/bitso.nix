{ config, pkgs, lib, inputs, home-manager, ... }:

let
  username = inputs.username;
in
{

  environment.systemPackages =
    with pkgs;[
      awscli2
      postgresql_15
    ];

  homebrew =
    {
      casks = [
        "1password"
        "1password-cli"
        "chromium"
        "gpg-suite"
        "microsoft-teams"
        "rancher"
        "sdm"
        "slack"
        "superhuman"
      ];
    };

  home-manager.users.${username} = { pkgs, ... }: {

    programs.git = {
      userEmail = "rob@bitso.com";

      signing = {
        key = "ACC3A3D8FD118EFB";
        signByDefault = true;
      };
    };

    home.sessionVariables = {
      # This is crappy and should be variable
      AWS_CA_BUNDLE = "/etc/ssl/certs/ca-certificates.crt";
    };

  };

  security.pki.certificateFiles = [
    inputs.cloudflare-cert.outPath
  ];
}
