-- Auto-convert HEIC images in Downloads to JPG

local M = {}

local downloadsPath = os.getenv("HOME") .. "/Downloads/"
local heicPattern = "%.[hH][eE][iI][cC]$"
local logger = hs.logger.new('heic-converter', 'info')

local function processHEICFile(file)
  -- Only process HEIC files
  if not file:match(heicPattern) then
    return
  end

  -- Only trigger if the file exists, we get triggered for deletions too
  if not hs.fs.attributes(file) then
    return
  end

  local outputFile = file:gsub(heicPattern, ".jpg")

  -- Only convert if JPG doesn't already exist
  if hs.fs.attributes(outputFile) then
    return
  end

  -- Use sips (built-in macOS image conversion tool)
  local command = string.format('sips -s format jpeg "%s" --out "%s"', file, outputFile)
  hs.task.new("/bin/sh", function(exitCode, stdOut, stdErr)
    if exitCode == 0 then
      logger.i("Converted:", file)
    else
      logger.e("Failed to convert:", file, stdErr)
    end
  end, {"-c", command}):start()
end

local function convertHEIC(files)
  logger.d("Files changed:", hs.inspect(files))
  for _, file in pairs(files) do
    processHEICFile(file)
  end
end

function M.start()
  hs.pathwatcher.new(downloadsPath, convertHEIC):start()
end

return M
