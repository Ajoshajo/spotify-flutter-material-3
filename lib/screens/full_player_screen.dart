import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_new_shapes/material_new_shapes.dart';
import 'package:spotify_redesign/providers.dart';
import 'package:spotify_redesign/widgets/blob_clipper.dart';
import 'package:spotify_redesign/widgets/bpm_wave_widget.dart';
import 'package:spotify_redesign/utils/color_extractor.dart';
import 'package:spotify_redesign/widgets/material_polygon_border.dart';

class FullPlayerScreen extends ConsumerStatefulWidget {
  const FullPlayerScreen({super.key});

  @override
  ConsumerState<FullPlayerScreen> createState() => _FullPlayerScreenState();
}

class _FullPlayerScreenState extends ConsumerState<FullPlayerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    if (ref.read(playerProvider).playing) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = ref.watch(currentSongProvider);
    final playerState = ref.watch(playerStateProvider).value;
    final isPlaying = playerState?.playing ?? false;
    final player = ref.read(playerProvider);
    final position = ref.watch(positionProvider).value ?? Duration.zero;
    final duration = ref.watch(durationProvider).value ?? Duration.zero;

    if (currentSong == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Watch dynamic theme colors extracted from album art
    final dynamicColorsAsync = ref.watch(dynamicThemeColorsProvider);
    final dynamicColors = dynamicColorsAsync.when(
      data: (colors) => colors,
      loading: () => ExtractedColors.defaultColors(),
      error: (_, _) => ExtractedColors.defaultColors(),
    );

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          // BPM-synced wave animation background
          Positioned.fill(
            child: BPMWaveWidget(
              bpm: currentSong.bpm,
              color1: dynamicColors.dominant,
              color2: dynamicColors.accent,
              isPlaying: isPlaying,
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.keyboard_arrow_down, size: 32),
                        color: Colors.white,
                      ),
                      Text(
                        'NOW PLAYING',
                        style: theme.textTheme.labelLarge?.copyWith(
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz, size: 32),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final size = constraints.maxWidth;
                        return Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            switchInCurve: Curves.easeInOut,
                            switchOutCurve: Curves.easeInOut,
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: Tween<double>(
                                    begin: 0.8,
                                    end: 1.0,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: Stack(
                              key: ValueKey(currentSong.id),
                              alignment: Alignment.center,
                              children: [
                                // Shadow Blob
                                Transform.translate(
                                  offset: const Offset(0, 20),
                                  child: Transform.scale(
                                    scale: 0.95,
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: ClipPath(
                                        clipper: BlobClipper(),
                                        child: Container(
                                          width: size,
                                          height: size,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Rotating Album Art Blob
                                RotationTransition(
                                  turns: _controller,
                                  child: Hero(
                                    tag: currentSong.id,
                                    child: ClipPath(
                                      clipper: ShapeBorderClipper(
                                        shape: MaterialPolygonBorder(
                                          polygon: [
                                            MaterialShapes.cookie12Sided,
                                            MaterialShapes.burst,
                                            MaterialShapes.arrow,
                                            MaterialShapes.slanted,
                                            MaterialShapes.clamShell,
                                            MaterialShapes.diamond,
                                          ][(1 + hashCode) % 6],
                                        ),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: currentSong.albumArtUrl,
                                        width: size,
                                        height: size,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                              color:
                                                  colorScheme.primaryContainer,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Song Info & Controls
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentSong.title,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentSong.artist,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white70,
                          letterSpacing: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 48),

                      // Chunky Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Previous
                          _CircleButton(
                            icon: Icons.skip_previous,
                            onTap: () {
                              ref
                                  .read(currentSongProvider.notifier)
                                  .skipPrevious();
                            },
                          ),
                          const SizedBox(width: 24),

                          // PLAY / PAUSE Pill
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (isPlaying) {
                                  player.pause();
                                  _controller.stop();
                                } else {
                                  player.play();
                                  _controller.repeat();
                                }
                              },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colorScheme.primary.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  isPlaying ? 'PAUSE' : 'PLAY',
                                  style: theme.textTheme.headlineMedium
                                      ?.copyWith(
                                        color: colorScheme.surface,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 2.0,
                                      ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 24),
                          // Next
                          _CircleButton(
                            icon: Icons.skip_next,
                            onTap: () {
                              ref.read(currentSongProvider.notifier).skipNext();
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Minimal Wave/Slider
                      Row(
                        children: [
                          Text(
                            _formatDuration(position),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white54,
                            ),
                          ),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 2,
                                trackShape: const RectangularSliderTrackShape(),
                                activeTrackColor: colorScheme.primary,
                                inactiveTrackColor: Colors.white24,
                                thumbColor: colorScheme.primary,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6,
                                ),
                                overlayShape: SliderComponentShape.noOverlay,
                              ),
                              child: Slider(
                                value: position.inMilliseconds.toDouble().clamp(
                                  0.0,
                                  duration.inMilliseconds.toDouble(),
                                ),
                                max: duration.inMilliseconds.toDouble() > 0
                                    ? duration.inMilliseconds.toDouble()
                                    : 1.0,
                                onChanged: (value) {
                                  player.seek(
                                    Duration(milliseconds: value.toInt()),
                                  );
                                },
                              ),
                            ),
                          ),
                          Text(
                            _formatDuration(duration),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary, // Yellow
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 64,
          height: 64,
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.surface, // Purple
            size: 28,
          ),
        ),
      ),
    );
  }
}
