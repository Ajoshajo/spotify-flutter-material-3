# Spotify Redesign 🎵

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge" alt="License" />
  <img src="https://img.shields.io/github/stars/ajoshajo/spotify_redesign?style=for-the-badge" alt="GitHub stars" />
</p>

A high-fidelity, motion-heavy Spotify UI concept built with Flutter. This project reimagines the digital music experience through a lens of **visual excellence**, **dynamic generative design**, and **expressive micro-animations**.

---

## ✨ Key Features

- **🎨 Dynamic Theming**: Harnesses `palette_generator` to extract vibrant color schemes from album art in real-time, creating a context-aware UI that breathes with the music.
- **🌊 Generative Audio Visuals**: Features custom-built BPM-synced wave animations and interactive background shaders that react to the rhythm.
- **🔷 Expressive Material Shapes**: Leverages the power of `material_new_shapes` to move beyond standard rectangles, using complex polygons for a modern, architectural aesthetic.
- **🚀 Ultra-Smooth Motion**: Implementation of advanced `Hero` transitions and custom `PageTransitions` for a "liquid" app experience.
- **📡 State-of-the-art State Management**: Built with `Riverpod` for high-performance, predictable audio playback control and state synchronization.

## 🛠️ Tech Stack

| Layer | Technology |
| :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev) & [Dart](https://dart.dev) |
| **State Management** | [Riverpod 3.0](https://riverpod.dev) |
| **Audio Processing** | [just_audio](https://pub.dev/packages/just_audio) |
| **Animation Engine** | [flutter_animate](https://pub.dev/packages/flutter_animate) & [animations](https://pub.dev/packages/animations) |
| **Design System** | Custom Material 3 + [Material New Shapes](https://pub.dev/packages/material_new_shapes) |

## 📁 Project Structure

```text
lib/
├── models.dart          # Core data structures (Song, Artist, Album)
├── providers.dart       # Riverpod providers for audio & state
├── screens/             # Feature-specific screens (Home, Player, Search)
├── widgets/             # Reusable UI components (BPM Waves, MiniPlayer)
└── utils/               # Helper utilities (Color Extraction)
```

## 🚀 Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/ajoshajo/spotify_redesign.git
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the generator** (if using Riverpod generator)
   ```bash
   dart run build_runner build
   ```

4. **Launch the application**
   ```bash
   flutter run
   ```

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

<p align="center">
  Built with ❤️ and Flutter by [ajoshajo](https://github.com/ajoshajo)
</p>
