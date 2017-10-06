//
//  ViewAnimator.swift
//  Pods-ViewAnimator_Example
//
//  Created by Marcos Griselli on 10/5/17.
//

import Foundation
import UIKit

public typealias AnimatorInterval = TimeInterval

public extension UIView {
    
    // TODO: - Re-write for to(dir...)
    
    private func transformFor(direction: Direction, scale: CGFloat) -> CGAffineTransform? {
        guard let offset = offsetFor(direction: direction) else { return nil}
        if direction.isVertical { return CGAffineTransform(translationX: 0, y: offset * scale) }
        return CGAffineTransform(translationX: offset * scale, y: 0)
    }
    
    //    private func transformTo(direction: Direction, scale: CGFloat) -> CGAffineTransform? {
    //        guard let offset = offsetFor(direction: direction) else { return nil}
    //        let arrangedOffset = offset
    //        if direction.isVertical { return CGAffineTransform(translationX: 0, y: arrangedOffset * scale) }
    //        return CGAffineTransform(translationX: arrangedOffset * scale, y: 0)
    //    }
    
    public func animate(animationType: AnimationType,
                        initialAlpha: CGFloat = 1.0,
                        finalAlpha: CGFloat = 1.0) {
        switch animationType {
        case .from(let direction, let scale):
            guard let animationTransform = transformFor(direction: direction, scale: scale) else { return }
            transform = animationTransform
        case .zoom(let scale):
            transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        alpha = initialAlpha
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.transform = CGAffineTransform.identity
            self?.alpha = finalAlpha
        }
    }
    
    public func offsetFor(direction: Direction) -> CGFloat? {
        switch direction {
        case .top:
            return -(frame.origin.y + bounds.size.height)
        case .left:
            return -(frame.origin.x + bounds.size.width)
        case .right:
            guard let superview = superview else { return nil }
            return superview.bounds.size.width - frame.origin.x
        case .bottom:
            guard let superview = superview else { return nil }
            return superview.bounds.size.height - frame.origin.y
        }
    }
}
