Pod::Spec.new do |s|
  s.name         = 'RosaKit'
  s.version      = '1.0.0'
  s.summary      = 'Vendored RosaKit with PlainPocketFFT (lightweight libRosa port for iOS)'
  s.homepage     = 'https://github.com/tigerwei2010/KokoroTTS-iOS'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = 'Dmytro Hrebeniuk'
  s.source       = { :git => 'https://github.com/tigerwei2010/KokoroTTS-iOS.git', :tag => s.version.to_s }

  s.platform      = :ios, '15.1'
  s.swift_version = '5.9'

  s.source_files = [
    'Vendor/RosaKit/**/*.swift',
    'Vendor/RosaKit/PlainPocketFFT/**/*.{h,m}',
  ]
  s.public_header_files = 'Vendor/RosaKit/PlainPocketFFT/*.h'

  s.frameworks = 'Accelerate'
end
