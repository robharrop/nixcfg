{...}: {
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
    neo-tree.enable = true;
      lualine.enable = true;
      bufferline.enable = true;
      telescope.enable = true;
      which-key.enable = true;
    };
  }
