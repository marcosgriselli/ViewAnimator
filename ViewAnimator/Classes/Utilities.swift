//
//  Utilities.swift
//  Pods-ViewAnimator_Example
//
//  Created by Marcos Griselli on 10/7/17.
//

import Foundation

// MARK: - Bool
extension Bool {

    /// Generates a random bool.
    ///
    /// - Returns: Bool.
    static func random() -> Bool {
        return arc4random_uniform(2) == 0
    }
}

// MARK: Double
public extension Double {
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }

    /// Generates a random double.
    ///
    /// - Parameters:
    ///   - min: Minimum value of the random value.
    ///   - max: Maximum value of the random value.
    /// - Returns: Generated value.
    public static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
}
