import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_redesign/screens/home_screen.dart';
import 'package:spotify_redesign/screens/library_screen.dart';
import 'package:spotify_redesign/screens/search_screen.dart';
import 'package:spotify_redesign/theme.dart';
import 'package:spotify_redesign/screens/settings_screen.dart';
import 'package:spotify_redesign/widgets/mini_player.dart';

void main() {
  runApp(const ProviderScope(child: SpotifyApp()));
}

class SpotifyApp extends StatefulWidget {
  const SpotifyApp({super.key});

  @override
  State<SpotifyApp> createState() => _SpotifyAppState();
}

class _SpotifyAppState extends State<SpotifyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _handleThemeModeChange(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Redesign',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: MainNavigationScreen(
        themeMode: _themeMode,
        onThemeModeChanged: _handleThemeModeChange,
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const MainNavigationScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  List<Widget> get _screens => [
    const HomeScreen(),
    const SearchScreen(),
    const LibraryScreen(),
    SettingsScreen(
      currentThemeMode: widget.themeMode,
      onThemeModeChanged: widget.onThemeModeChanged,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_selectedIndex],
          const Positioned(left: 0, right: 0, bottom: 0, child: MiniPlayer()),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        surfaceTintColor: Colors.transparent,
        selectedIndex: _selectedIndex,
        elevation: 0,
        backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.library_music_outlined),
            selectedIcon: Icon(Icons.library_music),
            label: 'Your Library',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
