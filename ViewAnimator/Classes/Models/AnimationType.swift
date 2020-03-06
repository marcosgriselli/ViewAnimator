//
//  AnimationType.swift
//  Pods-ViewAnimator_Example
//
//  Created by Marcos Griselli on 10/5/17.
//

import UIKit

/// AnimationType available to perform/
///
/// - translate: Translation animation
/// - zoom: Zoom animation.
/// - rotate: Rotation animation.
public enum AnimationType: Animation {

    case translate(x: CGFloat, y: CGFloat)
    case zoom(scale: CGFloat)
    case rotate(angle: CGFloat)
    
    /// Creates the corresponding CGAffineTransform for AnimationType.from.
    public var initialTransform: CGAffineTransform {
        switch self {
        case .translate(let x, let y):
            return CGAffineTransform(translationX: x, y: y)
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
        switch Int.random(in: 0..<3) {
        case 1:
            return AnimationType.translate(x: ViewAnimatorConfig.offset, y: ViewAnimatorConfig.offset)
        case 2:
            let scale = Double.random(in: 0...ViewAnimatorConfig.maxZoomScale)
            return AnimationType.zoom(scale: CGFloat(scale))
        default:
            let angle = CGFloat.random(in: -ViewAnimatorConfig.maxRotationAngle...ViewAnimatorConfig.maxRotationAngle)
            return AnimationType.rotate(angle: angle)
        }
    }
}
