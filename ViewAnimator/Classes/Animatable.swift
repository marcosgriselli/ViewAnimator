//
//  Animatable.swift
//  Pods-ViewAnimator_Example
//
//  Created by Marcos Griselli on 10/9/17.
//


/// Animatable protocol used for views containing a set of subviews like UITableView,
/// UICollectionView and UIStackView.
public protocol Animatable {
    
    /// Views to be animated.
    var views: [UIView] { get }
    
    /// Prepare views before the animation. Only use it if you are planing on animating
    /// both, the parent view and it's child views on different animations.
    ///
    /// - Parameter initialAlpha: Starting alpha value of it's views.
    func prepareViews(initialAlpha: CGFloat)
    
    /// Performs the animation.
    ///
    /// - Parameters:
    ///   - animations: Animations array to perform on the animation block.
    ///   - initialAlpha: Initial alpha of the view prior to the animation.
    ///   - finalAlpha: View's alpha after the animation.
    ///   - delay: Time Delay before the animation.
    ///   - duration: TimeInterval the animation takes to complete.
    ///   - animationInterval: TimeInterval between each of the subviews animations.
    ///   - completion: CompletionBlock after the animation finishes.
    func animateViews(animations: [Animation],
                      initialAlpha: CGFloat,
                      finalAlpha: CGFloat,
                      delay: Double,
                      duration: TimeInterval,
                      animationInterval: TimeInterval,
                      completion: CompletionBlock?)
}

public extension Animatable {
    
    public func prepareViews(initialAlpha: CGFloat = 0) {
        views.forEach { $0.alpha = initialAlpha }
    }
    
    public func animateViews(animations: [Animation],
                             initialAlpha: CGFloat = 0.0,
                             finalAlpha: CGFloat = 1.0,
                             delay: Double = 0.0,
                             duration: TimeInterval = 0.3,
                             animationInterval: TimeInterval = 0.05,
                             completion: CompletionBlock? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            for (index, view) in self.views.enumerated() {
                view.alpha = initialAlpha
                view.animate(animations: animations,
                             initialAlpha: initialAlpha,
                             finalAlpha: finalAlpha,
                             delay: Double(index) * animationInterval,
                             duration: duration,
                             completion: completion)
            }
        }
    }
}

// MARK: - UITableView
extension UITableView: Animatable {
    
    public var views: [UIView] {
        return visibleCells
    }
}

// MARK: - UICollectionView
extension UICollectionView: Animatable {

    /// Checks for the IndexPath of a UICollectionView cell.
    ///
    /// - Parameter cell: Cell to check it's path.
    /// - Returns: Item position.
    private func indexPathFor(cell: UICollectionViewCell) -> Int {
        return indexPath(for: cell)?.item ?? -1
    }
    
    public var views: [UIView] {
        let items = visibleCells
        return items.sorted(by: { indexPathFor(cell: $1) > indexPathFor(cell: $0) })
    }
}

// MARK: - UIStackView
@available(iOS 9, *)
extension UIStackView: Animatable {

    public var views: [UIView] {
        return arrangedSubviews
    }
}
