import Foundation
import ImageIO

extension CGImage {
  var bounds: CGRect {
    CGRect(x: 0, y: 0, width: width, height: height)
  }

  static func loadImage(forResource name: String,
                        withExtension ext: String) throws -> CGImage {
    guard let url = Bundle.module.url(forResource: name, withExtension: ext) else {
      throw "Unable to find resource named \(name) with extension \(ext)"
    }
    return try loadImage(at: url)
  }

  static func loadImage(at url: URL) throws -> CGImage {
    guard let imageSource = CGImageSourceCreateWithURL(url as CFURL, nil) else {
      throw "Unable to create image source from \(url.path)"
    }
    let primaryImageIndex = CGImageSourceGetPrimaryImageIndex(imageSource)
    guard let image = CGImageSourceCreateImageAtIndex(imageSource, primaryImageIndex, nil) else {
      throw "Unable to create image \(primaryImageIndex) from image source at \(url.path)"
    }
    return image
  }

  func saveImage(to outputUrl: URL, typeIdentifier: String) throws {
    try FileManager.default.createDirectory(at: outputUrl.deletingLastPathComponent(),
                                            withIntermediateDirectories: true)
    let imageDest = CGImageDestinationCreateWithURL(outputUrl as CFURL,
                                                    typeIdentifier as CFString,
                                                    1,
                                                    nil)!
    CGImageDestinationAddImage(imageDest,
                               self,
                               nil)
    CGImageDestinationFinalize(imageDest)
  }
}
