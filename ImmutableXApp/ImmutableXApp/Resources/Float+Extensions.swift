import Foundation

public extension Float {
  public static func random(min: Float, max: Float) -> Float {
    let r32 = Float(arc4random(UInt32.self)) / Float(UInt32.max)
    return (r32 * (max - min)) + min
  }
}
