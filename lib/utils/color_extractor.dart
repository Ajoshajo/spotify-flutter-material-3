import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ColorExtractor {
  /// Extract dominant and accent colors from an album art URL
  static Future<ExtractedColors> extractColors(String imageUrl) async {
    try {
      // Load image from network
      final imageProvider = CachedNetworkImageProvider(imageUrl);

      // Generate palette
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        imageProvider,
        maximumColorCount: 20,
      );

      // Extract colors with fallbacks
      Color dominantColor =
          paletteGenerator.dominantColor?.color ??
          const Color(0xFF7B73FF); // Fallback to Serafina purple

      Color accentColor =
          paletteGenerator.vibrantColor?.color ??
          paletteGenerator.lightVibrantColor?.color ??
          const Color(0xFFF3F96D); // Fallback to Serafina yellow

      // Ensure sufficient contrast for readability
      if (_calculateLuminance(dominantColor) > 0.5) {
        // If dominant is light, ensure accent is darker
        accentColor = _ensureDarkColor(accentColor);
      } else {
        // If dominant is dark, ensure accent is lighter
        accentColor = _ensureLightColor(accentColor);
      }

      return ExtractedColors(
        dominant: dominantColor,
        accent: accentColor,
        muted: paletteGenerator.mutedColor?.color ?? dominantColor,
        vibrant: paletteGenerator.vibrantColor?.color ?? accentColor,
      );
    } catch (e) {
      // Return default Serafina colors on error
      return ExtractedColors.defaultColors();
    }
  }

  static double _calculateLuminance(Color color) {
    return (0.299 * (color.r * 255.0).round() +
            0.587 * (color.g * 255.0).round() +
            0.114 * (color.b * 255.0).round()) /
        255;
  }

  static Color _ensureDarkColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    if (hsl.lightness > 0.5) {
      return hsl.withLightness(0.3).toColor();
    }
    return color;
  }

  static Color _ensureLightColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    if (hsl.lightness < 0.5) {
      return hsl.withLightness(0.7).toColor();
    }
    return color;
  }
}

class ExtractedColors {
  final Color dominant;
  final Color accent;
  final Color muted;
  final Color vibrant;

  const ExtractedColors({
    required this.dominant,
    required this.accent,
    required this.muted,
    required this.vibrant,
  });

  factory ExtractedColors.defaultColors() {
    return const ExtractedColors(
      dominant: Color(0xFF7B73FF), // Serafina purple
      accent: Color(0xFFF3F96D), // Serafina yellow
      muted: Color(0xFF5850DD), // Serafina dark purple
      vibrant: Color(0xFFFF8FAB), // Serafina pink
    );
  }
}
