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
          };
        };
        default = { };
        description = "My custom configuration options";
      };
    };
  }
)
