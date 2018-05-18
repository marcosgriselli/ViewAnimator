//
//  Animation.swift
//  Pods-ViewAnimator_Example
//
//  Created by Marcos Griselli on 10/16/17.
//

import UIKit

/// Animation protocol defines the initial transform for a view for it to
/// animate to its identity position.
public protocol Animation {

    /// Defines the starting point for the animations. 
    var initialTransform: CGAffineTransform { get }
}
