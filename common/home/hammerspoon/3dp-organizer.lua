-- Auto-organize 3D printing files from Downloads to ~/Documents/3DP

local M = {}

local downloadsPath = os.getenv("HOME") .. "/Downloads/"
local targetPath = os.getenv("HOME") .. "/Documents/3DP/"
local logger = hs.logger.new('3dp-organizer', 'info')

-- Common 3D printing file extensions (case-insensitive patterns)
local extensions = {
  "%.[sS][tT][lL]$",
  "%.[3][mM][fF]$",
  "%.[oO][bB][jJ]$",
  "%.[gG][cC][oO][dD][eE]$",
  "%.[gG][cC][oO]$"
}

local function matches3DPFile(filename)
  for _, pattern in ipairs(extensions) do
    if filename:match(pattern) then
      return true
    end
  end
  return false
end

local function process3DPFile(file)
  -- Only process 3D printing files
  if not matches3DPFile(file) then
    return
  end

  -- Only trigger if the file exists
  if not hs.fs.attributes(file) then
    return
  end

  -- Ensure target directory exists
  hs.fs.mkdir(targetPath)

  -- Extract filename from full path
  local filename = file:match("([^/]+)$")
  local destination = targetPath .. filename

  -- Check if destination already exists
  if hs.fs.attributes(destination) then
    logger.w("File already exists in 3DP folder:", filename)
    return
  end

  -- Move the file
  local success, error = os.rename(file, destination)
  if success then
    logger.i("Moved to 3DP folder:", filename)
  else
    logger.e("Failed to move:", filename, error)
  end
end

local function organize3DPFiles(files)
  for _, file in pairs(files) do
    process3DPFile(file)
  end
end

local function manualOrganize()
  logger.i("Manual organization triggered")
  local count = 0

  -- Get all files in Downloads directory
  local iter, dir = hs.fs.dir(downloadsPath)
  if not iter then
    logger.e("Failed to read Downloads directory")
    return
  end

  for file in iter, dir do
    if file ~= "." and file ~= ".." then
      local fullPath = downloadsPath .. file
      if matches3DPFile(fullPath) then
        process3DPFile(fullPath)
        count = count + 1
      end
    end
  end

  hs.alert.show(string.format("Organized %d 3DP file(s)", count))
end

function M.start()
  hs.pathwatcher.new(downloadsPath, organize3DPFiles):start()

  -- Bind Cmd+Alt+Ctrl+3 to manually trigger organization
  hs.hotkey.bind({"cmd", "alt", "ctrl"}, "3", manualOrganize)

  logger.i("Started watching for 3D printing files")
  logger.i("Press Cmd+Alt+Ctrl+3 to manually organize existing files")
end

return M
