//
//  AnimationType.swift
//  Pods-ViewAnimator_Example
//
//  Created by Marcos Griselli on 10/5/17.
//

import Foundation

/// AnimationType available to perform/
///
/// - from: Animation with direction and distance.
/// - zoom: Zoom animation.
public enum AnimationType {

    case from(direction: Direction, offset: CGFloat)
    case zoom(scale: CGFloat)
    
    /// Generates a random AnimationType.
    ///
    /// - Returns: Newly generated random AnimationType.
    static func randomAnimation() -> AnimationType {
        if Bool.random() {
            return AnimationType.from(direction: Direction.random(),
                                      offset: ViewAnimatorConfig.offset)
        }
        let scale = Double.random(min: 0, max: ViewAnimatorConfig.maxZoomScale)
        return AnimationType.zoom(scale: CGFloat(scale))
    }
}
