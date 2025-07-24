import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:getwidget/getwidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  RangeValues _priceRange = const RangeValues(0, 1000);
  double _distanceRange = 50;
  String _selectedCategory = 'Alle';
  String _sortBy = 'Neueste';

  final List<String> categories = [
    'Alle', 'Auto', 'Möbel', 'Elektronik', 'Kleidung', 
    'Sport', 'Bücher', 'Haushalt'
  ];

  final List<String> sortOptions = [
    'Neueste', 'Preis aufsteigend', 'Preis absteigend', 'Entfernung'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Suchen',
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchHeader(),
          _buildFilters(),
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Wonach suchst du?',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: IconButton(
                onPressed: () {
                  _searchController.clear();
                },
                icon: const Icon(Icons.clear_rounded),
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
            onChanged: (value) {
              // Implement search logic
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GFButton(
                  onPressed: () => _showFilters(),
                  text: 'Filter',
                  icon: const Icon(Icons.tune_rounded, size: 18),
                  type: GFButtonType.outline2x,
                  shape: GFButtonShape.pills,
                  size: GFSize.MEDIUM,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GFButton(
                  onPressed: () => _showSortOptions(),
                  text: _sortBy,
                  icon: const Icon(Icons.sort_rounded, size: 18),
                  type: GFButtonType.outline2x,
                  shape: GFButtonShape.pills,
                  size: GFSize.MEDIUM,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2);
  }

  Widget _buildFilters() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == _selectedCategory;
          
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              backgroundColor: context.theme.cardColor,
              selectedColor: context.theme.primaryColor.withOpacity(0.1),
              checkmarkColor: context.theme.primaryColor,
              labelStyle: TextStyle(
                color: isSelected 
                    ? context.theme.primaryColor 
                    : context.theme.textTheme.bodyMedium?.color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected 
                      ? context.theme.primaryColor 
                      : Colors.grey.shade300,
                ),
              ),
            ),
          );
        },
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 100.ms);
  }

  Widget _buildSearchResults() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '127 Ergebnisse gefunden',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return _buildSearchResultCard(index);
              },
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 200.ms);
  }

  Widget _buildSearchResultCard(int index) {
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
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(16),
            ),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey[300],
              child: Icon(
                Icons.image_rounded,
                color: Colors.grey[500],
                size: 40,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suchergebnis ${index + 1}',
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '€${(index + 1) * 50}',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.theme.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Berlin • vor ${index + 1} Stunden',
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(
              Icons.favorite_border_rounded,
              color: Colors.grey[400],
              size: 24,
            ),
          ),
        ],
      ),
    ).animate(delay: (index * 50).ms).fadeIn().slideX(begin: 0.2);
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildFilterBottomSheet(),
    );
  }

  Widget _buildFilterBottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preisbereich',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 2000,
                    divisions: 40,
                    labels: RangeLabels(
                      '€${_priceRange.start.round()}',
                      '€${_priceRange.end.round()}',
                    ),
                    onChanged: (values) {
                      setState(() {
                        _priceRange = values;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Entfernung',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: _distanceRange,
                    min: 5,
                    max: 100,
                    divisions: 19,
                    label: '${_distanceRange.round()} km',
                    onChanged: (value) {
                      setState(() {
                        _distanceRange = value;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: GFButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Apply filters
                      },
                      text: 'Filter anwenden',
                      size: GFSize.LARGE,
                      shape: GFButtonShape.pills,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 1, duration: 300.ms);
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
            ...sortOptions.map((option) => ListTile(
              title: Text(option),
              trailing: _sortBy == option 
                  ? Icon(
                      Icons.check_rounded,
                      color: context.theme.primaryColor,
                    )
                  : null,
              onTap: () {
                setState(() {
                  _sortBy = option;
                });
                Navigator.pop(context);
              },
            )).toList(),
            const SizedBox(height: 16),
          ],
        ),
      ).animate().slideY(begin: 1, duration: 300.ms),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

