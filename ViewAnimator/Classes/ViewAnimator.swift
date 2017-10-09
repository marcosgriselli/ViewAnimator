//
//  ViewAnimator.swift
//  Pods-ViewAnimator_Example
//
//  Created by Marcos Griselli on 10/5/17.
//

import Foundation
import UIKit

/// Animations completion block
public typealias CompletionBlock = (()->())

// MARK: - UIView extension with animations.
public extension UIView {

    /// Performs the animation.
    ///
    /// - Parameters:
    ///   - animationType: AnimationType to perform on the animation block.
    ///   - initialAlpha: Initial alpha of the view prior to the animation.
    ///   - finalAlpha: View's alpha after the animation.
    ///   - delay: Time Delay before the animation.
    ///   - duration: TimeInterval the animation takes to complete.
    ///   - completion: CompletionBlock after the animation finishes.
    public func animate(animationType: AnimationType,
                        initialAlpha: CGFloat = 0.0,
                        finalAlpha: CGFloat = 1.0,
                        delay: Double = 0,
                        duration: TimeInterval = ViewAnimatorConfig.duration,
                        completion: CompletionBlock? = nil) {
        switch animationType {
        case .from(let direction, let offset):
            transform = transformFor(direction: direction, offset: offset)
        case .zoom(let scale):
            transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        alpha = initialAlpha
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.animate(withDuration: duration, animations: { [weak self] in
                self?.transform = CGAffineTransform.identity
                self?.alpha = finalAlpha
                }, completion: { _ in
                    completion?()
            })
        }
    }

    /// Creates the corresponding CGAffineTransform for AnimationType.from.
    ///
    /// - Parameters:
    ///   - direction: Direction option.
    ///   - offset: Amount of movement to perform.
    /// - Returns: CGAffineTransform created.
    private func transformFor(direction: Direction, offset: CGFloat) -> CGAffineTransform {
        let sign = signFor(direction: direction)
        if direction.isVertical { return CGAffineTransform(translationX: 0, y: offset * sign) }
        return CGAffineTransform(translationX: offset * sign, y: 0)
    }

    /// Direction of the animation using AnimationType.from.
    ///
    /// - Parameter direction: Direction option.
    /// - Returns: Positive o negative value to determine the direction.
    private func signFor(direction: Direction) -> CGFloat {
        switch direction {
        case .top, .left:
            return -1
        case .right, .bottom:
            return 1
        }
    }

    /// Animates all the subviews of the view calling the function.
    ///
    /// - Parameters:
    ///   - animationType: AnimationType to perform.
    ///   - interval: Interval of the animations between subviews.
    public func animateAll(animationType: AnimationType,
                           interval: Double = ViewAnimatorConfig.interval) {
        for (index, view) in subviews.enumerated() {
            let delay = Double(index) * interval
            view.animate(animationType: animationType, delay: delay)
        }
    }

    /// Performs random animations on all of the subiews.
    ///
    /// - Parameter interval: Interval of the animations between subviews.
    public func animateRandom(interval: Double = ViewAnimatorConfig.interval) {
        for (index, view) in subviews.enumerated() {
            let delay = Double(index) * interval
            let type = AnimationType.randomAnimation()
            if let animatable = view as? Animatable {
                animatable.animateViews(animationType: type, delay: delay)
            } else {
                view.animate(animationType: type, delay: delay)
            }
        }
    }
}
