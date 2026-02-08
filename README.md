# Multifaith Calendar 🌍📅

A comprehensive, multi-layered calendar application built with Flutter, designed to bridge different faiths and cultures through a unified timekeeping experience.

## Overview
The **Multifaith Calendar** is more than just a date tracker. It's a powerful tool for observing and understanding various religious and cultural calendars simultaneously. Whether you're tracking Hebrew holidays, Islamic prayer times, or Christian festivals, this app provides a clean, unified interface for all.

## Core Features
- **🌍 Multi-Calendar Support:** Seamlessly view and switch between Hebrew, Islamic, and Gregorian calendars.
- **🛡️ Custom Layers:** Toggle different visibility layers for holidays, national events, and personal reminders.
- **🕋 Precision Prayer Times:** High-accuracy calculation methods for Jewish (Halachic) and Islamic (Salah) times based on geo-location.
- **👤 Profile Management:** Create multiple profiles for different locations or family members.
- **📱 Modern & Fluid UI:** Built with Flutter and enhanced with smooth animations and material design.

## Technical Architecture
- **State Management:** [Riverpod](https://riverpod.dev/) for robust and testable state handling.
- **Navigation:** [GoRouter](https://pub.dev/packages/go_router) for declarative routing.
- **Database:** [Drift](https://drift.simonbinder.eu/) (SQLite) for high-performance, reactive local storage.
- **Theming:** Custom theme system with light/dark mode support.
- **Algorithms:** Integration with `kosher_dart` and `hijri` for precise astronomical calculations.

## Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Dart SDK
- Android Studio / VS Code / Xcode

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/ronibarzel91-bit/multifaith_calendar.git
   ```
2. Navigate to the project directory:
   ```bash
   cd multifaith_calendar
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Generate database code:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
5. Run the app:
   ```bash
   flutter run
   ```

## Project Structure
- `lib/app/`: Core app configuration, routing, and theme.
- `lib/domain/`: Business logic, domain models, and service interfaces.
- `lib/data/`: Data persistence (Drift) and repository implementations.
- `lib/features/`: Feature-sliced UI components and controllers.
- `lib/shared/`: Reusable widgets and utilities.

---
*Built with ❤️ for a more connected world.*
