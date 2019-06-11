-- Decorations
local decRegion = View.PixelRegionDecoration.create()
decRegion:setColor(250, 0, 0, 100)

local planeDeco = View.ShapeDecoration.create()
planeDeco:setFillColor(0, 255, 255, 80)
planeDeco:setLineColor(0, 255, 255)
planeDeco:setLineWidth(3)

-- Creating classifier and select font
local fontClassifierPlastic = Image.OCR.Halcon.FontClassifier.create()
fontClassifierPlastic:setFont('INDUSTRIAL_0_9A_Z_NOREJ')
local fontClassifierCard = Image.OCR.Halcon.FontClassifier.create()
fontClassifierCard:setFont('INDUSTRIAL_0_9_NOREJ')

local imDeco = View.ImageDecoration.create()
imDeco:setRange(35.0, 55.0)

return {
  decRegion = decRegion,
  planeDeco = planeDeco,
  fontClassifierPlastic = fontClassifierPlastic,
  fontClassifierCard = fontClassifierCard,
  imDeco = imDeco
}
