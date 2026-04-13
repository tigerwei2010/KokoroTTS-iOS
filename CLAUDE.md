# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

KokoroTTS-iOS is a Swift Package that provides on-device text-to-speech using the Kokoro TTS model. It runs a multi-stage CoreML inference pipeline: text → G2P (grapheme-to-phoneme) → BERT tokenization → neural network inference → audio synthesis. Supports 9 languages and 54 voices. English and French are production-ready; other languages need G2P preprocessing work.

## Build & Test Commands

```bash
swift build                    # Build the library
swift test                     # Run all tests
swift test --filter iOS-TTSTests.VoiceTests   # Run a single test suite
swift test --enable-code-coverage              # Run tests with coverage
```

The Example app is a separate Xcode project:
```bash
open Example/Example.xcodeproj   # Open in Xcode, build/run on device
```

## Architecture

### TTS Pipeline Flow

```
Text → G2P → TTSModel (7 CoreML models) → Generator (vocoder) → [Float] audio samples
```

### Key Modules

- **`iOS_TTS.swift`** — Public API: `TTSPipeline`, `Language`, `VoiceStyle`, `GenerationOptions` enums. Entry point for consumers.
- **`Model.swift`** — Orchestrates 7 CoreML models in sequence: Albert → BertEncoder → DurationEncoder → ProsodyPredictor → F0Predictor → TextEncoder → Decoder.
- **`Generator.swift`** — Audio synthesis: takes decoder output through F0Upsample → SineGen → SourceModule → Generator → inverse STFT to produce Float32 audio samples.
- **`G2P/EN/G2PEn.swift`** — English grapheme-to-phoneme with POS tagging (via SwiftPOSTagger), lexicon lookups, and stress prediction. Most complex G2P implementation (~817 lines).
- **`G2P/EN/Lexicon.swift`** — English pronunciation dictionary with stress marking and heteronym handling.
- **`G2P/Simple/G2PSimple.swift`** — Espeak-ng backed G2P for French, Spanish, Italian, Portuguese, Hindi.
- **`Espeak/`** — Pre-built `libespeak-ng.xcframework` (iOS ARM64 only) with C wrapper (`EspeakWrapper`) and Swift bridge (`EspeakSwiftWrapper.swift`).
- **`SineGen.swift`** / **`RosaKitSTFT.swift`** — Audio DSP: harmonic generation and STFT via Accelerate/vDSP and RosaKit.
- **`NPYParser.swift`** — Loads `.npy` voice style vectors.
- **`PerformanceMonitor.swift`** — Thread-safe per-module timing for profiling the pipeline.

### Dependencies

- **RosaKit** (0.0.11) — FFT/STFT for audio processing
- **OtosakuPOSTagger-iOS** (1.0.0) — CoreML part-of-speech tagging for English G2P
- **libespeak-ng.xcframework** — Pre-built binary for phoneme conversion (vendored)

### External Resources (not in repo)

The library requires downloadable model/data files at runtime — see README.md for Firebase download URLs:
- CoreML TTS models (~2.5GB)
- G2P vocabulary JSON files
- POS tagger CoreML model
- Espeak-ng phoneme data

## Platform Requirements

- iOS 16.0+ / macOS 15.0+
- Swift 6.0+ (strict concurrency enabled)
- Xcode 16.0+

## Notable Conventions

- Generator forces CPU-only compute for stability (not Neural Engine)
- Uses `Accelerate` framework (`cblas_sgemm`, `vDSP`) for matrix/signal operations
- G2P protocol (`G2P.swift`) defines the interface all language G2P implementations conform to
- Voice styles are defined as an enum with 54 cases, each carrying language and gender metadata
