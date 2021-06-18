Pod::Spec.new do |s|
  s.name             = 'ViewAnimator'
  s.version          = '3.1.0'
  s.summary          = 'ViewAnimator brings your UI to life with just one line of code.'

  s.description      = <<-DESC
    ViewAnimator helps create beautiful animations of an entire UI with only one line of code.
    It also supports UITableView/UICollectionView and UIStackView animation of cells and arrangedSubviews
    with delightful interactions.
                       DESC

  s.homepage         = 'https://github.com/marcosgriselli/ViewAnimator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'marcosgriselli@gmail.com' => 'marcosgriselli@gmail.com' }
  s.source           = { :git => 'https://github.com/marcosgriselli/ViewAnimator.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/marcosgriselli'

  s.swift_version = "5.1"
  s.swift_versions = ['4.0', '4.2', '5.0']

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.source_files = 'Sources/**/*'

end
