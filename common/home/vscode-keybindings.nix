{ ... }:

let
  # Open editor tab n with cmd+n
  genKeybinding = n: {
    key = "cmd+${toString n}";
    command = "workbench.action.openEditorAtIndex${toString n}";
  };
in
[
  {
    key = "ctrl+t";
    command = "go.test.file";
    when = "editorTextFocus && editorLangId == go";
  }
]
++ builtins.genList genKeybinding 9
