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

    programs.zsh = {
      initExtra = ''
        export AWS_CA_BUNDLE="$NIX_SSL_CERT_FILE"
      '';
    };
  };

  security.pki.certificateFiles = [
    inputs.cloudflare-cert.outPath
  ];
}
