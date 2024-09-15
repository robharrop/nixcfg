{
  config,
  pkgs,
  lib,
  inputs,
  home-manager,
  ...
}:

let
  username = config.myConfig.username;
in
{

  myConfig = {
    email = "rob@bitso.com";
  };

  homebrew = {
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

  environment.systemPackages = with pkgs; [
    awscli2
    postgresql_15
  ];

  home-manager.users.${username} =
    { pkgs, ... }:
    {

      programs.git = {
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

  security.pki.certificateFiles = [ inputs.cloudflare-cert.outPath ];
}
