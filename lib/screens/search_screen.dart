import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:material_new_shapes/material_new_shapes.dart';
import 'package:spotify_redesign/widgets/material_polygon_border.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: colors.surface,
              surfaceTintColor: Colors.transparent,
              pinned: true,
              expandedHeight: 220,
              collapsedHeight: 76,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final maxH = 220.0;
                  final minH = 76.0;

                  final progress =
                      ((constraints.maxHeight - minH) / (maxH - minH)).clamp(
                        0.0,
                        1.0,
                      );

                  final ease = Curves.easeOutCubic.transform(progress);

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      /// 🌫️ Subtle blur when collapsed
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: (1 - ease) * 8,
                            sigmaY: (1 - ease) * 8,
                          ),
                          child: const SizedBox(),
                        ),
                      ),

                      /// 🧠 EXPANDED HEADER
                      Positioned(
                        left: 16,
                        right: 16,
                        top: lerpDouble(40, 12, 1 - ease),
                        child: Opacity(
                          opacity: ease,
                          child: Transform.translate(
                            offset: Offset(0, lerpDouble(0, -20, 1 - ease)!),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Search',
                                  style: theme.textTheme.displayLarge?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -1.4,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Transform.scale(
                                  scale: lerpDouble(1.0, 0.95, 1 - ease)!,
                                  alignment: Alignment.topCenter,
                                  child: _searchField(
                                    colors,
                                    controller: _searchController,
                                    focusNode: _searchFocusNode,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// 🔒 PINNED SEARCH BAR
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 12,
                        child: Opacity(
                          opacity: 1 - ease,
                          child: Transform.scale(
                            scale: lerpDouble(0.92, 1.0, 1 - ease)!,
                            child: _searchField(
                              colors,
                              controller: _searchController,
                              focusNode: _searchFocusNode,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            /// Section title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: Text(
                  'Browse all',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                  ),
                ),
              ),
            ),

            /// 🎨 EXPRESSIVE CATEGORY GRID
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final colorsList = [
                    const Color(0xFFFF8FAB),
                    const Color(0xFFF3F96D),
                    const Color(0xFF5850DD),
                    const Color(0xFF00C2CB),
                    const Color(0xFFFF6B6B),
                    const Color(0xFFFFA500),
                  ];

                  final titles = [
                    'Pop',
                    'Indie',
                    'Hip Hop',
                    'Rock',
                    'Live Events',
                    'Made For You',
                  ];

                  final color = colorsList[(index + hashCode) % colorsList.length];
                  final title = titles[index % titles.length];
                  final isYellow = color == const Color(0xFFF3F96D);

                  return Transform.rotate(
                    angle: index.isEven ? -0.035 : 0.035,
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
                          ][(index + hashCode) % 6],
                        ),
                      ),

                      child: Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.center,
                        color: color,
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: isYellow ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }, childCount: 6),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
    );
  }
}

// Widget _ExpandedHeader(ThemeData theme, ColorScheme colors) {
//   return Column(
//     key: const ValueKey('expanded'),
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const SizedBox(height: 16),
//       Text(
//         'Search',
//         style: theme.textTheme.displayLarge?.copyWith(
//           fontWeight: FontWeight.w900,
//           letterSpacing: -1.4,
//         ),
//       ),
//       const SizedBox(height: 24),
//       _SearchField(colors),
//     ],
//   );
// }

// Widget _CollapsedSearchBar(ThemeData theme, ColorScheme colors) {
//   return Align(
//     key: const ValueKey('collapsed'),
//     alignment: Alignment.center,
//     child: _SearchField(colors),
//   );
// }

Widget _searchField(
  ColorScheme colors, {
  required TextEditingController controller,
  required FocusNode focusNode,
}) {
  return Material(
    color: colors.surfaceContainerHighest,
    borderRadius: BorderRadius.circular(28),
    child: TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: const InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    ),
  );
}
