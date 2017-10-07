//
//  ViewController.swift
//  ViewAnimator
//
//  Created by marcosgriselli@gmail.com on 10/05/2017.
//  Copyright (c) 2017 marcosgriselli@gmail.com. All rights reserved.
//

import UIKit
import ViewAnimator

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.layer.cornerRadius = 5.0
        tableView.tableFooterView = UIView()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 5.0
    }

    @IBAction func animate() {
        let animationType = AnimationType.from(direction: Direction.left, offset: 30)
        label.animate(animationType: animationType)

        let zoomOut = AnimationType.zoom(scale: 0.8)
        subtitleLabel.animate(animationType: zoomOut, delay: 0.1)

        let animationTypeTable = AnimationType.from(direction: Direction.bottom, offset: 30)
        tableView.prepareViews()
        tableView.animate(animationType: AnimationType.from(direction: .bottom, offset: 10), delay: 0.2)
        tableView.animateViews(animationType: animationTypeTable, delay: 0.3)

        collectionView.prepareViews()
        collectionView.animate(animationType: animationType, delay: 0.35)
        let collectionAnimation = AnimationType.zoom(scale: 1.2)
        collectionView.animateViews(animationType: collectionAnimation, delay: 0.45)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = "Cell!"
        return cell!
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.red
        cell.layer.cornerRadius = 5.0
//        cell.alpha = 0
        return cell
    }
}
