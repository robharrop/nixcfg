{ pkgs, lib, ... }:
{
  programs.nixvim = {
    enable = true;

    colorschemes.dracula.enable = true;

    globalOpts = {

      # Line numbers
      number = true;
      relativenumber = true;

      # Always show the signcolumn, otherwise text would be shifted when displaying error icons
      signcolumn = "yes";

      cursorline = true;
      ruler = true;

      # Search
      ignorecase = true;
      smartcase = true;

      # Tab defaults (might get overwritten by an LSP server)
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 0;
      expandtab = true;
      smarttab = true;

    };

    globals = {
      mapleader = " ";
    };

    keymaps = [
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>fw";
      }
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>ff";
      }
      {
        action = "<cmd>Telescope git_commits<CR>";
        key = "<leader>fg";
      }

      {
        mode = "n";
        action = "<cmd>BufferLineCycleNext<CR>";
        key = "]]";
      }
      {
        mode = "n";
        action = "<cmd>BufferLineCyclePrev<CR>";
        key = "[[";
      }
      {
        mode = "n";
        action = "<cmd>Neotree toggle<CR>";
        key = "<leader>e";
      }
    ];

    plugins = {
      conform-nvim = {
        enable = true;

        formattersByFt = {
          nix = [ "nixfmt" ];
        };

        formatters = {
          nixfmt = {
            command = "${lib.getExe pkgs.nixfmt-rfc-style}";
          };
        };
      };

      neo-tree.enable = true;
      lualine.enable = true;
      bufferline.enable = true;
      lsp = {
        enable = true;

        servers = {
          bashls.enable = true;
          nixd.enable = true;
          pyright.enable = true;
        };
      };
      telescope.enable = true;
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          json
          lua
          make
          markdown
          nix
          python
          regex
          ruby
          toml
          vim
          vimdoc
          xml
          yaml
        ];
      };
      which-key.enable = true;
    };
  };
}
