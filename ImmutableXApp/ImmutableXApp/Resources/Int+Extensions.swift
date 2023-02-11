import Foundation

public extension Int {
  public static func random(min: Int , max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max - min + 1))) + min
  }
}
