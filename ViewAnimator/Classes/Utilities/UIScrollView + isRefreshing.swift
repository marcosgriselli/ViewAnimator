//
//  UIScrollView + isRefreshing.swift
//  ViewAnimator
//
//  Created by Marcos Griselli on 1/24/18.
//

import UIKit

@available(iOS 10.0, *)
extension UIScrollView {

    var isRefreshControlVisible: Bool {
        return refreshControl?.isRefreshing == true
    }
}
