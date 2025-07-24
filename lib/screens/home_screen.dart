import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  final List<Category> categories = [
    Category('Alle', Icons.grid_view_rounded, Colors.blue),
    Category('Auto', Icons.directions_car_rounded, Colors.red),
    Category('Möbel', Icons.chair_rounded, Colors.brown),
    Category('Elektronik', Icons.devices_rounded, Colors.purple),
    Category('Kleidung', Icons.checkroom_rounded, Colors.pink),
    Category('Sport', Icons.sports_soccer_rounded, Colors.green),
    Category('Bücher', Icons.menu_book_rounded, Colors.orange),
    Category('Haushalt', Icons.home_rounded, Colors.teal),
  ];

  final List<ListingItem> listings = [
    ListingItem(
      id: '1',
      title: 'iPhone 14 Pro Max 256GB Space Black',
      price: 899.0,
      location: 'Bochum Mitte',
      timeAgo: DateTime.now().subtract(const Duration(hours: 2)),
      imageUrl: 'https://picsum.photos/300/200?random=1',
      isFavorite: false,
      isPromoted: true,
    ),
    ListingItem(
      id: '2',
      title: 'Vintage Ledersofa 3-Sitzer braun',
      price: 450.0,
      location: 'Hamburg Altona',
      timeAgo: DateTime.now().subtract(const Duration(hours: 5)),
      imageUrl: 'https://picsum.photos/300/200?random=2',
      isFavorite: true,
      isPromoted: false,
    ),
    ListingItem(
      id: '3',
      title: 'MacBook Pro M2 13" 512GB',
      price: 1299.0,
      location: 'München Schwabing',
      timeAgo: DateTime.now().subtract(const Duration(days: 1)),
      imageUrl: 'https://picsum.photos/300/200?random=3',
      isFavorite: false,
      isPromoted: false,
    ),
    ListingItem(
      id: '4',
      title: 'Designer Esstisch Eiche massiv',
      price: 680.0,
      location: 'Köln Innenstadt',
      timeAgo: DateTime.now().subtract(const Duration(days: 2)),
      imageUrl: 'https://picsum.photos/300/200?random=4',
      isFavorite: false,
      isPromoted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildAppBar(),
          _buildSearchBar(),
          _buildCategories(),
          _buildPromotedSection(),
          _buildListings(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                context.theme.primaryColor.withOpacity(0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
        title: Row(
          children: [
            Icon(
              Icons.location_on_rounded,
              color: context.theme.primaryColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Bochum',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: context.theme.iconTheme.color,
              size: 20,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_rounded,
                color: context.theme.iconTheme.color,
              ),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16, right: 8),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Wonach suchst du?',
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.tune_rounded),
            ),
            filled: true,
            fillColor: context.theme.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.2),
    );
  }

  Widget _buildCategories() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: category.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: category.color.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            category.icon,
                            color: category.color,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.name,
                          style: context.textTheme.labelSmall,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPromotedSection() {
    final promotedListings = listings.where((item) => item.isPromoted).toList();

    if (promotedListings.isEmpty) return const SliverToBoxAdapter();

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Empfohlene Anzeigen',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: promotedListings.length,
              itemBuilder: (context, index) {
                return _buildPromotedCard(promotedListings[index], index);
              },
            ),
          ),
        ],
      ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
    );
  }

  Widget _buildPromotedCard(ListingItem item, int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        horizontalOffset: 50.0,
        child: FadeInAnimation(
          child: Container(
            width: 200,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: item.imageUrl,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 140,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.white,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              'TOP',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: GestureDetector(
                        onTap: () {
                          // Toggle favorite
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            item.isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color:
                                item.isFavorite ? Colors.red : Colors.grey[600],
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '€${item.price.toStringAsFixed(0)}',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.theme.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 12,
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
                        timeago.format(item.timeAgo, locale: 'de'),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.theme.textTheme.bodySmall?.color
                              ?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListings() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Alle Anzeigen',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }

            final listingIndex = index - 1;
            if (listingIndex >= listings.length) return null;

            return AnimationConfiguration.staggeredList(
              position: listingIndex,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: _buildListingCard(listings[listingIndex]),
                ),
              ),
            );
          },
          childCount: listings.length + 1,
        ),
      ),
    );
  }

  Widget _buildListingCard(ListingItem item) {
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
      child: Row(
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
              if (item.isPromoted)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'TOP',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
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
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '€${item.price.toStringAsFixed(0)}',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.theme.primaryColor,
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
                    timeago.format(item.timeAgo, locale: 'de'),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.theme.textTheme.bodySmall?.color
                          ?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                // Toggle favorite
              },
              child: Icon(
                item.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: item.isFavorite ? Colors.red : Colors.grey[400],
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  final String name;
  final IconData icon;
  final Color color;

  Category(this.name, this.icon, this.color);
}

class ListingItem {
  final String id;
  final String title;
  final double price;
  final String location;
  final DateTime timeAgo;
  final String imageUrl;
  final bool isFavorite;
  final bool isPromoted;

  ListingItem({
    required this.id,
    required this.title,
    required this.price,
    required this.location,
    required this.timeAgo,
    required this.imageUrl,
    required this.isFavorite,
    required this.isPromoted,
  });
}
