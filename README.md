# Swimsports.ch App

Swimsports.ch App is a mobile application designed for both Android and iOS devices. It provides comprehensive training modules across various swimming levels, complete with video tutorials and descriptive guides.
## Features

- **Swimming Levels**: Detailed breakdown of different swimming levels with objectives and progress tracking.
- **Video Tutorials**: High-quality video demonstrations for each swimming technique.
- **Multi-language Support**: Localization for multiple languages to cater to a global audience.

## Installation

### Prerequisites

Before you begin, ensure you have the following installed:
- Flutter
- Dart
- Visual Studio Code
- Flutter and Dart plugins for VSCode
- Git

### Environment Setup

1. **Flutter & Dart**:
   - Download and install Flutter from the [official Flutter website](https://flutter.dev).
   - Ensure Dart is installed (it comes with Flutter).

2. **Visual Studio Code**:
   - Install Visual Studio Code (VSCode) from [here](https://code.visualstudio.com/).
   - Add the Flutter and Dart plugins via the Extensions panel within VSCode.

3. **Git**:
   - Install Git from [git-scm.com](https://git-scm.com/).

### Building the App

1. **Clone the repository**:
   ```sh
   git clone https://github.com/your-username/swimsports_app.git
   cd swimsports_app
   ```

2. **Run the app**:
   - For **Android**:
     - Open the project in Android Studio and run the build process.
   - For **iOS**:
     - Open `ios/Runner.xcworkspace` in Xcode.
     - Select a target device or simulator.
     - Run the build (`Cmd + R`).

### Test run

- Run automated tests by executing:
  ```sh
  flutter run
  ```

- To fix possible typos in the `.json` files, manually review the files or use JSON validators such as [JSONLint](https://jsonlint.com/).

## Deployment

### Google Play Store

- Build an app bundle by running:
  ```sh
  flutter build appbundle
  ```
- Follow the instructions on the Google Play Console to create a new app and upload the build.

### Apple App Store

- Archive your app from Xcode.
- Use the Application Loader to upload the build to App Store Connect.
- Follow the steps in App Store Connect to submit your app for review.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.

---

Swim Sports CH aims to be the go-to app for swimming coach of all levels. Dive into the experience and make a splash in your swimming journey!

For more information or support, please contact [admin@swimsports.ch](mailto:admin@swimsports.ch).
