//
//  CollectionViewCell.swift
//  ViewAnimator_Example
//
//  Created by Marcos Griselli on 10/9/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView.superview == nil {
            imageView.frame = bounds
            imageView.layer.cornerRadius = layer.cornerRadius
            addSubview(imageView)
        }
    }
}
