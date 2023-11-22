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
    
    // MARK: - Single View
    
    /// Animation based on the UIView.animateWithDuration API
    /// - Parameters:
    ///   - animations: Array of Animations to perform on the animation block.
    ///   - reversed: Initial state of the animation. Reversed will start from its original position.
    ///   - initialAlpha: Initial alpha of the view prior to the animation.
    ///   - finalAlpha: View's alpha after the animation.
    ///   - delay: Time Delay before the animation.
    ///   - duration: TimeInterval the animation takes to complete.
    ///   - options: UIView.AnimationsOptions to pass to the animation block.
    ///   - completion: block to run  after the animation finishes.
    func animate(animations: [Animation],
                 reversed: Bool = false,
                 initialAlpha: CGFloat = 0.0,
                 finalAlpha: CGFloat = 1.0,
                 delay: Double = 0,
                 duration: TimeInterval = ViewAnimatorConfig.duration,
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
                       options: options,
                       animations: { [weak self] in
            self?.transform = reversed ? transformTo : transformFrom
            self?.alpha = finalAlpha
        }) { _ in
            completion?()
        }
    }
    
    /// Animation based on UIView.animateWithDuration using springs
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
    ///   - options: UIView.AnimationsOptions to pass to the animation block. Timing functions will have no impact on spring based animations.
    ///   - completion: CompletionBlock after the animation finishes.
    func animate(animations: [Animation],
                 reversed: Bool = false,
                 initialAlpha: CGFloat = 0.0,
                 finalAlpha: CGFloat = 1.0,
                 delay: Double = 0,
                 duration: TimeInterval = ViewAnimatorConfig.duration,
                 usingSpringWithDamping dampingRatio: CGFloat,
                 initialSpringVelocity velocity: CGFloat,
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
    /**
     An extension on UIView that provides a convenient method for animating keyframes with multiple animations.

     - Parameters:
       - animations: An array of `Animation` objects representing the transformations to be applied in each keyframe.
       - initialAlpha: The initial alpha value of the view before the animation starts. Default is 1.0.
       - finalAlpha: The final alpha value of the view after the animation completes. Default is 1.0.
       - delay: The delay before the animation starts, in seconds. Default is 0.
       - duration: The total duration of the animation. Default is the value specified in `ViewAnimatorConfig.duration`.
       - options: Additional options for the keyframe animation. Default is an empty set.
       - completion: A closure to be executed after the animation finishes. Default is `nil`.

     The `animateKeyFrames` method animates a series of keyframes, each defined by an `Animation` object.
      The view's properties, such as transform and alpha, are animated over the specified duration and delay.

     Example usage:

     ```swift
     let angle: CGFloat = .pi / 8
     let animatins: [Animation] = [
         AnimationType.rotate(angle: -angle),
         AnimationType.rotate(angle: angle),
         AnimationType.rotate(angle: -angle),
         AnimationType.rotate(angle: angle),
         AnimationType.rotate(angle: 0)
     ]

     view.animateKeyFrames(animations: animations, initialAlpha: 0.5, finalAlpha: 1.0, delay: 0.2, duration: 2.0) {
         // Completion handler
         print("Animation completed!")
     }
     */
    func animateKeyFrames(animations: [Animation],
                          initialAlpha: CGFloat = 0.0,
                          finalAlpha: CGFloat = 1.0,
                          delay: Double = 0,
                          duration: TimeInterval = ViewAnimatorConfig.duration,
                          options: UIView.KeyframeAnimationOptions = [],
                          completion: (() -> Void)? = nil) {
        let numberOfFrames: Int = animations.count
        let singleFrameDuration: Double = Double(1/Double(numberOfFrames))
        
        alpha = initialAlpha
        
        UIView.animateKeyframes(withDuration: duration, delay: delay, options: options) { [weak self] in
            // iterates over each keyframe specified in the animations array.
            for index in 0..<numberOfFrames {
                let animation = animations[index]
                // calculates the relative start time for the current keyframe
                // This ensures that each keyframe starts at the appropriate time in the overall animation sequence
                let frameDurationStartTime = index == 0 ? 0.0 : Double(singleFrameDuration) * Double(index)
                
                // calculates the alpha value for the current keyframe
                let frameAlphaValue = initialAlpha + ((finalAlpha - initialAlpha) * CGFloat(frameDurationStartTime))
                
                UIView.addKeyframe(withRelativeStartTime: frameDurationStartTime, relativeDuration: singleFrameDuration) {
                    self?.transform = animation.initialTransform
                    // if initialAlpha equalts finalAlpha alpha will not animate
                    self?.alpha = frameAlphaValue
                }
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0) {
                self?.transform = .identity
                self?.alpha = finalAlpha

            }
        } completion: { _ in
            completion?()
        }
    }
    // MARK: - UIView Array
    
    /// Animates multiples views with cascading effect using the UIView.animateWithDuration API
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
    ///   - options: UIView.AnimationsOptions to pass to the animation block. Timing functions will have no impact on spring based animations.
    ///   - completion: CompletionBlock after the animation finishes.
    static func animate(views: [UIView],
                        animations: [Animation],
                        reversed: Bool = false,
                        initialAlpha: CGFloat = 0.0,
                        finalAlpha: CGFloat = 1.0,
                        delay: Double = 0,
                        animationInterval: TimeInterval = 0.05,
                        duration: TimeInterval = ViewAnimatorConfig.duration,
                        options: UIView.AnimationOptions = [],
                        completion: (() -> Void)? = nil) {

        performAnimation(views: views, animations: animations, reversed: reversed, initialAlpha: initialAlpha, delay: delay, animationBlock: { view, index, dispatchGroup in
            view.animate(animations: animations,
                         reversed: reversed,
                         initialAlpha: initialAlpha,
                         finalAlpha: finalAlpha,
                         delay: Double(index) * animationInterval,
                         duration: duration,
                         options: options,
                         completion: { dispatchGroup.leave() })
        }, completion: completion)
    }
    
    /// Animates multiples views with cascading effect using the UIView.animateWithDuration with springs
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
    ///   - options: UIView.AnimationsOptions to pass to the animation block. Timing functions will have no impact on spring based animations.
    ///   - completion: CompletionBlock after the animation finishes.
    static func animate(views: [UIView],
                        animations: [Animation],
                        reversed: Bool = false,
                        initialAlpha: CGFloat = 0.0,
                        finalAlpha: CGFloat = 1.0,
                        delay: Double = 0,
                        animationInterval: TimeInterval = 0.05,
                        duration: TimeInterval = ViewAnimatorConfig.duration,
                        usingSpringWithDamping dampingRatio: CGFloat,
                        initialSpringVelocity velocity: CGFloat,
                        options: UIView.AnimationOptions = [],
                        completion: (() -> Void)? = nil) {

        performAnimation(views: views, animations: animations, reversed: reversed, initialAlpha: initialAlpha, delay: delay, animationBlock: { view, index, dispatchGroup in
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
        }, completion: completion)
    }
    
    static private func performAnimation(
        views: [UIView],
        animations: [Animation],
        reversed: Bool = false,
        initialAlpha: CGFloat = 0.0,
        delay: Double = 0,
        animationBlock: @escaping ((UIView, Int, DispatchGroup) -> Void),
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
                animationBlock(view, index, dispatchGroup)
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion?()
        }
    }
}
