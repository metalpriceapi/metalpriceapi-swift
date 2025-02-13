Pod::Spec.new do |s|
  s.name             = 'MetalpriceAPI'
  s.version          = '1.1.2'
  s.summary          = 'Official Swift wrapper for metalpriceapi.com'
  s.homepage         = 'https://github.com/metalpriceapi/metalpriceapi-swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'MetalpriceAPI' => 'contact@metalpriceapi.com' }
  s.source           = { :git => 'https://github.com/metalpriceapi/metalpriceapi-swift.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.swift_version = '5.9.2'
  s.source_files = 'Sources/MetalpriceAPI/**/*'
end
