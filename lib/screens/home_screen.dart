import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_new_shapes/material_new_shapes.dart';
import 'package:spotify_redesign/models.dart';
import 'package:spotify_redesign/providers.dart';
import 'package:spotify_redesign/widgets/blob_clipper.dart';
import 'package:spotify_redesign/widgets/material_polygon_border.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songList = ref.watch(songsProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          leading: const Icon(Icons.notifications_outlined),
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Good evening',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.aDLaMDisplay().fontFamily,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                padding: const EdgeInsets.all(2), // Border width
                decoration: const BoxDecoration(
                  color: Colors.white, // Border color
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.black, // Inner color
                  child: Text(
                    'A',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                _CategoryChip(
                  label: 'All',
                  isSelected: true,
                ).animate().fade(duration: 400.ms).slideX(begin: -0.2),
                const SizedBox(width: 8),
                _CategoryChip(label: 'Music')
                    .animate()
                    .fade(duration: 400.ms, delay: 100.ms)
                    .slideX(begin: -0.2),
                const SizedBox(width: 8),
                _CategoryChip(label: 'Podcasts')
                    .animate()
                    .fade(duration: 400.ms, delay: 200.ms)
                    .slideX(begin: -0.2),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 3.0,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final song = songList[index % songList.length];
              return _RecentCard(song: song, index: index)
                  .animate()
                  .fade(duration: 400.ms, delay: (50 * index).ms)
                  .scale(begin: const Offset(0.9, 0.9));
            }, childCount: 8),
          ),
        ),
        _SliverHeader(title: 'Jump back in'),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 240,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: songList.length,
              itemBuilder: (context, index) {
                final song = songList[index];
                return _HorizontalItem(song: song,index: index,)
                    .animate()
                    .fade(duration: 600.ms, delay: (100 * index).ms)
                    .slideX(begin: 0.1);
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
        _SliverHeader(title: 'Made for you'),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 240,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: songList.length,
              itemBuilder: (context, index) {
                final song = songList[(index + 1) % songList.length];
                return _HorizontalItem(song: song, isCircle: true,index: index)
                    .animate()
                    .fade(duration: 600.ms, delay: (100 * index).ms)
                    .slideX(begin: 0.1);
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _CategoryChip({required this.label, this.isSelected = false});

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

class _SliverHeader extends StatelessWidget {
  final String title;
  const _SliverHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary, // Yellow headers
          ),
        ),
      ),
    );
  }
}

class _RecentCard extends ConsumerWidget {
  final Song song;
  final int index;
  const _RecentCard({required this.song, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer, // Dark Purple
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => ref.read(currentSongProvider.notifier).setSong(song),
        child: Row(
          children: [
            Hero(
              tag: '${song.id}_recent',
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
                    ][(index % 6)],
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: song.albumArtUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[900],
                    child: const Icon(Icons.music_note, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                song.title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class _HorizontalItem extends ConsumerWidget {
  final Song song;
  final int index;
  final bool isCircle;
  const _HorizontalItem({
    required this.song,
    this.isCircle = false,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () => ref.read(currentSongProvider.notifier).setSong(song),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isCircle
                ? CircleAvatar(
                    radius: 80,
                    backgroundImage: CachedNetworkImageProvider(
                      song.albumArtUrl,
                    ),
                  )
                : Hero(
                    tag: '${song.id}_horiz_$isCircle',
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                        shape: MaterialPolygonBorder(
                          polygon: [
                            MaterialShapes.slanted,
                            MaterialShapes.softBurst,
                            MaterialShapes.clover8Leaf,
                          ][index % 3],
                        ),
                      ),
                      child: Container(
                        height: 160,
                        width: 160,
                        color: Colors.black12, // Placeholder bg
                        child: CachedNetworkImage(
                          imageUrl: song.albumArtUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 12),
            Text(
              song.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              'Album • ${song.artist}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
