import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class ListingDetailModal extends StatefulWidget {
  final String listingId;
  final String title;
  final double price;
  final String location;
  final List<String> images;
  final String description;
  final String condition;
  final String category;
  final DateTime publishedAt;
  final String sellerName;
  final double sellerRating;
  final int sellerReviews;

  const ListingDetailModal({
    super.key,
    required this.listingId,
    required this.title,
    required this.price,
    required this.location,
    required this.images,
    required this.description,
    required this.condition,
    required this.category,
    required this.publishedAt,
    required this.sellerName,
    required this.sellerRating,
    required this.sellerReviews,
  });

  @override
  State<ListingDetailModal> createState() => _ListingDetailModalState();
}

class _ListingDetailModalState extends State<ListingDetailModal> {
  int _currentImageIndex = 0;
  bool _isFavorite = false;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageCarousel(),
                    _buildListingInfo(),
                    _buildDescription(),
                    _buildSellerInfo(),
                    _buildSimilarListings(),
                    const SizedBox(height: 100), // Space for bottom buttons
                  ],
                ),
              ),
            ),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_rounded),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _toggleFavorite,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                _isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: _isFavorite ? Colors.red : null,
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _shareListing,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.share_rounded),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.3);
  }

  Widget _buildImageCarousel() {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: widget.images.length,
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                onTap: () => _showImageGallery(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: widget.images[index],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 300,
              viewportFraction: 0.85,
              enlargeCenterPage: true,
              enableInfiniteScroll: widget.images.length > 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
            ),
          ),
          if (widget.images.length > 1)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.images.asMap().entries.map((entry) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentImageIndex == entry.key
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                    ),
                  );
                }).toList(),
              ),
            ),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_currentImageIndex + 1}/${widget.images.length}',
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 100.ms);
  }

  Widget _buildListingInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.category,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.theme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getConditionColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.condition,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: _getConditionColor(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '€${widget.price.toStringAsFixed(0)}',
            style: context.textTheme.displaySmall?.copyWith(
              color: context.theme.primaryColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 18,
                color: context.theme.textTheme.bodySmall?.color,
              ),
              const SizedBox(width: 8),
              Text(
                widget.location,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.access_time_rounded,
                size: 18,
                color: context.theme.textTheme.bodySmall?.color,
              ),
              const SizedBox(width: 8),
              Text(
                timeago.format(widget.publishedAt, locale: 'de'),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.theme.textTheme.bodySmall?.color,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 200.ms);
  }

  Widget _buildDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Beschreibung',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.description,
            style: context.textTheme.bodyMedium?.copyWith(
              height: 1.6,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 300.ms);
  }

  Widget _buildSellerInfo() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verkäufer',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: context.theme.primaryColor.withOpacity(0.1),
                child: Icon(
                  Icons.person_rounded,
                  color: context.theme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.sellerName,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.sellerRating.toStringAsFixed(1),
                          style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${widget.sellerReviews} Bewertungen)',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.theme.textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GFButton(
                onPressed: _viewSellerProfile,
                text: 'Profil',
                type: GFButtonType.outline2x,
                shape: GFButtonShape.pills,
                size: GFSize.SMALL,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 400.ms);
  }

  Widget _buildSimilarListings() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ähnliche Anzeigen',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: context.theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.image_rounded,
                            color: Colors.grey[500],
                            size: 32,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ähnliches Produkt ${index + 1}',
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '€${(index + 1) * 100}',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.theme.primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Bochum',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.theme.textTheme.bodySmall?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 500.ms);
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: GFButton(
                onPressed: _contactSeller,
                text: 'Nachricht senden',
                icon: const Icon(Icons.message_rounded, size: 18),
                size: GFSize.LARGE,
                shape: GFButtonShape.pills,
              ),
            ),
            const SizedBox(width: 12),
            GFButton(
              onPressed: _callSeller,
              text: '',
              icon: const Icon(Icons.phone_rounded, size: 20),
              type: GFButtonType.outline2x,
              shape: GFButtonShape.pills,
              size: GFSize.LARGE,
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: 1, duration: 400.ms, delay: 600.ms);
  }

  Color _getConditionColor() {
    switch (widget.condition.toLowerCase()) {
      case 'neu':
        return Colors.green;
      case 'sehr gut':
        return Colors.blue;
      case 'gut':
        return Colors.orange;
      case 'akzeptabel':
        return Colors.amber;
      case 'defekt':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showImageGallery(int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close_rounded, color: Colors.white),
            ),
            title: Text(
              '${initialIndex + 1} von ${widget.images.length}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: PhotoViewGallery.builder(
            itemCount: widget.images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(widget.images[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            pageController: PageController(initialPage: initialIndex),
          ),
        ),
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? 'Zu Favoriten hinzugefügt' : 'Aus Favoriten entfernt',
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _shareListing() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.title} geteilt'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _contactSeller() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Chat mit ${widget.sellerName} geöffnet'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _callSeller() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Anruf an ${widget.sellerName}'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _viewSellerProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profil von ${widget.sellerName} geöffnet'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
