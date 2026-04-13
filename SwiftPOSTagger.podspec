Pod::Spec.new do |s|
  s.name         = 'SwiftPOSTagger'
  s.version      = '1.0.0'
  s.summary      = 'Vendored CoreML-based part-of-speech tagger'
  s.homepage     = 'https://github.com/tigerwei2010/KokoroTTS-iOS'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = 'Otosaku'
  s.source       = { :git => 'https://github.com/tigerwei2010/KokoroTTS-iOS.git', :tag => s.version.to_s }

  s.platform      = :ios, '15.1'
  s.swift_version = '5.9'

  s.source_files = 'Vendor/SwiftPOSTagger/**/*.swift'
  s.frameworks   = 'CoreML'
end
