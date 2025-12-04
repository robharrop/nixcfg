# nixcfg

Nix Darwin configuration for macOS machines.

## Directory Structure

### `flake.nix`
Entry point. Defines inputs (nixpkgs, home-manager, etc.) and builds two machine configurations: `robharrop-mac` (work with meta.nix) and `vetinari` (personal with personal.nix).

### `common/`
Configuration shared across machines.

#### `common/darwin/`
Darwin system-level configuration. Things that affect the entire system.

- `homebrew/` - Homebrew packages and casks
- `system.nix` - macOS system settings (dock, keyboard, screensaver)
- `vim/` - Neovim configuration via NixVim

#### `common/home/`
Home Manager configuration. Things that affect your user account.

Each file configures one program:
- `direnv.nix` - Directory-specific environments
- `eza.nix` - Modern ls replacement
- `fzf.nix` - Fuzzy finder
- `gh.nix` - GitHub CLI
- `git.nix` - Git configuration
- `kitty.nix` - Terminal emulator
- `starship.nix` - Shell prompt
- `vscode.nix` - VS Code and extensions
- `vscode-keybindings.nix` - VS Code keybindings (data file)
- `vscode-settings.nix` - VS Code settings (data file)
- `zsh.nix` - Shell configuration

#### `common/shared/`
Utilities and helpers. Not configuration modules.

- `options.nix` - Custom options like username, email, etc.

#### `common/*.nix`
- `darwin.nix` - Main Darwin configuration that imports everything
- `personal.nix` - Extra config for personal machine (homebrew casks, packages)
- `meta.nix` - Extra config for work machine (homebrew casks)

## Building

```bash
# Build configuration
darwin-rebuild build --flake .

# Build and activate
darwin-rebuild switch --flake .

# Build specific host
darwin-rebuild switch --flake .#vetinari
```

## Adding New Configuration

### Add a new program to Home Manager
1. Create a new file in `common/home/`, e.g., `common/home/tmux.nix`
2. Add module structure:
   ```nix
   { ... }:
   {
     programs.tmux = {
       enable = true;
       # ... config here
     };
   }
   ```
3. Import it in `common/darwin.nix` under `home-manager.users.${username}.imports`

### Add a new Darwin system setting
1. Create a new file in `common/darwin/`, e.g., `common/darwin/fonts.nix`
2. Add module structure with system-level options
3. Import it in `common/darwin.nix` under the top-level `imports`

## Patterns Used

### Module imports
Use `imports = []` for all modules. Don't call modules as functions unless they need parameters.

### Data imports
Use plain `import ./file.nix` for data files like settings and keybindings.

### Function imports
Use `import ./file.nix { inherit pkgs inputs; }` when a module needs specific parameters.

### Accessing Darwin config from Home Manager
Use `osConfig.myConfig.username` instead of `config.myConfig.username` to access system-level options from within Home Manager modules.

## Notes

- All files must be tracked by git for Nix flakes to see them
- Use `git add` before building when adding new files
- The configuration uses `allowUnfree = true` for packages with non-free licenses
- Some unfree VS Code extensions must be installed manually via the VS Code marketplace
