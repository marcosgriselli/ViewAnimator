//
//  TableViewController.swift
//  ViewAnimator_Example
//
//  Created by Marcos Griselli on 1/14/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ViewAnimator

class TableViewController: UITableViewController {

    private var items = [Any?]()
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    private let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
    }

    private func setupActivityIndicator() {
        activityIndicator.center = CGPoint(x: view.center.x, y: 100.0)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.textLabel?.text = "Cell: \(indexPath.row + 1)"
        return cell
    }

    @IBAction func animateTapped(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        activityIndicator.stopAnimating()
        items = Array(repeating: nil, count: 20)
        tableView.reloadData()
        UIView.animate(views: tableView.visibleCells, animations: animations, completion: {
            sender.isEnabled = true
        })
    }

    @IBAction func resetTapped(_ sender: UIBarButtonItem) {
        items.removeAll()
        UIView.animate(views: tableView.visibleCells, animations: animations, reversed: true,
                       initialAlpha: 1.0, finalAlpha: 0.0, completion: {
            self.tableView.reloadData()
            self.activityIndicator.startAnimating()
        })
    }
}
