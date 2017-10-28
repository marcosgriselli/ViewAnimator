<img src="https://cdn.rawgit.com/marcosgriselli/ViewAnimator/3c78b078/Resources/banner.svg" height="80"/>

**ViewAnimator** is a library for building complex iOS UIView animations in an easy way. It provides one line animations for any view included the ones which contain other views like UITableView and UICollectionView with its cells or UIStackView with its arrangedSubviews.


[![Version](https://img.shields.io/cocoapods/v/ViewAnimator.svg?style=flat)](http://cocoapods.org/pods/ViewAnimator)
![iOS 9+](https://img.shields.io/badge/iOS-9%2B-blue.svg?style=flat)
![Swift 4](https://img.shields.io/badge/Swift-4-orange.svg?style=flat)
[![License](https://img.shields.io/cocoapods/l/ViewAnimator.svg?style=flat)](http://cocoapods.org/pods/ViewAnimator)
[![codebeat badge](https://codebeat.co/badges/633fb33d-66b6-4034-93c0-0f52c5d0e15c)](https://codebeat.co/projects/github-com-marcosgriselli-viewanimator-master)

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

<!--### Swift Package Manager-->



### Manual

Drop the swift files inside of [ViewAnimator/Classes](https://github.com/marcosgriselli/ViewAnimator/tree/master/ViewAnimator/Classes) into your project.

## Usage

`ViewAnimator` provides a set of `UIView` extensions to easily add custom animations to your views.

### AnimationType

#### Direction
`Direction` provides the axis where the animation should take place and it's movement direction.

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

### Animatable

`UITableView`, `UICollectionView` and `UIStackView` conform to `Animatable` protocol. This lets us animate their visible subviews or cells with only one function. 

```swift
func animateViews(animations: [Animation],
                  initialAlpha: CGFloat,
                  finalAlpha: CGFloat,
                  delay: Double,
                  duration: TimeInterval,
                  animationInterval: TimeInterval,
                  completion: CompletionBlock?)
```

All of this parameters have default values except AnimationType. They can be modified globaly with `ViewAnimatorConfig` static properties.

### Random Animations
If you are just trying to see how `ViewAnimator` can fit in your project and don't want to spend any time reading the docs or testing the animations just call `view.animateRandom()` on your `UIViewController` and you'll get a set of random animations for your subviews. UITableViews/UICollectionViews and UIStackViews will have their visible views animated individually with the same animation but with a delay between each view.

```swift 
view.animateRandom()
```

### Combined Animations

You can combine conformances of `Animation` to apply multiple transforms on your animation block. 

```swift 
let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
let zoomAnimation = AnimationType.zoom(scale: 0.2)
let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
collectionView.animateViews(animations: [zoomAnimation, rotateAnimation], duration: 0.5)
tableView.animateViews(animations: [fromAnimation, zoomAnimation], duration: 0.5)

```

## Animation

`Animation` protocol provides you the posibility of expanding the animations supported by `ViewAnimator` with exception of the `animateRandom` function.

```swift 
public protocol Animation {
    var initialTransform: CGAffineTransform { get }
}
```

## TODO

- [x] Create protocol for the animations.
- [x] Support combining animations.
- [ ] Add Carthage support.
- [ ] Add SPM support.
- [ ] Add more use cases to the example app.
- [ ] Add autohide functionality.

## Mentions

- [iOS Dev Weekly 323](http://iosdevweekly.com/issues/323#start)
- [Natasha The Robot's Newsleter 147](https://swiftnews.curated.co/issues/147#start)
- [Top 10 Swift Articles October](https://medium.mybridge.co/swift-top-10-articles-for-the-past-month-v-oct-2017-4e0f1bd031e8)


## Project Details

### Requirements
* Swift 4.0
* Xcode 9.0+
* iOS 9.0+

### Contributing
Feel free to collaborate with ideas 💭, issues ⁉️ and/or pull requests 🔃.

If you use ViewAnimator in your app I'd love to hear about it and feature your animation here!

### Author

Marcos Griselli | <a href="url"><img src="https://cdn.rawgit.com/marcosgriselli/ViewAnimator/cf065e96/Resources/twitterLogo.svg" height="17"></a> [@marcosgriselli](https://twitter.com/marcosgriselli)


[![Twitter Follow](https://img.shields.io/twitter/follow/marcosgriselli.svg?style=social)](https://twitter.com/marcosgriselli)

### License

> Copyright (c) 2017 Marcos Griselli

> Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

> The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
