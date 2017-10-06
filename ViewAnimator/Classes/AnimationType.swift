//
//  AnimationType.swift
//  Pods-ViewAnimator_Example
//
//  Created by Marcos Griselli on 10/5/17.
//

import Foundation

public enum AnimationType {
    case from(direction: Direction, scale: CGFloat)
    case zoom(scale: CGFloat)
}
