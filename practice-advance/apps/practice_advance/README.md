# Practice Advance - E-commerce App

## Description

**Practice Advance** is an e-commerce application built using Flutter. The app allows users to browse products, view detailed product information, and manage their cart. The project is structured as a monorepo using **Melos** with multiple shared packages. The app also supports caching and offline functionality using **Isar** for local storage, and **BLoC** is used for state management.

## Table of Contents

- [Description](#description)
- [Project Structure](#project-structure)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Running Tests](#running-tests)
- [Tech Stack](#tech-stack)
- [Dependencies](#dependencies)
- [Development Workflow](#development-workflow)
- [Contributing](#contributing)
- [License](#license)

## Project Structure
```bash
practice-advance/
│
├── apps/
│   ├── practice_advance/            # Main app code for the e-commerce app
│   ├── practice_advance_design/     # Design or UI-specific code
│
├── packages/                        # Shared packages across the monorepo
│   ├── api_client/                  # 
│
├── melos.yaml                       # Melos configuration for managing monorepo
├── pubspec.yaml                     # Main app dependencies
├── pubspec.lock                     # Lock file for dependencies
├── .env                             # Environment variables for the project
├── README.md  

```

# Project Features

## State Management
The project uses the BLoC (Business Logic Component) pattern for state management. This ensures a clear separation between business logic and UI code. BLoC is integrated with the `flutter_bloc` package to manage and emit states efficiently across different parts of the application.

## Local Database with Isar
Isar is a high-performance local database used to store offline data like products and user details. It allows the app to work seamlessly even when offline by caching important data locally.

## Caching with fl_query
The project uses `fl_query` for managing caching and network state. This library is used for API response caching, which improves the app's performance by reducing unnecessary network calls.

## API Management with Dio
The `Dio` package is used for handling network requests. It is a powerful HTTP client that provides support for interceptors, global configuration, and easy API calls.

## Dependency Injection
`GetIt` is used for dependency injection throughout the app, ensuring that services like repositories, network clients, and database instances are efficiently managed and injected where needed.

## Routing
The app uses `go_router` for declarative routing, enabling easy navigation between different screens.

## Responsive UI
The project employs `flutter_screenutil` to make the UI responsive across various screen sizes. It ensures that the app looks good on all devices.

## Internationalization (i18n)
The `intl` package is used for internationalization, ensuring that the app can support multiple languages and regional formats for date, currency, and other data types.

# Project Dependencies
Clone the Repository
```bash
git clone <git@gitlab.asoft-python.com:duy.hoang/dart-training.git>
```

Install Flutter Dependencies
```bash
flutter pub get
```

Install Melos
```bash
dart pub global activate melos
```

```bash
melos bootstrap
```

Running the application
```bash
melos run run_app
```

Environment Setup
```bash
API_URL=https://your-api-url.com
API_KEY=your-api-key
```

Running Tests
```bash
flutter test
```

# Project Dependencies

Below are the core dependencies used in the project:

## BLoC & State Management:
- **flutter_bloc**: State management using the BLoC pattern.
- **bloc_concurrency**: To manage concurrent events in BLoC.

## Network & API:
- **dio**: HTTP client for API calls.
- **fl_query**: Used for caching and managing network requests.
- **connectivity_plus**: To check network connectivity status.

## Local Storage:
- **isar**: NoSQL database for storing local data.
- **isar_flutter_libs**: Isar-specific libraries for Flutter integration.
- **flutter_secure_storage**: Secure storage for sensitive information (e.g., tokens).

## Dependency Injection:
- **get_it**: Service locator for managing dependencies.

## Routing:
- **go_router**: A declarative routing library for easy navigation.

## UI & Design:
- **flutter_screenutil**: Utility for responsive UI design.
- **flutter_svg**: For rendering SVG images.
- **cached_network_image**: Efficient image caching for better performance.

## Utilities:
- **talker**: Advanced logging and debugging tool.
- **intl**: For internationalization and formatting.

# Development Workflow

**Add New Packages**: To add new packages to any of the apps or packages, update the corresponding pubspec.yaml files and run:
```bash
melos bootstrap
```

**Code Generation**: Some parts of the project rely on generated code (e.g., Isar models). After making changes to the models or database setup, run:
```bash
flutter pub run build_runner build
```

