import CoreGraphics

/** The value of π as a CGFloat */
let π = CGFloat(3.14)

public extension CGFloat {
    /**
     * Converts an angle in degrees to radians.
     */
    func degreesToRadians() -> CGFloat {
        return π * self / 180.0
    }
    
    /**
     * Converts an angle in radians to degrees.
     */
    func radiansToDegrees() -> CGFloat {
        return self * 180.0 / π
    }
    
    /**
     * Ensures that the float value stays between the given values, inclusive.
     */
    func clamped(v1: CGFloat, _ v2: CGFloat) -> CGFloat {
        let min = v1 < v2 ? v1 : v2
        let max = v1 > v2 ? v1 : v2
        return self < min ? min : (self > max ? max : self)
    }
    
    /**
     * Ensures that the float value stays between the given values, inclusive.
     */
    mutating func clamp(v1: CGFloat, _ v2: CGFloat) -> CGFloat {
        self = clamped(v1: v1, v2)
        return self
    }
    
    /**
     * Returns 1.0 if a floating point value is positive; -1.0 if it is negative.
     */
    func sign() -> CGFloat {
        return (self >= 0.0) ? 1.0 : -1.0
    }
    
    /**
     * Returns a random floating point number between 0.0 and 1.0, inclusive.
     */
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    /**
     * Returns a random floating point number in the range min...max, inclusive.
     */
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(leastNormalMagnitude < max)
        return CGFloat.random() * (max - leastNormalMagnitude) + leastNormalMagnitude
    }
    
    /**
     * Randomly returns either 1.0 or -1.0.
     */
    static func randomSign() -> CGFloat {
        return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
    }
}

/**
 * Returns the shortest angle between two angles. The result is always between
 * -π and π.
 */
//public func shortestAngleBetween(angle1: CGFloat, angle2: CGFloat) -> CGFloat {
//    let twoπ = π * 2.0
//    var angle = (angle2 - angle1) % twoπ
//    if (angle >= π) {
//        angle = angle - twoπ
//    }
//    if (angle <= -π) {
//        angle = angle + twoπ
//    }
//    return angle
//}
