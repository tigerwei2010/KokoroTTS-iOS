Pod::Spec.new do |s|
  s.name         = 'iOS-TTS'
  s.version      = '1.0.0'
  s.summary      = 'On-device text-to-speech using the Kokoro TTS model'
  s.homepage     = 'https://github.com/tigerwei2010/KokoroTTS-iOS'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = 'Otosaku'
  s.source       = { :git => 'https://github.com/tigerwei2010/KokoroTTS-iOS.git', :tag => s.version.to_s }

  s.platform     = :ios, '15.1'
  s.swift_version = '5.9'
  s.static_framework = true

  s.source_files  = 'Sources/iOS-TTS/**/*.swift'
  s.exclude_files = 'Sources/iOS-TTS/Espeak/**'

  s.frameworks = 'CoreML', 'Accelerate'

  s.dependency 'EspeakWrapper', '~> 1.0'
  s.dependency 'SwiftPOSTagger', '~> 1.0'
  s.dependency 'RosaKit', '~> 1.0'
end
