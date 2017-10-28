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
    
    var preTransform: CGAffineTransform? {
        get {
            return objc_getAssociatedObject(self,
                                            &ViewAnimatorConstants.preTransformKey) as? CGAffineTransform
        }
        set {
            objc_setAssociatedObject(self,
                                     &ViewAnimatorConstants.preTransformKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN)
        }
    }

    /// Performs the animation.
    ///
    /// - Parameters:
    ///   - animations: Array of Animations to perform on the animation block.
    ///   - initialAlpha: Initial alpha of the view prior to the animation.
    ///   - finalAlpha: View's alpha after the animation.
    ///   - delay: Time Delay before the animation.
    ///   - duration: TimeInterval the animation takes to complete.
    ///   - completion: CompletionBlock after the animation finishes.
    public func animate(animations: [Animation],
                        initialAlpha: CGFloat = 0.0,
                        finalAlpha: CGFloat = 1.0,
                        delay: Double = 0,
                        duration: TimeInterval = ViewAnimatorConfig.duration,
                        completion: CompletionBlock? = nil) {
        
        // Apply transforms and alpha
        animations.forEach {
            preTransform = transform
            transform = transform.concatenating($0.initialTransform)
        }
        alpha = initialAlpha
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.animate(withDuration: duration, animations: { [weak self] in
                self?.transform = self?.preTransform ?? CGAffineTransform.identity
                self?.alpha = finalAlpha
                }, completion: { _ in
                    completion?()
            })
        }
    }

    /// Animates all the subviews of the view calling the function.
    ///
    /// - Parameters:
    ///   - animationType: AnimationType to perform.
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
