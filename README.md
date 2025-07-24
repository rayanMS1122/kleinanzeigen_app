# 🏪 Kleinanzeigen Flutter App

Eine moderne, fortschrittliche Flutter-Anwendung für Kleinanzeigen mit den besten verfügbaren UI-Paketen und modernen Design-Prinzipien.

## ✨ Features

### 🎨 **Modernes UI Design**
- **Material Design 3** mit FlexColorScheme für konsistente Farbpaletten
- **Google Fonts (Inter)** für professionelle Typografie
- **Responsive Design** für verschiedene Bildschirmgrößen
- **Dark/Light Theme** Support

### 🚀 **Erweiterte Animationen**
- **Flutter Animate** für flüssige Übergänge
- **Staggered Animations** für Listen und Grids
- **Lottie Animationen** für interaktive Elemente
- **Rive Animationen** für komplexe Bewegungen
- **Shimmer Effects** für Ladeanimationen

### 📱 **Hauptfunktionen**

#### 🏠 **Home Screen**
- Dynamische Kategorien mit Icons
- Empfohlene/Beworbene Anzeigen Carousel
- Infinite Scroll mit Lazy Loading
- Pull-to-Refresh Funktionalität
- Suchleiste mit Standort-Integration

#### 🔍 **Erweiterte Suche**
- Filterbare Kategorien
- Preisbereich-Slider (RangeSlider)
- Entfernungsfilter mit GPS
- Sortieroptionen (Preis, Datum, Entfernung)
- Echtzeit-Suchergebnisse

#### ➕ **Anzeige Erstellen**
- **5-Schritt Wizard** mit Fortschrittsanzeige
- Kategorie-Auswahl mit Icons
- Multi-Image Upload (bis zu 10 Bilder)
- Formular-Validierung mit flutter_form_builder
- GPS-Standort Integration
- Live-Vorschau der Anzeige

#### ❤️ **Favoriten**
- Persistente Favoriten-Speicherung
- Sortier- und Filteroptionen
- Swipe-to-Delete mit Undo-Funktion
- Verkauft/Verfügbar Status-Anzeige

#### 👤 **Profil & Einstellungen**
- Benutzer-Dashboard mit Statistiken
- Dark/Light Mode Toggle
- Benachrichtigungs-Einstellungen
- Standort-Präferenzen
- Sicherheits-Einstellungen

### 🎭 **UI Komponenten**

#### 🌟 **Splash Screen**
- Animiertes Logo mit Rotation und Skalierung
- Floating Particles Animation
- Gradient Background
- Smooth Transition zur Haupt-App

#### 🖼️ **Listing Detail Modal**
- **Image Carousel** mit Zoom-Funktionalität
- **Photo Gallery** mit PhotoView
- Verkäufer-Informationen mit Bewertungen
- Ähnliche Anzeigen Vorschläge
- Kontakt- und Teilen-Funktionen

#### 🧭 **Navigation**
- **Custom Bottom Navigation** mit Animationen
- Floating Action Button für "Anzeige erstellen"
- Smooth Page Transitions
- Haptic Feedback

## 🛠️ **Technische Details**

### 📦 **Verwendete Pakete**

#### **UI & Design**
- `getwidget: ^4.0.0` - UI Komponenten Bibliothek
- `velocity_x: ^4.1.2` - Utility-first UI Framework
- `flex_color_scheme: ^7.3.1` - Erweiterte Theme-Unterstützung
- `google_fonts: ^6.2.1` - Google Fonts Integration
- `flutter_vector_icons: ^2.0.0` - Icon Bibliothek

#### **Animationen**
- `flutter_animate: ^4.5.0` - Moderne Animationen
- `flutter_staggered_animations: ^1.1.1` - Gestaffelte Animationen
- `lottie: ^3.1.2` - Lottie Animationen
- `rive: ^0.13.13` - Rive Animationen
- `shimmer: ^3.0.0` - Shimmer Effekte

#### **Navigation & State**
- `get: ^4.6.6` - State Management & Navigation
- `provider: ^6.1.2` - State Management

#### **UI Komponenten**
- `flutter_slidable: ^3.1.1` - Swipe Actions
- `carousel_slider: ^5.0.0` - Image Carousels
- `flutter_staggered_grid_view: ^0.7.0` - Staggered Grids

#### **Medien & Bilder**
- `cached_network_image: ^3.4.1` - Optimierte Bild-Caching
- `image_picker: ^1.1.2` - Bild-Upload
- `photo_view: ^0.15.0` - Zoom-fähige Bildanzeige

#### **Formulare**
- `flutter_form_builder: ^9.4.1` - Erweiterte Formulare
- `form_builder_validators: ^11.0.0` - Formular-Validierung

#### **Standort & Karten**
- `geolocator: ^13.0.1` - GPS Funktionalität
- `geocoding: ^3.0.0` - Adress-Geocoding

