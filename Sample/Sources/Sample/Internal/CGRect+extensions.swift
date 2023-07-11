import CoreGraphics

extension CGRect {
  var center: CGPoint {
    CGPoint(x: origin.x + width / 2, y: origin.y + height / 2)
  }

  func flipped(inRectOfHeight rectHeight: CGFloat) -> CGRect {
    CGRect(origin: CGPoint(x: origin.x, y: rectHeight - origin.y - size.height), size: size)
  }

  func scaledBy(_ factor: CGFloat) -> CGRect {
    CGRect(origin: CGPoint(x: origin.x * factor,
                           y: origin.y * factor),
           size: CGSize(width: width * factor,
                        height: height * factor))
  }
}
