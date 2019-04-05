//
//  AnimationType.swift
//  Pods-ViewAnimator_Example
//
//  Created by Marcos Griselli on 10/5/17.
//

import UIKit

/// AnimationType available to perform/
///
/// - from: Animation with direction and distance.
/// - zoom: Zoom animation.
/// - rotate: Rotation animation.
public enum AnimationType: Animation {

    case from(direction: Direction, offset: CGFloat)
    case zoom(scale: CGFloat)
    case rotate(angle: CGFloat)
    
    /// Creates the corresponding CGAffineTransform for AnimationType.from.
    public var initialTransform: CGAffineTransform {
        switch self {
        case .from(let direction, let offset):
            let sign = direction.sign
            if direction.isVertical { return CGAffineTransform(translationX: 0, y: offset * sign) }
            return CGAffineTransform(translationX: offset * sign, y: 0)
        case .zoom(let scale):
             return CGAffineTransform(scaleX: scale, y: scale)
        case .rotate(let angle):
            return CGAffineTransform(rotationAngle: angle)
        }
    }
    
    /// Generates a random Animation.
    ///
    /// - Returns: Newly generated random Animation.
    public static func random() -> Animation {
        let index = Int.random(in: 0..<3)
        if index == 1 {
            return AnimationType.from(direction: Direction.random(),
                                      offset: ViewAnimatorConfig.offset)
        } else if index == 2 {
            let scale = Double.random(in: 0...ViewAnimatorConfig.maxZoomScale)
            return AnimationType.zoom(scale: CGFloat(scale))
        }
        let angle = CGFloat.random(in: -ViewAnimatorConfig.maxRotationAngle...ViewAnimatorConfig.maxRotationAngle)
        return AnimationType.rotate(angle: angle)
    }
}