#### **Utilities**
- `intl: ^0.19.0` - Internationalisierung
- `timeago: ^3.7.0` - Relative Zeitangaben
- `uuid: ^4.5.1` - Eindeutige IDs
- `shared_preferences: ^2.3.2` - Lokale Datenspeicherung
- `dio: ^5.7.0` - HTTP Client

### 🏗️ **Architektur**

```
lib/
├── main.dart                    # App Entry Point
├── theme/
│   └── app_theme.dart          # Theme Konfiguration
├── screens/
│   ├── main_screen.dart        # Haupt-Navigation
│   ├── home_screen.dart        # Home Screen
│   ├── search_screen.dart      # Suche
│   ├── add_listing_screen.dart # Anzeige erstellen
│   ├── favorites_screen.dart   # Favoriten
│   └── profile_screen.dart     # Profil
└── widgets/
    ├── animated_splash_screen.dart    # Splash Screen
    ├── custom_bottom_nav.dart         # Navigation
    └── listing_detail_modal.dart      # Detail Modal
```

### 🎨 **Design System**

#### **Farben**
- **Primary**: Indigo (#6366F1)
- **Secondary**: Purple (#8B5CF6)
- **Accent**: Cyan (#06B6D4)
- **Success**: Green (#10B981)
- **Warning**: Amber (#F59E0B)
- **Error**: Red (#EF4444)

#### **Typografie**
- **Font Family**: Inter (Google Fonts)
- **Responsive Größen**: 10px - 32px
- **Font Weights**: 400, 500, 600, 700, 800

#### **Spacing**
- **Base Unit**: 4px
- **Standard Padding**: 16px
- **Card Margins**: 8px
- **Border Radius**: 12px - 20px

## 🚀 **Installation & Setup**

### **Voraussetzungen**
- Flutter SDK 3.24.5+
- Dart 3.5.4+
- Linux/macOS/Windows Development Environment

### **Installation**
```bash
# Repository klonen
git clone <repository-url>
cd kleinanzeigen_app

# Dependencies installieren
flutter pub get

# App für Linux kompilieren
flutter build linux --release

# App für Android kompilieren (Android SDK erforderlich)
flutter build apk --release

# App für iOS kompilieren (macOS + Xcode erforderlich)
flutter build ios --release
```

### **Entwicklung**
```bash
# Development Server starten
flutter run

# Hot Reload aktiviert
# Änderungen werden automatisch übernommen
```

## 📱 **Screenshots**

### **Splash Screen**
- Animiertes Logo mit Partikeln
- Gradient Background
- Loading Animation

### **Home Screen**
- Kategorien-Chips
- Empfohlene Anzeigen Carousel
- Anzeigen-Liste mit Bildern
- Suchleiste mit Standort

### **Search Screen**
- Filter-Chips
- Preisbereich-Slider
- Sortier-Optionen
- Ergebnis-Liste

### **Add Listing Screen**
- 5-Schritt Wizard
- Kategorie-Auswahl
- Multi-Image Upload
- Standort-Integration
- Live-Vorschau

### **Favorites Screen**
- Favoriten-Liste
- Swipe Actions
- Status-Anzeigen
- Sortier-Optionen

### **Profile Screen**
- Benutzer-Dashboard
- Statistiken
- Einstellungen
- Theme-Toggle

## 🔮 **Zukünftige Features**

### **Phase 2**
- [ ] **Chat System** mit Echtzeit-Nachrichten
- [ ] **Push Notifications** für neue Nachrichten
- [ ] **Karten Integration** mit Standort-Pins
- [ ] **Bewertungssystem** für Verkäufer

### **Phase 3**
- [ ] **In-App Zahlungen** mit Stripe/PayPal
- [ ] **Premium Anzeigen** mit Hervorhebung
- [ ] **Statistik Dashboard** für Verkäufer
- [ ] **Moderation Tools** für Spam-Schutz

### **Phase 4**
- [ ] **Internationalisierung** (i18n)
- [ ] **Offline Support** mit lokaler Datenbank
- [ ] **AR Produktansicht** für bessere Darstellung
- [ ] **Machine Learning** für Preis-Empfehlungen

## 🤝 **Beitragen**

1. Fork das Repository
2. Erstelle einen Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Committe deine Änderungen (`git commit -m 'Add some AmazingFeature'`)
4. Push zum Branch (`git push origin feature/AmazingFeature`)
5. Öffne einen Pull Request

## 📄 **Lizenz**

Dieses Projekt steht unter der MIT Lizenz - siehe [LICENSE](LICENSE) Datei für Details.

## 👨‍💻 **Entwickler**

Erstellt mit ❤️ und den besten Flutter UI Paketen für eine moderne Kleinanzeigen-Erfahrung.

---

**Hinweis**: Diese App ist ein Showcase für moderne Flutter UI-Entwicklung und verwendet die neuesten Pakete und Design-Prinzipien für eine erstklassige Benutzererfahrung.

