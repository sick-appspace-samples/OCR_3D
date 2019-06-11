local deco = require('Decorations')

--@processOCR(hMap: Image, iMap: Image, object: string)
local function processOCR(hMap, iMap, object, viewer)

  -- Variables
  local rectangle, pixelRegion, pixelRegionOCR, imageBinarized, parameters, fontClassifier

  -- Visualize original image
  viewer:clear()
  local viewerID = viewer:addHeightmap({hMap, iMap}, deco.imDeco)
  viewer:present()
  Script.sleep(2000)

  if object == 'Black Plastic' then
    -- Create a rectangle
    rectangle = Shape3D.createRectangle(7.76, 3.82, Transform.createTranslation3D(11.78, 35.72, 50.19))
    -- Create a pixel region inside the rectangle
    pixelRegion = Shape3D.toPixelRegion(rectangle, hMap)
    -- Threshold and binarize
    pixelRegionOCR = hMap:threshold(50.125, 51, pixelRegion)
    imageBinarized = hMap:binarize(50.125, 51, 255, pixelRegion)
    parameters = '^[A-Z]{2}[0-9]{1}$'
    fontClassifier = deco.fontClassifierPlastic
  elseif object == 'White Card' then
    -- Create a rectangle
    rectangle = Shape3D.createRectangle(61.5, 6.98, Transform.createTranslation3D(-4.60, 31.38, 39))
    -- Create a pixel region inside the rectangle
    pixelRegion = Shape3D.toPixelRegion(rectangle, hMap)
    -- Threshold and binarize
    pixelRegionOCR = hMap:threshold(39.07, 40, pixelRegion)
    imageBinarized = hMap:binarize(39.07, 40, 255, pixelRegion)
    parameters = '^[0-9]{16}$'
    fontClassifier = deco.fontClassifierCard
  end

  -- Invert, erode and dilate the binarized image
  local imageInvert = imageBinarized:invert()
  local pixelRegionErode = pixelRegionOCR:erode(3)
  local pixelRegionDilate = pixelRegionErode:dilate(5)

  -- Visualization of the rectangle
  viewer:addShape(rectangle, deco.planeDeco)
  viewer:present()
  Script.sleep(2000)

  -- Visualization of the pixel region containing the characters
  viewer:addPixelRegion(pixelRegionDilate, deco.decRegion, nil, viewerID) -- Add to 3D viewer
  viewer:present()
  Script.sleep(2000)

  -- Find blobs
  local blobs = pixelRegionDilate:findConnected(200)

  -- Sorting pixelregion from left to right
  local filter = Image.PixelRegion.Filter.create()
  filter:sortBy('CENTROIDX')
  blobs = filter:apply(blobs, hMap)

  -- Classify the characters in the image
  local characters, _, _ = fontClassifier:classifyCharacters(blobs, imageInvert, parameters)
  print(characters)
  Script.sleep(4000)
end

-- Return scoped functions
return {process = processOCR}
