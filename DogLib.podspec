
Pod::Spec.new do |s|
  s.name             = 'DogLib'
  s.version          = '0.0.2'
  s.homepage         = 'https://github.com/stalikoff/DogLib'
  s.summary          = 'Library to load and cache random dog images from public API'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Oleg Vasilev' => 'o.vasilev@danycom.ru' }
  s.source           = { :git => 'git@github.com:stalikoff/DogLib.git', :tag => s.version.to_s }
  s.swift_version = '5.0'
  s.ios.deployment_target = '12.0'
  s.source_files = 'DogLib/Source/**/*.swift'
  s.resources = 'DogLib/**/*.xcdatamodeld'
  s.dependency 'Alamofire', '~> 5.6'

# ------ tests ------
  s.test_spec 'UnitTests' do |test_spec|
    test_spec.source_files = 'DogLib/UnitTests/**/*'
    test_spec.dependency 'Nimble', '~> 10.0.0'
    test_spec.dependency 'Quick', '~> 5.0.1'
  end

end
