import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_redesign/models.dart';
import 'package:spotify_redesign/utils/color_extractor.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
AudioPlayer player(Ref ref) {
  final player = AudioPlayer();
  ref.onDispose(() => player.dispose());
  return player;
}

@riverpod
class CurrentSong extends _$CurrentSong {
  @override
  Song? build() => null;

  void setSong(Song song) async {
    state = song;
    final audioPlayer = ref.read(playerProvider);
    try {
      await audioPlayer.setUrl(song.audioUrl);
      audioPlayer.play();
    } catch (_) {
      // Silently handle error for now
    }
  }

  void skipNext() {
    if (state == null) return;
    final allSongs = ref.read(songsProvider);
    final currentIndex = allSongs.indexWhere((s) => s.id == state!.id);
    if (currentIndex != -1 && currentIndex < allSongs.length - 1) {
      setSong(allSongs[currentIndex + 1]);
    } else if (currentIndex == allSongs.length - 1) {
      // Loop back to first song
      setSong(allSongs[0]);
    }
  }

  void skipPrevious() {
    if (state == null) return;
    final allSongs = ref.read(songsProvider);
    final currentIndex = allSongs.indexWhere((s) => s.id == state!.id);
    if (currentIndex > 0) {
      setSong(allSongs[currentIndex - 1]);
    } else if (currentIndex == 0) {
      // Loop to last song
      setSong(allSongs[allSongs.length - 1]);
    }
  }
}

@riverpod
Stream<PlayerState> playerState(Ref ref) {
  return ref.watch(playerProvider).playerStateStream;
}

@riverpod
Stream<Duration> position(Ref ref) {
  return ref.watch(playerProvider).positionStream;
}

@riverpod
Stream<Duration?> duration(Ref ref) {
  return ref.watch(playerProvider).durationStream;
}

@riverpod
List<Song> songs(Ref ref) => mockSongs;

@riverpod
class DynamicThemeColors extends _$DynamicThemeColors {
  @override
  Future<ExtractedColors> build() async {
    final currentSong = ref.watch(currentSongProvider);

    if (currentSong == null) {
      return ExtractedColors.defaultColors();
    }

    // Check if colors are already cached in the song
    if (currentSong.dominantColor != null && currentSong.accentColor != null) {
      return ExtractedColors(
        dominant: currentSong.dominantColor!,
        accent: currentSong.accentColor!,
        muted: currentSong.dominantColor!,
        vibrant: currentSong.accentColor!,
      );
    }

    // Extract colors from album art
    final colors = await ColorExtractor.extractColors(currentSong.albumArtUrl);

    // Cache the colors in the song object
    currentSong.dominantColor = colors.dominant;
    currentSong.accentColor = colors.accent;

    return colors;
  }
}
