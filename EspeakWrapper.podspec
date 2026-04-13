Pod::Spec.new do |s|
  s.name         = 'EspeakWrapper'
  s.version      = '1.0.0'
  s.summary      = 'C wrapper for espeak-ng library'
  s.homepage     = 'https://github.com/tigerwei2010/KokoroTTS-iOS'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = 'Otosaku'
  s.source       = { :git => 'https://github.com/tigerwei2010/KokoroTTS-iOS.git', :tag => s.version.to_s }

  s.platform     = :ios, '15.1'
  s.static_framework = true

  s.source_files        = 'Sources/EspeakWrapper/*.{c,h}'
  s.public_header_files = 'Sources/EspeakWrapper/*.h'

  s.vendored_frameworks = 'Sources/iOS-TTS/Espeak/libespeak-ng.xcframework'
  s.preserve_paths      = 'Sources/iOS-TTS/Espeak/include/**/*'

  s.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '$(PODS_TARGET_SRCROOT)/Sources/iOS-TTS/Espeak/include',
  }
end
