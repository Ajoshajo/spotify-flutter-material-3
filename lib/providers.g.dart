// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(player)
final playerProvider = PlayerProvider._();

final class PlayerProvider
    extends $FunctionalProvider<AudioPlayer, AudioPlayer, AudioPlayer>
    with $Provider<AudioPlayer> {
  PlayerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playerHash();

  @$internal
  @override
  $ProviderElement<AudioPlayer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AudioPlayer create(Ref ref) {
    return player(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioPlayer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioPlayer>(value),
    );
  }
}

String _$playerHash() => r'43011ae08d57f972a3ddb9eadd4468f166a8be5d';

@ProviderFor(CurrentSong)
final currentSongProvider = CurrentSongProvider._();

final class CurrentSongProvider extends $NotifierProvider<CurrentSong, Song?> {
  CurrentSongProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentSongProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentSongHash();

  @$internal
  @override
  CurrentSong create() => CurrentSong();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Song? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Song?>(value),
    );
  }
}

String _$currentSongHash() => r'5ad1e68f4462df734f730d3feb9accad6d177426';

abstract class _$CurrentSong extends $Notifier<Song?> {
  Song? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Song?, Song?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Song?, Song?>,
              Song?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(playerState)
final playerStateProvider = PlayerStateProvider._();

final class PlayerStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<PlayerState>,
          PlayerState,
          Stream<PlayerState>
        >
    with $FutureModifier<PlayerState>, $StreamProvider<PlayerState> {
  PlayerStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playerStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playerStateHash();

  @$internal
  @override
  $StreamProviderElement<PlayerState> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<PlayerState> create(Ref ref) {
    return playerState(ref);
  }
}

String _$playerStateHash() => r'0ff64e373101ac6a056886def94375708d5a0b15';

@ProviderFor(position)
final positionProvider = PositionProvider._();

final class PositionProvider
    extends
        $FunctionalProvider<AsyncValue<Duration>, Duration, Stream<Duration>>
    with $FutureModifier<Duration>, $StreamProvider<Duration> {
  PositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'positionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$positionHash();

  @$internal
  @override
  $StreamProviderElement<Duration> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Duration> create(Ref ref) {
    return position(ref);
  }
}

String _$positionHash() => r'7d07cfc06ed4869e2389c97c4a20fb3b5fc1cceb';

@ProviderFor(duration)
final durationProvider = DurationProvider._();

final class DurationProvider
    extends
        $FunctionalProvider<AsyncValue<Duration?>, Duration?, Stream<Duration?>>
    with $FutureModifier<Duration?>, $StreamProvider<Duration?> {
  DurationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'durationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$durationHash();

  @$internal
  @override
  $StreamProviderElement<Duration?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Duration?> create(Ref ref) {
    return duration(ref);
  }
}

String _$durationHash() => r'2d7a6878e64f5bb6aec8abedb20374df10aab301';

@ProviderFor(songs)
final songsProvider = SongsProvider._();

final class SongsProvider
    extends $FunctionalProvider<List<Song>, List<Song>, List<Song>>
    with $Provider<List<Song>> {
  SongsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'songsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$songsHash();

  @$internal
  @override
  $ProviderElement<List<Song>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Song> create(Ref ref) {
    return songs(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Song> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Song>>(value),
    );
  }
}

String _$songsHash() => r'a607e70da98f8a7a3f92d56b47faa3c93e2e4193';

@ProviderFor(DynamicThemeColors)
final dynamicThemeColorsProvider = DynamicThemeColorsProvider._();

final class DynamicThemeColorsProvider
    extends $AsyncNotifierProvider<DynamicThemeColors, ExtractedColors> {
  DynamicThemeColorsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dynamicThemeColorsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dynamicThemeColorsHash();

  @$internal
  @override
  DynamicThemeColors create() => DynamicThemeColors();
}

String _$dynamicThemeColorsHash() =>
    r'971173494e822ae18c6c2a8b75cea1e593316ea8';

abstract class _$DynamicThemeColors extends $AsyncNotifier<ExtractedColors> {
  FutureOr<ExtractedColors> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ExtractedColors>, ExtractedColors>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ExtractedColors>, ExtractedColors>,
              AsyncValue<ExtractedColors>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
