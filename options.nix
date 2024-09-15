(
  { lib, ... }:
  {
    options = {
      myConfig = lib.mkOption {
        type = lib.types.submodule {
          options = {
            username = lib.mkOption {
              type = lib.types.str;
              default = "robharrop";
              description = "Username for primary user account";
            };

            name = lib.mkOption {
              type = lib.types.str;
              default = "Rob Harrop";
              description = "Full name of primary user account";
            };

            email = lib.mkOption {
              type = lib.types.str;
              default = "rob@robharrop.dev";
              description = "Email address for primary user account";
            };

            homebrew = lib.mkOption {
              type = lib.types.submodule {
                options = {
                  extraCasks = lib.mkOption {
                    type = lib.types.listOf lib.types.str;
                    default = [ ];
                    description = "List of additional Homebrew casks to install";
                  };
                };
              };
              default = { };
              description = "Homebrew configuration options";
            };
          };
        };
        default = { };
        description = "My custom configuration options";
      };
    };
  }
)
