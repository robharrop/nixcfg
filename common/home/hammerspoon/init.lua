-- Hammerspoon Configuration
hs.alert.show("Config loaded")

-- Reload config automatically when any file in ~/.hammerspoon/ changes
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()

-- Reload config with Cmd+Alt+Ctrl+R
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

-- Load modules
local heicConverter = require("heic-converter")
heicConverter.start()
