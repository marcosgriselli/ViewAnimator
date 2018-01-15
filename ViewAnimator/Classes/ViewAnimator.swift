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
    ///   - animations: Array of Animations to perform on the animation block.
    ///   - reversed: Initial state of the animation. Reversed will start from its original position.
    ///   - initialAlpha: Initial alpha of the view prior to the animation.
    ///   - finalAlpha: View's alpha after the animation.
    ///   - delay: Time Delay before the animation.
    ///   - duration: TimeInterval the animation takes to complete.
    ///   - completion: CompletionBlock after the animation finishes.
    public func animate(animations: [Animation],
                        reversed: Bool = false,
                        initialAlpha: CGFloat = 0.0,
                        finalAlpha: CGFloat = 1.0,
                        delay: Double = 0,
                        duration: TimeInterval = ViewAnimatorConfig.duration,
                        completion: CompletionBlock? = nil) {
        
        let transformFrom = transform
        var transformTo = transform
        animations.forEach { transformTo = transformTo.concatenating($0.initialTransform) }
        if !reversed {
            transform = transformTo
        }

        alpha = initialAlpha
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.animate(withDuration: duration, animations: { [weak self] in
                self?.transform = reversed ? transformTo : transformFrom
                self?.alpha = finalAlpha
                }, completion: { _ in
                    completion?()
            })
        }
    }

    /// Animates all the subviews of the view calling the function.
    ///
    /// - Parameters:
    ///   - animations: Animations to perform.
    ///   - interval: Interval of the animations between subviews.
    public func animateAll(animations: [Animation],
                           interval: Double = ViewAnimatorConfig.interval) {
        for (index, view) in subviews.enumerated() {
            let delay = Double(index) * interval
            view.animate(animations: animations, delay: delay)
        }
    }

    /// Performs random animations on all of the subiews.
    /// This method only uses the Animations provided in AnimationType.
    ///
    /// - Parameter interval: Interval of the animations between subviews.
    public func animateRandom(interval: Double = ViewAnimatorConfig.interval) {
        for (index, view) in subviews.enumerated() {
            let delay = Double(index) * interval
            let animation = AnimationType.random()
            if let animatable = view as? Animatable {
                animatable.animateViews(animations: [animation], delay: delay)
            } else {
                view.animate(animations: [animation], delay: delay)
            }
        }
    }
}
