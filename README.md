
# Drills App

This app provides a set of swimming drills categorized into two modules: Grundlagentests and Schwimmtests. Each module consists of various levels, each having its own drills with descriptions and videos.

## Technical Specifications

### Framework:
- Flutter

### Languages:
- Dart

### Dependencies:
- `video_player`: For embedding and playing videos associated with each drill.

### App Structure:
- **Home Screen**: Contains a `BottomNavigationBar` to navigate between Grundlagentests and Schwimmtests.
- **Levels Screen**: Depending on the screen size, it displays the levels in either a grid (for larger screens like iPads) or a list (for smaller screens like smartphones). The levels include:
  - Grundlagentests: Krebs, Seepferd, Frosch, Pinguin, Tintenfisch, Krokodil, Eisbär
  - Schwimmtests: Wal, Hecht, Hai, Delfin, Tech 5, Tech 6, Tech 7, Tech 8
- **Drill Details Screen** (Not yet implemented): This screen will display the drill's description and an embedded video player to play the associated video.

### Responsiveness:
The app is designed to be responsive and works well on both iPad-sized screens and smartphone screens. It uses `MediaQuery` to adjust the layout according to the screen size.

## Setup:

1. Clone or download the project.
2. Navigate to the project directory and run `flutter pub get` to fetch the necessary dependencies.
3. Run the app using `flutter run`.

## Future Enhancements:
- Implement the Drill Details screen with video player functionality.
- Add state management for better data handling.
- Store the drills and levels in a database or backend server for dynamic content management.

---

**Note**: This is a basic structure of the app. Depending on requirements, it can be expanded and modified further.
# swimsports_app
