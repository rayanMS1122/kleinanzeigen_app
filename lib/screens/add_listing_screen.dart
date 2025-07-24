import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final PageController _pageController = PageController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  int _currentStep = 0;

  final List<String> _stepTitles = [
    'Kategorie',
    'Details',
    'Bilder',
    'Standort',
    'Vorschau'
  ];

  final List<String> categories = [
    'Auto',
    'Möbel',
    'Elektronik',
    'Kleidung',
    'Sport',
    'Bücher',
    'Haushalt',
    'Sonstiges'
  ];

  List<String> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Anzeige erstellen',
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: FormBuilder(
              key: _formKey,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentStep = index;
                  });
                },
                children: [
                  _buildCategoryStep(),
                  _buildDetailsStep(),
                  _buildImagesStep(),
                  _buildLocationStep(),
                  _buildPreviewStep(),
                ],
              ),
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: List.generate(_stepTitles.length, (index) {
              final isActive = index == _currentStep;
              final isCompleted = index < _currentStep;

              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(
                    right: index < _stepTitles.length - 1 ? 8 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: isCompleted || isActive
                        ? context.theme.primaryColor
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Text(
            'Schritt ${_currentStep + 1} von ${_stepTitles.length}: ${_stepTitles[_currentStep]}',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.theme.primaryColor,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildCategoryStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wähle eine Kategorie',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'In welcher Kategorie möchtest du deine Anzeige veröffentlichen?',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.theme.textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 24),
          FormBuilderRadioGroup<String>(
            name: 'category',
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            options: categories
                .map(
                  (category) => FormBuilderFieldOption(
                    value: category,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: context.theme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getCategoryIcon(category),
                            color: context.theme.primaryColor,
                            size: 24,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            category,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey.shade400,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
            validator: FormBuilderValidators.required(
              errorText: 'Bitte wähle eine Kategorie',
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2);
  }

  Widget _buildDetailsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Anzeigendetails',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Beschreibe dein Artikel so detailliert wie möglich.',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.theme.textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 24),
          FormBuilderTextField(
            name: 'title',
            decoration: InputDecoration(
              labelText: 'Titel *',
              hintText: 'z.B. iPhone 14 Pro Max 256GB',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: context.theme.cardColor,
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: 'Titel ist erforderlich'),
              FormBuilderValidators.minLength(5,
                  errorText: 'Mindestens 5 Zeichen'),
            ]),
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            name: 'description',
            decoration: InputDecoration(
              labelText: 'Beschreibung *',
              hintText: 'Beschreibe dein Artikel...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: context.theme.cardColor,
            ),
            maxLines: 5,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: 'Beschreibung ist erforderlich'),
              FormBuilderValidators.minLength(20,
                  errorText: 'Mindestens 20 Zeichen'),
            ]),
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            name: 'price',
            decoration: InputDecoration(
              labelText: 'Preis *',
              hintText: '0',
              prefixText: '€ ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: context.theme.cardColor,
            ),
            keyboardType: TextInputType.number,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: 'Preis ist erforderlich'),
              FormBuilderValidators.numeric(errorText: 'Nur Zahlen erlaubt'),
              FormBuilderValidators.min(0,
                  errorText: 'Preis muss positiv sein'),
            ]),
          ),
          const SizedBox(height: 16),
          FormBuilderDropdown<String>(
            name: 'condition',
            decoration: InputDecoration(
              labelText: 'Zustand *',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: context.theme.cardColor,
            ),
            items: [
              'Neu',
              'Sehr gut',
              'Gut',
              'Akzeptabel',
              'Defekt',
            ]
                .map((condition) => DropdownMenuItem(
                      value: condition,
                      child: Text(condition),
                    ))
                .toList(),
            validator: FormBuilderValidators.required(
              errorText: 'Bitte wähle einen Zustand',
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2);
  }

  Widget _buildImagesStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bilder hinzufügen',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Füge bis zu 10 Bilder hinzu. Das erste Bild wird als Hauptbild verwendet.',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.theme.textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: selectedImages.length + 1,
            itemBuilder: (context, index) {
              if (index == selectedImages.length) {
                return _buildAddImageButton();
              }
              return _buildImagePreview(selectedImages[index], index);
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2);
  }

  Widget _buildAddImageButton() {
    return GestureDetector(
      onTap: _addImage,
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.theme.primaryColor.withOpacity(0.3),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_rounded,
              color: context.theme.primaryColor,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'Bild\nhinzufügen',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.theme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(String imagePath, int index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(
              Icons.image_rounded,
              color: Colors.grey[500],
              size: 40,
            ),
          ),
        ),
        if (index == 0)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: context.theme.primaryColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'HAUPT',
                style: context.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => _removeImage(index),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Standort',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Wo befindet sich dein Artikel?',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.theme.textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 24),
          FormBuilderTextField(
            name: 'location',
            decoration: InputDecoration(
              labelText: 'Adresse oder PLZ *',
              hintText: 'z.B. 10115 Bochum',
              prefixIcon: const Icon(Icons.location_on_rounded),
              suffixIcon: IconButton(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.my_location_rounded),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: context.theme.cardColor,
            ),
            validator: FormBuilderValidators.required(
              errorText: 'Standort ist erforderlich',
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_rounded,
                    color: Colors.grey[500],
                    size: 48,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Karte wird hier angezeigt',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2);
  }

  Widget _buildPreviewStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vorschau',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'So wird deine Anzeige aussehen:',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.theme.textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 24),
          Container(
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
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image_rounded,
                      color: Colors.grey[500],
                      size: 48,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formKey.currentState?.fields['title']?.value ??
                            'Titel',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '€${_formKey.currentState?.fields['price']?.value ?? '0'}',
                        style: context.textTheme.titleLarge?.copyWith(
                          color: context.theme.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: context.theme.textTheme.bodySmall?.color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formKey.currentState?.fields['location']?.value ??
                                'Standort',
                            style: context.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'vor wenigen Sekunden',
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
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2);
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: GFButton(
                onPressed: _previousStep,
                text: 'Zurück',
                type: GFButtonType.outline2x,
                shape: GFButtonShape.pills,
                size: GFSize.LARGE,
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: GFButton(
              onPressed: _currentStep < _stepTitles.length - 1
                  ? _nextStep
                  : _publishListing,
              text: _currentStep < _stepTitles.length - 1
                  ? 'Weiter'
                  : 'Veröffentlichen',
              size: GFSize.LARGE,
              shape: GFButtonShape.pills,
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 1, duration: 300.ms);
  }

  void _nextStep() {
    if (_validateCurrentStep()) {
      if (_currentStep < _stepTitles.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _formKey.currentState?.fields['category']?.validate() ?? false;
      case 1:
        return _formKey.currentState?.fields['title']?.validate() == true &&
            _formKey.currentState?.fields['description']?.validate() == true &&
            _formKey.currentState?.fields['price']?.validate() == true &&
            _formKey.currentState?.fields['condition']?.validate() == true;
      case 2:
        return selectedImages.isNotEmpty;
      case 3:
        return _formKey.currentState?.fields['location']?.validate() ?? false;
      default:
        return true;
    }
  }

  void _publishListing() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      // Publish listing logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Anzeige erfolgreich veröffentlicht!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  void _addImage() {
    if (selectedImages.length < 10) {
      setState(() {
        selectedImages.add('dummy_image_${selectedImages.length}');
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  void _getCurrentLocation() {
    // Get current location logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Standort wird ermittelt...'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Auto':
        return Icons.directions_car_rounded;
      case 'Möbel':
        return Icons.chair_rounded;
      case 'Elektronik':
        return Icons.devices_rounded;
      case 'Kleidung':
        return Icons.checkroom_rounded;
      case 'Sport':
        return Icons.sports_soccer_rounded;
      case 'Bücher':
        return Icons.menu_book_rounded;
      case 'Haushalt':
        return Icons.home_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
