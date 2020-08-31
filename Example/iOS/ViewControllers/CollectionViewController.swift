//
//  CollectionViewController.swift
//  ViewAnimator_Example
//
//  Created by Marcos Griselli on 04/02/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ViewAnimator

private let reuseIdentifier = "Cell"

class CollectionViewController: UIViewController {
    
    var initiallyAnimates = false
    private var items = [Any?]()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private let animations = [AnimationType.vector((CGVector(dx: 0, dy: 30)))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        if initiallyAnimates {
            activityIndicator.stopAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
                self.items = Array(repeating: nil, count: 5)
                self.collectionView?.reloadData()
                self.collectionView?.performBatchUpdates({
                    UIView.animate(views: self.collectionView!.orderedVisibleCells,
                                   animations: self.animations, completion: {
                        
                        })
                }, completion: nil)
            }
        }
    }
    
    @IBAction func animateTapped(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        activityIndicator.stopAnimating()
        items = Array(repeating: nil, count: 5)
        collectionView?.reloadData()
        collectionView?.performBatchUpdates({
            UIView.animate(views: self.collectionView!.orderedVisibleCells,
                animations: animations, options: [.curveEaseInOut], completion: {
                sender.isEnabled = true
                })
        }, completion: nil)
    }
    
    @IBAction func resetTapped(_ sender: UIBarButtonItem) {
        items.removeAll()
        UIView.animate(views: collectionView!.orderedVisibleCells,
                       animations: animations, reversed: true,
                       initialAlpha: 1.0,
                       finalAlpha: 0.0,
                       options: [.curveEaseIn],
                       completion: {
                        self.collectionView?.reloadData()
                        self.activityIndicator.startAnimating()
        })
    }
}

// MARK: UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let color: UIColor = indexPath.section % 2 == 0 ? .red : .blue
        cell.contentView.backgroundColor = color
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as? CollectionViewController else {
            return
        }
        viewController.initiallyAnimates = true
        navigationController?.show(viewController, sender: nil)
    }
}
