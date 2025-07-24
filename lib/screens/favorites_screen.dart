import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<FavoriteItem> favorites = [
    FavoriteItem(
      id: '1',
      title: 'iPhone 14 Pro Max 256GB Space Black',
      price: 899.0,
      location: 'Bochum Mitte',
      imageUrl: 'https://picsum.photos/300/200?random=1',
      addedAt: DateTime.now().subtract(const Duration(hours: 2)),
      isAvailable: true,
    ),
    FavoriteItem(
      id: '2',
      title: 'Vintage Ledersofa 3-Sitzer braun',
      price: 450.0,
      location: 'Hamburg Altona',
      imageUrl: 'https://picsum.photos/300/200?random=2',
      addedAt: DateTime.now().subtract(const Duration(days: 1)),
      isAvailable: true,
    ),
    FavoriteItem(
      id: '3',
      title: 'MacBook Pro M2 13" 512GB',
      price: 1299.0,
      location: 'München Schwabing',
      imageUrl: 'https://picsum.photos/300/200?random=3',
      addedAt: DateTime.now().subtract(const Duration(days: 3)),
      isAvailable: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favoriten',
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showSortOptions,
            icon: const Icon(Icons.sort_rounded),
          ),
        ],
      ),
      body: favorites.isEmpty ? _buildEmptyState() : _buildFavoritesList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 24),
          Text(
            'Keine Favoriten',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Speichere interessante Anzeigen\nals Favoriten',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to search
            },
            icon: const Icon(Icons.search_rounded),
            label: const Text('Jetzt suchen'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildFavoritesList() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                '${favorites.length} Favoriten',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: _clearAllFavorites,
                icon: const Icon(Icons.clear_all_rounded, size: 18),
                label: const Text('Alle löschen'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildFavoriteCard(favorites[index], index),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFavoriteCard(FavoriteItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 120,
                          height: 120,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  if (!item.isAvailable)
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'VERKAUFT',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: item.isAvailable ? null : Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '€${item.price.toStringAsFixed(0)}',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: item.isAvailable
                              ? context.theme.primaryColor
                              : Colors.grey[500],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 14,
                            color: context.theme.textTheme.bodySmall?.color,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              item.location,
                              style: context.textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Hinzugefügt ${timeago.format(item.addedAt, locale: 'de')}',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.theme.textTheme.bodySmall?.color
                              ?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.grey[600],
              ),
              onSelected: (value) {
                switch (value) {
                  case 'remove':
                    _removeFavorite(index);
                    break;
                  case 'share':
                    _shareItem(item);
                    break;
                  case 'contact':
                    _contactSeller(item);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'contact',
                  child: Row(
                    children: [
                      Icon(Icons.message_rounded, size: 18),
                      SizedBox(width: 12),
                      Text('Verkäufer kontaktieren'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(Icons.share_rounded, size: 18),
                      SizedBox(width: 12),
                      Text('Teilen'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'remove',
                  child: Row(
                    children: [
                      Icon(Icons.favorite_rounded, size: 18, color: Colors.red),
                      SizedBox(width: 12),
                      Text('Aus Favoriten entfernen'),
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

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Sortieren nach',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.access_time_rounded),
              title: const Text('Zuletzt hinzugefügt'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.euro_rounded),
              title: const Text('Preis aufsteigend'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.euro_rounded),
              title: const Text('Preis absteigend'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.location_on_rounded),
              title: const Text('Entfernung'),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ).animate().slideY(begin: 1, duration: 300.ms),
    );
  }

  void _clearAllFavorites() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alle Favoriten löschen?'),
        content: const Text(
          'Möchtest du wirklich alle Favoriten entfernen? Diese Aktion kann nicht rückgängig gemacht werden.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                favorites.clear();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Alle Favoriten entfernt'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Löschen'),
          ),
        ],
      ),
    );
  }

  void _removeFavorite(int index) {
    final item = favorites[index];
    setState(() {
      favorites.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.title} aus Favoriten entfernt'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
          label: 'Rückgängig',
          onPressed: () {
            setState(() {
              favorites.insert(index, item);
            });
          },
        ),
      ),
    );
  }

  void _shareItem(FavoriteItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.title} geteilt'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _contactSeller(FavoriteItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Chat mit Verkäufer von ${item.title} geöffnet'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class FavoriteItem {
  final String id;
  final String title;
  final double price;
  final String location;
  final String imageUrl;
  final DateTime addedAt;
  final bool isAvailable;

  FavoriteItem({
    required this.id,
    required this.title,
    required this.price,
    required this.location,
    required this.imageUrl,
    required this.addedAt,
    required this.isAvailable,
  });
}
