# Ava Light

A Flutter-based credit monitoring and financial dashboard application built as an interview project to demonstrate my Flutter development skills.

## 📋 Project Context

This project was developed as part of a Flutter interview assignment, implementing a credit monitoring interface based on the provided Figma design:

**Design Reference**: [Figma Design](https://www.figma.com/design/fgAwUqgFK30hJqYo0byDeG/Untitled?node-id=0-1)

## ✨ Features

- **Credit Score Tracking**: Display credit scores from major agencies (Experian, Equifax, TransUnion) with visual ratings and score difference tracking
- **Credit Account Management**: View credit card accounts with balances, limits, and utilization percentages
- **Credit Factors Analysis**: Show factors affecting credit score with impact levels (High, Medium, Low)
- **Credit Utilization Monitoring**: Track credit usage across accounts with visual charts
- **Employment Information Management**: Manage employment details, income information, and pay frequency
- **Responsive UI**: Clean, modern interface following Material Design principles with custom theming

## 🛠 Technical Stack

- **Flutter**: 3.36.0 (beta channel)
- **Dart**: 3.10.0
- **State Management**: Riverpod with code generation
- **UI Framework**: Material Design with custom theming
- **Charts**: FL Chart for data visualization
- **Currency Handling**: Money2 library for financial calculations (USD)
- **Architecture**: Clean architecture with separate models, providers, and widgets

### Key Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.5.1 # State management
  riverpod_annotation: ^2.3.5 # Code generation annotations
  fl_chart: ^0.68.0 # Chart widgets
  money2: ^5.0.1 # Currency handling
  google_fonts: ^6.2.1 # Custom fonts
  auto_size_text: ^3.0.0 # Responsive text
  intl: ^0.19.0 # Internationalization

dev_dependencies:
  riverpod_generator: ^2.4.0 # Code generation
  build_runner: ^2.4.11 # Build system
  riverpod_lint: ^2.3.10 # Riverpod-specific linting
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.4.3 or higher
- Dart SDK 3.10.0 or higher
- An IDE with Flutter support (VS Code, Android Studio, IntelliJ)

### Installation

1. **Install dependencies**:

   ```bash
   flutter pub get
   ```

1. **Generate code** (for Riverpod providers):

   ```bash
   dart run build_runner build
   ```

### Running the Application

**Development mode**:

```bash
flutter run
```

**Platform-specific runs**:

```bash
# Android
flutter run -d android

# iOS (macOS only)
flutter run -d ios

# Web
flutter run -d web-server --web-hostname localhost --web-port 8080

# macOS (macOS only)
flutter run -d macos

# Windows (Windows only)
flutter run -d windows

# Linux (Linux only)
flutter run -d linux
```

## 📁 Project Structure

```code
lib/
├── main.dart                          # App entry point
├── home.dart                          # Main home screen
├── core/                              # Shared utilities and components
│   ├── app_config.dart                # Global app configuration
│   ├── theme/                         # Theme and styling
│   │   └── colors.dart                # Custom color palette
│   ├── ui/                            # Reusable UI components
│   │   ├── pill_widget.dart           # Pill-shaped widgets
│   │   ├── spaced_column.dart         # Column with spacing
│   │   └── spaced_row.dart            # Row with spacing
│   ├── widgets/                       # Common widgets
│   │   ├── card_widget.dart           # Custom card components
│   │   └── circular_progress_widget.dart # Progress indicators
│   └── extensions/                    # Dart extensions
│       ├── iterable_extensions.dart   # Iterable utilities
│       └── list_extensions.dart       # List utilities
├── credit_score/                      # Credit score functionality
│   ├── models/                        # Credit score data models
│   ├── providers/                     # Riverpod state providers
│   └── widgets/                       # Credit score UI components
├── accounts/                          # Account management
│   ├── models/                        # Account data models
│   ├── providers/                     # Account state providers
│   └── widgets/                       # Account UI components
├── credit_factors/                    # Credit factors analysis
│   ├── models/                        # Credit factor data models
│   ├── providers/                     # Credit factor state providers
│   └── widgets/                       # Credit factor UI components
├── utilization/                       # Credit utilization tracking
│   └── credit_utilization_home_widget.dart
└── user_info/                         # User employment information
    ├── models/                        # Employment data models
    └── widgets/                       # Employment UI components
```

### Generated Files

The project uses code generation for Riverpod providers. Generated files (`.g.dart`) are created automatically when running:

```bash
dart run build_runner build
```

## 🏗 Architecture

The application follows a clean architecture pattern with:

- **Models**: Immutable data classes representing business entities
- **Providers**: Riverpod providers for state management and business logic
- **Widgets**: UI components that consume state from providers
- **Code Generation**: Automatic generation of provider boilerplate code

### State Management

Uses **Riverpod** for reactive state management:

- `@riverpod` annotations for provider generation
- Immutable state with proper equality
- Automatic dependency tracking and rebuilding

## 🎨 UI/UX Implementation

The interface closely follows the provided Figma design with:

- Custom color scheme defined in `core/theme/colors.dart`
- Material Design components with custom styling
- Responsive layout using `auto_size_text` and flexible widgets
- Interactive charts using FL Chart library
- Clean card-based layout with proper spacing and hierarchy

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux
