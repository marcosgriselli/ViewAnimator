//
//  Direction.swift
//  Pods-ViewAnimator_Example
//
//  Created by Marcos Griselli on 10/5/17.
//

import Foundation

public enum Direction {
    case top
    case left
    case right
    case bottom
    
    var isVertical: Bool {
        return [.top, .bottom].contains(self)
    }
}
