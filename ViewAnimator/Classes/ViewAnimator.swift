//
//  ViewAnimator.swift
//  Pods-ViewAnimator_Example
//
//  Created by Marcos Griselli on 10/5/17.
//

import Foundation
import UIKit

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
    ///   - dampingRatio: The damping ratio for the spring animation.
    ///   - velocity: The initial spring velocity.
    ///   - completion: CompletionBlock after the animation finishes.
    func animate(animations: [Animation],
                 reversed: Bool = false,
                 initialAlpha: CGFloat = 0.0,
                 finalAlpha: CGFloat = 1.0,
                 delay: Double = 0,
                 duration: TimeInterval = ViewAnimatorConfig.duration,
                 usingSpringWithDamping dampingRatio: CGFloat = ViewAnimatorConfig.springDampingRatio,
                 initialSpringVelocity velocity: CGFloat = ViewAnimatorConfig.initialSpringVelocity,
                 options: UIView.AnimationOptions = [],
                 completion: (() -> Void)? = nil) {
        
        let transformFrom = transform
        var transformTo = transform
        animations.forEach { transformTo = transformTo.concatenating($0.initialTransform) }
        if !reversed {
            transform = transformTo
        }

        alpha = initialAlpha
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: dampingRatio,
                       initialSpringVelocity: velocity,
                       options: options,
                       animations: { [weak self] in
            self?.transform = reversed ? transformTo : transformFrom
            self?.alpha = finalAlpha
        }) { _ in
            completion?()
        }
    }
    
    /// Performs the animation.
    ///
    /// - Parameters:
    ///   - animations: Array of Animations to perform on the animation block.
    ///   - reversed: Initial state of the animation. Reversed will start from its original position.
    ///   - initialAlpha: Initial alpha of the view prior to the animation.
    ///   - finalAlpha: View's alpha after the animation.
    ///   - delay: Time Delay before the animation.
    ///   - animationInterval: Interval between the animations of each view.
    ///   - duration: TimeInterval the animation takes to complete.
    ///   - dampingRatio: The damping ratio for the spring animation.
    ///   - velocity: The initial spring velocity.
    ///   - completion: CompletionBlock after the animation finishes.
    static func animate(views: [UIView],
                        animations: [Animation],
                        reversed: Bool = false,
                        initialAlpha: CGFloat = 0.0,
                        finalAlpha: CGFloat = 1.0,
                        delay: Double = 0,
                        animationInterval: TimeInterval = 0.05,
                        duration: TimeInterval = ViewAnimatorConfig.duration,
                        usingSpringWithDamping dampingRatio: CGFloat = ViewAnimatorConfig.springDampingRatio,
                        initialSpringVelocity velocity: CGFloat = ViewAnimatorConfig.initialSpringVelocity,
                        options: UIView.AnimationOptions = [],
                        completion: (() -> Void)? = nil) {

        guard views.count > 0 else {
            completion?()
            return
        }
        
        views.forEach { $0.alpha = initialAlpha }
        let dispatchGroup = DispatchGroup()
        for _ in 1...views.count { dispatchGroup.enter() }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            for (index, view) in views.enumerated() {
                view.alpha = initialAlpha
                view.animate(animations: animations,
                             reversed: reversed,
                             initialAlpha: initialAlpha,
                             finalAlpha: finalAlpha,
                             delay: Double(index) * animationInterval,
                             duration: duration,
                             usingSpringWithDamping: dampingRatio,
                             initialSpringVelocity: velocity,
                             options: options,
                             completion: { dispatchGroup.leave() })
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion?()
        }
    }
}
