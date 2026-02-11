import 'package:flutter/material.dart';

class Song {
  final String id;
  final String title;
  final String artist;
  final String albumArtUrl;
  final Duration duration;
  final String audioUrl;
  final int bpm; // Beats per minute for animation sync

  // Cached extracted colors (nullable, extracted on demand)
  Color? dominantColor;
  Color? accentColor;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.albumArtUrl,
    required this.duration,
    required this.audioUrl,
    required this.bpm,
    this.dominantColor,
    this.accentColor,
  });
}

// ... rest of Album and Artist classes stay the same ...

final List<Song> mockSongs = [
  Song(
    id: '1',
    title: 'Starboy',
    artist: 'The Weeknd',
    albumArtUrl:
        'https://images.unsplash.com/photo-1614613535308-eb5fbd3d2c17?q=80&w=1000&auto=format&fit=crop',
    duration: const Duration(minutes: 3, seconds: 50),
    audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    bpm: 106, // Starboy actual BPM
  ),
  Song(
    id: '2',
    title: 'Blinding Lights',
    artist: 'The Weeknd',
    albumArtUrl:
        'https://images.unsplash.com/photo-1621274790572-7c32596bc67f?q=80&w=1000&auto=format&fit=crop',
    duration: const Duration(minutes: 3, seconds: 20),
    audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    bpm: 171, // Blinding Lights actual BPM
  ),
  Song(
    id: '3',
    title: 'Save Your Tears',
    artist: 'The Weeknd',
    albumArtUrl:
        'https://images.unsplash.com/photo-1493225255756-d9584f8606e9?q=80&w=1000&auto=format&fit=crop',
    duration: const Duration(minutes: 3, seconds: 35),
    audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    bpm: 118, // Save Your Tears actual BPM
  ),
];
