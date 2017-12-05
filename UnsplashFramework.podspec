# Info on podspec syntax: https://guides.cocoapods.org/syntax/podspec.html
# Spec examples: https://github.com/CocoaPods/Specs/


Pod::Spec.new do |s|
  s.name = 'UnsplashFramework'
  s.version = '0.1'
  s.license = 'MIT'
  s.summary = 'Lightweight framework for Unsplash in Swift.'
  s.description  = 'Elegant Unsplash API wrapper in Swift.'

  # Links
  s.homepage = 'https://github.com/camiletti/UnsplashFramework'
  s.social_media_url = 'https://twitter.com/camiletti_p'
  s.authors = { 'Pablo Camiletti' => 'contact@sweetskiesgame.com' }


  # Platforms
  s.platform     = :ios, "10.0" # Remove when other platforms are supported.
  #s.ios.deployment_target = '10.3'
  # s.osx.deployment_target = '10.12'
  # s.tvos.deployment_target = '10.0'
  # s.watchos.deployment_target = '3.0'

  # Source
  s.source = { :git => 'https://github.com/camiletti/UnsplashFramework.git', :tag => s.version }
  s.source_files = 'UnsplashFramework/Source/*.swift'
  #s.exclude_files = ''
  # s.public_header_files = ''

  # Config
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }

end
