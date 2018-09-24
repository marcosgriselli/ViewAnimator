#
# Be sure to run `pod lib lint ViewAnimator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ViewAnimator'
  s.version          = '2.2.0'
  s.summary          = 'ViewAnimator brings your UI to life with just one line of code.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    ViewAnimator helps create beautiful animations of an entire UI with only one line of code.
    It also supports UITableView/UICollectionView and UIStackView animation of cells and arrangedSubviews
    with delightful interactions.
                       DESC

  s.homepage         = 'https://github.com/marcosgriselli/ViewAnimator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'marcosgriselli@gmail.com' => 'marcosgriselli@gmail.com' }
  s.source           = { :git => 'https://github.com/marcosgriselli/ViewAnimator.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/marcosgriselli'

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.source_files = 'ViewAnimator/Classes/**/*'
  s.swift_version = '4.2'

end
