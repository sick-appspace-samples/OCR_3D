local OCRProcessing = require('OCRProcessing')

--Start of Global Scope---------------------------------------------------------
print('AppEngine Version: ' .. Engine.getVersion())

local viewer = View.create() -- Will show in 3D viewer

--End of Global Scope-----------------------------------------------------------

-- Start of Function and Event Scope--------------------------------------------

local function main()
  viewer:clear()

  -- Load a json-image

  -- Black plastic
  local data1 = Object.load('resources/image_34.json')
  local heightMap1 = data1[1]
  local intensityMap1 = data1[2]
  --local sensorData1 = data1[3]

  --White card
  local data2 = Object.load('resources/image_42.json')
  local heightMap2 = data2[1]
  local intensityMap2 = data2[2]
  --local sensorData2 = data2[3]

  -- Find OCR in image
  OCRProcessing.process(heightMap1, intensityMap1, 'Black Plastic', viewer)
  OCRProcessing.process(heightMap2, intensityMap2, 'White Card', viewer)

  print('App finished.')
end

--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

--End of Function and Event Scope--------------------------------------------------
