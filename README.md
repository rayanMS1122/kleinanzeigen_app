# 🏪 Kleinanzeigen Flutter App

#### 🏠 **Home Screen**
- Dynamische Kategorien mit Icons
- Empfohlene/Beworbene Anzeigen Carousel
- Infinite Scroll mit Lazy Loading
- Pull-to-Refresh Funktionalität
- Suchleiste mit Standort-Integration

![Home Screen](assets/screenshots/home_screen.png)

#### 🔍 **Erweiterte Suche**
- Filterbare Kategorien
- Preisbereich-Slider (RangeSlider)
- Entfernungsfilter mit GPS
- Sortieroptionen (Preis, Datum, Entfernung)
- Echtzeit-Suchergebnisse

![Search Screen](assets/screenshots/search_screen.png)

#### ➕ **Anzeige Erstellen**
- **5-Schritt Wizard** mit Fortschrittsanzeige
- Kategorie-Auswahl mit Icons
- Multi-Image Upload (bis zu 10 Bilder)
- Formular-Validierung mit flutter_form_builder
- GPS-Standort Integration
- Live-Vorschau der Anzeige

![Add Screen](assets/screenshots/add_screen.png)
![Details](assets/screenshots/add_screen_details.png)
![Adresse hinzufügen](assets/screenshots/add_screen_adding_address.png)
![Bilder hinzufügen](assets/screenshots/add_screen_adding_image.png)
![Vorschau](assets/screenshots/add_screen_see_all_things.png)

#### ❤️ **Favoriten**
- Persistente Favoriten-Speicherung
- Sortier- und Filteroptionen
- Swipe-to-Delete mit Undo-Funktion
- Verkauft/Verfügbar Status-Anzeige

![Favoriten Screen](assets/screenshots/fav_screen.png)

#### 👤 **Profil & Einstellungen**
- Benutzer-Dashboard mit Statistiken
- Dark/Light Mode Toggle
- Benachrichtigungs-Einstellungen
- Standort-Präferenzen
- Sicherheits-Einstellungen

![Profil Screen](assets/screenshots/profile_screen.png)

### 🎭 **UI Komponenten**

#### 🌟 **Splash Screen**
- Animiertes Logo mit Rotation und Skalierung
- Floating Particles Animation
- Gradient Background
- Smooth Transition zur Haupt-App

![Splash Screen](assets/screenshots/splash_screen.png)

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
<!-- Pakete wurden in deiner Version bereits sauber aufgelistet – keine Änderungen notwendig -->

### 🏗️ **Architektur**

```plaintext
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
