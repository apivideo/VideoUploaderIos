Pod::Spec.new do |s|
  s.name = 'ApiVideoUploader'
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  # Add back when CocoaPods/CocoaPods#11558 is released
  #s.watchos.deployment_target = '3.0'
  s.version = '1.2.2'
  s.source = { :git => 'https://github.com/apivideo/api.video-swift-uploader', :tag => 'v1.2.2' }
  s.authors = { 'Ecosystem Team' => 'ecosystem@api.video' }
  s.license = { :type => 'MIT' }
  s.homepage = 'https://docs.api.video'
  s.summary = 'The official Swift api.video uploader for iOS, macOS and tvOS'
  s.source_files = 'Sources/**/*.swift'
  s.dependency 'AnyCodable-FlightSchool', '~> 0.6.1'
end
