//
//  UICollectionView + ViewAnimator.swift
//  ViewAnimator
//
//  Created by Marcos Griselli on 15/04/2018.
//

import Foundation
import UIKit

public extension UICollectionView {
    
    /// Checks for the IndexPath of a UICollectionView cell.
    ///
    /// - Parameter cell: Cell to check it's path.
    /// - Returns: Item position.
    private func indexPathFor(cell: UICollectionViewCell) -> Int {
        return indexPath(for: cell)?.item ?? -1
    }

    /// VisibleCells in the order they are displayed on screen.
    var orderedVisibleCells: [UICollectionViewCell] {
        let items = visibleCells
        return items.sorted(by: { indexPathFor(cell: $1) > indexPathFor(cell: $0) })
    }

    /// Gets the currently visibleCells of a section.
    ///
    /// - Parameter section: The section to filter the cells.
    /// - Returns: Array of visible UICollectionViewCells in the argument section.
    func visibleCells(in section: Int) -> [UICollectionViewCell] {
        return visibleCells.filter { indexPath(for: $0)?.section == section }
    }
}
