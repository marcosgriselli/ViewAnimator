<img src="https://cdn.rawgit.com/marcosgriselli/ViewAnimator/3c78b078/Resources/banner.svg" height="80"/>

**ViewAnimator** is a library for building complex iOS UIView animations in an easy way. It provides one line animations for any view included the ones which contain other views like UITableView and UICollectionView with its cells or UIStackView with its arrangedSubviews.


[![Version](https://img.shields.io/cocoapods/v/ViewAnimator.svg?style=flat)](http://cocoapods.org/pods/ViewAnimator)
![iOS 8+](https://img.shields.io/badge/iOS-8%2B-blue.svg?style=flat)
![Swift 4](https://img.shields.io/badge/Swift-4-orange.svg?style=flat)
![Downloads](https://img.shields.io/cocoapods/dt/ViewAnimator.svg?style=flat)
[![License](https://img.shields.io/cocoapods/l/ViewAnimator.svg?style=flat)](http://cocoapods.org/pods/ViewAnimator)
[![codebeat badge](https://codebeat.co/badges/633fb33d-66b6-4034-93c0-0f52c5d0e15c)](https://codebeat.co/projects/github-com-marcosgriselli-viewanimator-master)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

### Entire View&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;UITableView&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;UICollectionView
<img src="https://cdn.rawgit.com/marcosgriselli/ViewAnimator/cf065e96/Resources/entireView.svg"/>&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/marcosgriselli/ViewAnimator/cf065e96/Resources/horizontal.svg"/>&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/marcosgriselli/ViewAnimator/cf065e96/Resources/vertical.svg"/>&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/marcosgriselli/ViewAnimator/cf065e96/Resources/collection.svg"/>&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://cdn.rawgit.com/marcosgriselli/ViewAnimator/cf065e96/Resources/collectionX.svg"/>

SVG animations inspired by [Luke Zhao's](http://lkzhao.com) project [Hero](https://github.com/lkzhao/Hero/blob/master/README.md)

### Complex Layouts
<image src="https://cdn.dribbble.com/users/702789/screenshots/3816087/preview-messaki.gif" width="400"/>

UI created by [Messaki](https://dribbble.com/messaki), make sure to check out his profile.

## Installation

### CocoaPods

ViewAnimator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ViewAnimator"
```

### Manual

Drop the swift files inside of [ViewAnimator/Classes](https://github.com/marcosgriselli/ViewAnimator/tree/master/ViewAnimator/Classes) into your project.

### Carthage 

```
github "marcosgriselli/ViewAnimator"
```

## Usage

`ViewAnimator` provides a set of `UIView` extensions to easily add custom animations to your views. From version `2.0.0` there are two ways to use this extension. 

### Self animating views

Views can animate theirselves calling `.animate(animations: [Animation])` that's the most basic usage. Here's the full method that contains many default arguments: 

```swift
func animate(animations: [Animation],
             reversed: Bool = false,
             initialAlpha: CGFloat = 0.0,
             finalAlpha: CGFloat = 1.0,
             delay: Double = 0,
             duration: TimeInterval = ViewAnimatorConfig.duration,
             completion: (() -> Void)? = nil)
``` 

### Animating multiple views 

ViewAnimator follows the UIKit animations API style with a static method  `UIView.animate(views: [UIView], animations: [Animation])`. This makes the library really easy to use and extensible to any kind of view. As the previous example, the method contains a lot of default arguments: 

```swift
static func animate(views: [UIView],
                    animations: [Animation],
                    reversed: Bool = false,
                    initialAlpha: CGFloat = 0.0,
                    finalAlpha: CGFloat = 1.0,
                    delay: Double = 0,
                    animationInterval: TimeInterval = 0.05,
                    duration: TimeInterval = ViewAnimatorConfig.duration,
                    completion: (() -> Void)? = nil)
```

### AnimationType

#### Direction
`Direction` provides the axis where the animation should take place and its movement direction.

```swift
let animation = AnimationType.from(direction: .top, offset: 30.0)
view.animate(animations: [animation])
```

#### Zoom
Zoom in and Zoom out animation support.

```swift
let animation = AnimationType.zoom(scale: 0.5)
view.animate(animations: [animation])
```

### Combined Animations

You can combine conformances of `Animation` to apply multiple transforms on your animation block. 

```swift 
let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
let zoomAnimation = AnimationType.zoom(scale: 0.2)
let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
UIView.animate(views: collectionView.visibleCells,
               animations: [zoomAnimation, rotateAnimation],
               duration: 0.5)
UIView.animate(views: tableView.visibleCells,
               animations: [fromAnimation, zoomAnimation], 
               delay: 0.5)

```

## Animation

`Animation` protocol provides you the posibility of expanding the animations supported by `ViewAnimator` with exception of the `animateRandom` function.

```swift 
public protocol Animation {
    var initialTransform: CGAffineTransform { get }
}
```

## UITableView/UICollection extensions

ViewAnimator comes with a set of handy extensions to make your animations in `UITableView` and `UICollectionView` a lot simpler. They both have access to cells in a section to animate easily. 

They both expose a method `visibleCells(in section: Int)` that returns an array of `UITableViewCell` or `UICollectionViewCell`.

```swift
let cells = tableView.visibleCells(in: 1)
UIView.animate(views: cells, animations: [rotateAnimation, fadeAnimation])
``` 

## Mentions

- [iOS Dev Weekly 323](http://iosdevweekly.com/issues/323#start)
- [Natasha The Robot's Newsleter 147](https://swiftnews.curated.co/issues/147#start)
- [Top 10 Swift Articles October](https://medium.mybridge.co/swift-top-10-articles-for-the-past-month-v-oct-2017-4e0f1bd031e8)
- [30 Amazing iOS Swift Libraries (v2018)](https://medium.mybridge.co/30-amazing-ios-swift-libraries-for-the-past-year-v-2018-7cf15027eee9)


## Project Details

### Requirements
* Swift 4.0
* Xcode 7.0+
* iOS 8.0+

### Contributing
Feel free to collaborate with ideas 💭, issues ⁉️ and/or pull requests 🔃.

If you use ViewAnimator in your app I'd love to hear about it and feature your animation here!

### Author

Marcos Griselli | <a href="url"><img src="https://cdn.rawgit.com/marcosgriselli/ViewAnimator/cf065e96/Resources/twitterLogo.svg" height="17"></a> [@marcosgriselli](https://twitter.com/marcosgriselli)



[![Twitter Follow](https://img.shields.io/twitter/follow/marcosgriselli.svg?style=social)](https://twitter.com/marcosgriselli)

[![Twitter Follow](https://img.shields.io/github/followers/marcosgriselli.svg?style=social&label=Follow)](https://github.com/marcosgriselli)

### License

ViewAnimator is available under the MIT license. See the [LICENSE](https://github.com/marcosgriselli/ViewAnimator/blob/master/LICENSE) file for more info.
