//
//  ViewController.swift
//  ViewAnimatorTVOS
//
//  Created by Marcos Griselli on 28/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ViewAnimator

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Properties
    private var items = [Any?]()
    private let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
    }
    
    @IBAction func animateTapped(_ sender: UIButton) {
        sender.isEnabled = false
        activityIndicator.stopAnimating()
        items = Array(repeating: nil, count: 20)
        collectionView?.reloadData()
        collectionView?.performBatchUpdates({
            UIView.animate(views: self.collectionView!.orderedVisibleCells,
                           animations: animations, completion: {
                            sender.isEnabled = true
            })
        }, completion: nil)
    }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        items.removeAll()
        UIView.animate(views: collectionView!.orderedVisibleCells,
                       animations: animations, reversed: true,
                       initialAlpha: 1.0,
                       finalAlpha: 0.0,
                       completion: {
                        self.collectionView?.reloadData()
                        self.activityIndicator.startAnimating()
        })
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! CollectionViewCell
        let imageIndex = indexPath.item % 6
        cell.imageView.image = UIImage(named: "detail_\(imageIndex + 1)")
        return cell
    }
}
