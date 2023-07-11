import CoreGraphics
import CoreML
import Foundation
import VideoToolbox

print("Sample LaMa inpainting app. Will inpaint input.jpeg with mask mask.png")

print("Loading LaMa.mlmodelc")
guard let modelUrl = Bundle.module.url(forResource: "LaMa", withExtension: "mlmodelc") else {
  print("Could not find LaMa.mlmodelc. Did you compile LaMa.mlpackage?")
  exit(EXIT_FAILURE)
}

print("Loading input.jpeg")
let inputImage = try CGImage.loadImage(forResource: "input",
                                       withExtension: "jpeg")

print("Loading mask.png")
let maskImage = try CGImage.loadImage(forResource: "mask",
                                      withExtension: "png")

print("Creating LaMa model")
let lama = try LaMa(contentsOf: modelUrl)

// These bounds are for the specific mask.png included in this package
// Update them if you change mask.png
let maskBounds = CGRect(x: 154, y: 778, width: 30, height: 64)

let cropSize: CGSize = CGSize(width: 800, height: 800)
let expandedBoundsOrigin = CGPoint(x: max(floor(maskBounds.center.x - cropSize.width / 2), 0),
                                   y: max(floor(maskBounds.center.y - cropSize.height / 2), 0))
let expandedBounds = CGRect(origin: expandedBoundsOrigin, size: cropSize)
let clippedExpandedBounds = inputImage.bounds.intersection(expandedBounds)
let clippedExpandedBoundsWidthDeficiency = cropSize.width - clippedExpandedBounds.width
let clippedExpandedBoundsHeightDeficiency = cropSize.height - clippedExpandedBounds.height
let expandedMaskBounds = CGRect(x: clippedExpandedBounds.origin.x - clippedExpandedBoundsWidthDeficiency,
                                y: clippedExpandedBounds.origin.y - clippedExpandedBoundsHeightDeficiency,
                                width: cropSize.width,
                                height: cropSize.height)
let croppedImage = inputImage.cropping(to: expandedMaskBounds.flipped(inRectOfHeight: CGFloat(inputImage.height)))!
let croppedMask = maskImage.cropping(to: expandedMaskBounds.flipped(inRectOfHeight: CGFloat(inputImage.height)))!
let input = try LaMaInput(imageWith: croppedImage, maskWith: croppedMask)

print("Inpainting")
let output = try lama.prediction(input: input)
var inpaintedImage: CGImage!
VTCreateCGImageFromCVPixelBuffer(output.output,
                                 options: nil,
                                 imageOut: &inpaintedImage)
let context = CGContext(data: nil,
                        width: inputImage.width,
                        height: inputImage.height,
                        bitsPerComponent: inputImage.bitsPerComponent,
                        bytesPerRow: inputImage.bytesPerRow,
                        space: inputImage.colorSpace!,
                        bitmapInfo: inputImage.bitmapInfo.rawValue)!
context.draw(inputImage, in: inputImage.bounds)
context.draw(inpaintedImage, in: expandedMaskBounds)
context.setStrokeColor(red: 0, green: 1, blue: 0, alpha: 1)
context.addRect(expandedMaskBounds)
let outputImage = context.makeImage()!

let desktopUrl = try! FileManager.default.url(for: .desktopDirectory,
                                              in: .userDomainMask,
                                              appropriateFor: nil,
                                              create: false)
let outputImageUrl = URL(fileURLWithPath: "CoreMLaMa/output.jpeg", isDirectory: false, relativeTo: desktopUrl)

print("Saving output to", outputImageUrl.path)
try outputImage.saveImage(to: outputImageUrl,
                          typeIdentifier: "public.jpeg")

print("Done!")
