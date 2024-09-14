{ ... }:

let
  # Open editor tab n with cmd+n
  genKeybinding = n: {
    key = "cmd+${toString n}";
    command = "workbench.action.openEditorAtIndex${toString n}";
  };
in
builtins.genList genKeybinding 9
