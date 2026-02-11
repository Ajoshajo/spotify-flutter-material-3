import 'package:flutter/material.dart';
import 'package:spotify_redesign/widgets/blob_clipper.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: colorScheme.surface,
              surfaceTintColor: Colors.transparent,
              floating: true,
              pinned: true,
              expandedHeight: 120,
              toolbarHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                title: Text(
                  'Your Library',
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, size: 28),
                  color: Colors.white,
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 28),
                  color: Colors.white,
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    _FilterChip(label: 'Playlists', isSelected: true),
                    const SizedBox(width: 8),
                    _FilterChip(label: 'Artists'),
                    const SizedBox(width: 8),
                    _FilterChip(label: 'Albums'),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 16),
                _LibraryItem(
                  icon: Icons.favorite,
                  iconColor: colorScheme.secondary, // Pink
                  title: 'Liked Songs',
                  subtitle: 'Playlist • 120 songs',
                  isPinned: true,
                ),
                const SizedBox(height: 16),
                _LibraryItem(
                  icon: Icons.bookmark,
                  iconColor: const Color(0xFF00C2CB), // Teal
                  title: 'Your Episodes',
                  subtitle: 'Updated 2 days ago',
                  isPinned: true,
                ),
                const SizedBox(height: 16),
              ]),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _LibraryItem(
                    icon: Icons.music_note,
                    iconColor: Colors.grey[800]!,
                    title: 'My Playlist #${index + 1}',
                    subtitle: 'Playlist • Created by you',
                  ),
                );
              }, childCount: 10),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _FilterChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.primary : Colors.transparent,
        border: Border.all(
          color: isSelected ? colorScheme.primary : Colors.white30,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          color: isSelected ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _LibraryItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isPinned;

  const _LibraryItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.isPinned = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ClipPath(
            clipper: BlobClipper(),
            child: Container(
              width: 64,
              height: 64,
              color: isPinned ? Colors.white10 : Colors.white10,
              alignment: Alignment.center,
              child: Icon(icon, color: iconColor, size: 32),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70,fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
