// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale = const Locale('de', 'DE');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swim Sports CH',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SwimmingLevelsPage(),
      locale: _locale,
      localizationsDelegates: [
        AppLocalizationsDelegate(overriddenLocale: _locale),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('de', 'DE'),
        const Locale('fr', 'FR'),
        const Locale('it', 'IT'),
        const Locale('en', 'US'),
      ],
    );
  }
}

class SwimmingLevelsPage extends StatefulWidget {
  const SwimmingLevelsPage({super.key});

  @override
  _SwimmingLevelsPageState createState() => _SwimmingLevelsPageState();
}

class _SwimmingLevelsPageState extends State<SwimmingLevelsPage> {
  List<dynamic> levels = [];
  String appTitle = ""; // Initialize with an empty string

  @override
  void initState() {
    super.initState();
    _loadSwimmingDataBasedOnLocale(const Locale('de', 'DE'));
  }

  @override
  Widget build(BuildContext context) {
    if (levels.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          actions: _buildLanguageDropdown(),
        ),
        body: const Center(
            child: CircularProgressIndicator()), // Loading indicator
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle), // Use the app title from JSON
        actions: _buildLanguageDropdown(),
      ),
      body: ListView.builder(
        itemCount: levels.length,
        itemBuilder: (context, index) {
          String iconAssetPath =
              levels[index]['icon']; // Get the icon path from the JSON
          return ListTile(
            leading: Image.asset(iconAssetPath,
                width: 40, fit: BoxFit.cover), // Display the icon
            title: Text(levels[index]['level']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LevelSwipeScreen(
                    initialPageIndex: index,
                    levels: levels,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<Widget> _buildLanguageDropdown() {
    return [
      DropdownButtonHideUnderline(
        child: DropdownButton<Locale>(
          icon: const Icon(Icons.language, color: Colors.white),
          onChanged: (Locale? locale) {
            if (locale != null) {
              MyApp.setLocale(context, locale);
              _loadSwimmingDataBasedOnLocale(locale);
            }
          },
          items: [
            DropdownMenuItem(
              child: Text('Deutsch'),
              value: Locale('de', 'DE'),
            ),
            DropdownMenuItem(
              child: Text('Français'),
              value: Locale('fr', 'FR'),
            ),
            DropdownMenuItem(
              child: Text('Italiano'),
              value: Locale('it', 'IT'),
            ),
            DropdownMenuItem(
              child: Text('English'),
              value: Locale('en', 'US'),
            ),
          ],
        ),
      ),
    ];
  }

  _loadSwimmingDataBasedOnLocale(Locale locale) async {
    // Load the JSON from the assets based on the selected locale
    String jsonString =
        await rootBundle.loadString('swimsports_${locale.languageCode}.json');
    final jsonData = jsonDecode(jsonString);

    setState(() {
      levels = jsonData['levels'];
      appTitle = jsonData['app_title'];
    });
  }
}

class LevelSwipeScreen extends StatefulWidget {
  final int initialPageIndex;
  final List<dynamic> levels;

  const LevelSwipeScreen(
      {super.key, required this.initialPageIndex, required this.levels});

  @override
  _LevelSwipeScreenState createState() => _LevelSwipeScreenState();
}

class _LevelSwipeScreenState extends State<LevelSwipeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.levels.length,
      itemBuilder: (context, index) {
        return LevelDetailPage(
          drills: widget.levels[index]['drills'],
          levelName: widget.levels[index]['level'],
          iconAssetPath: widget.levels[index]['icon'],
          levelDescription: widget.levels[index]['level_description'],
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class LevelDetailPage extends StatelessWidget {
  final List<dynamic> drills;
  final String levelName;
  final String? ageGroup; // Changed type to String? since it's optional
  final String levelDescription;
  final String iconAssetPath;

  const LevelDetailPage({
    Key? key,
    required this.drills,
    required this.levelName,
    this.ageGroup, // It's now an optional parameter
    required this.levelDescription,
    required this.iconAssetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(levelName)),
      body: ListView(
        children: [
          // Header section for icon, levelName, ageGroup, and levelDescription
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(iconAssetPath,
                    width: 64.0,
                    height: 64.0), // Using Image.asset to display the icon
                const SizedBox(height: 16.0),
                Text(levelName,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                // Conditionally display Age Group if ageGroup is not null
                if (ageGroup != null) ...[
                  SizedBox(height: 8.0),
                  Text('Age Group: $ageGroup'),
                ],
                SizedBox(height: 8.0),
                Text(levelDescription),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          Divider(),
          // List of drills
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: drills.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(drills[index]['drill_name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoSwipeScreen(
                        drills: drills,
                        initialPage: index,
                        levelName: levelName,
                        iconAssetPath: iconAssetPath, // pass the iconAssetPath
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class VideoSwipeScreen extends StatefulWidget {
  final List<dynamic> drills;
  final int initialPage;

  final String levelName;
  final String iconAssetPath;

  VideoSwipeScreen({
    required this.drills,
    required this.levelName,
    required this.iconAssetPath,
    this.initialPage = 0,
  });

  @override
  _VideoSwipeScreenState createState() => _VideoSwipeScreenState();
}

class _VideoSwipeScreenState extends State<VideoSwipeScreen> {
  late PageController _pageController;
  // ignore: unused_field
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage; // <-- Add this line
    _pageController = PageController(initialPage: widget.initialPage)
      ..addListener(() {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.levelName)),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.drills.length,
        itemBuilder: (context, index) {
          return VideoDrillPage(
            videoAsset: widget.drills[index]['videoAsset'],
            drill_name: widget.drills[index]['drill_name'],
            category: widget.drills[index]['category'],
            water_depth: widget.drills[index]['water_depth'],
            distance: widget.drills[index]['distance'],
            description: widget.drills[index]['description'],
            focus: widget.drills[index]['focus'],
            compulsory: widget.drills[index]['compulsory'],
            iconAssetPath: widget.iconAssetPath,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class VideoDrillPage extends StatefulWidget {
  final String videoAsset;
  final String drill_name;
  final String category;
  final String? water_depth; // Make this nullable
  final String? distance; // Make this nullable
  final String? compulsory; // Make this nullable
  final String description;
  final String? focus; // Make this nullable
  final String iconAssetPath;

  const VideoDrillPage({
    required this.videoAsset,
    required this.drill_name,
    required this.category,
    this.water_depth, //Optional
    this.distance, //Optional
    this.compulsory, //Optional
    required this.description,
    this.focus, //Optional
    required this.iconAssetPath,
  });

  @override
  _VideoDrillPageState createState() => _VideoDrillPageState();
}

class _VideoDrillPageState extends State<VideoDrillPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.asset(widget.videoAsset);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      aspectRatio: 16 / 9,
      // Add other configurations if needed
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Chewie(
              controller: _chewieController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(widget.iconAssetPath,
                        width: 32.0, height: 32.0, fit: BoxFit.cover),
                    SizedBox(width: 8.0),
                    Text('${widget.drill_name}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(
                    '${AppLocalizations.of(context).translate('category')}: ${widget.category}',
                    style: const TextStyle(fontSize: 16)),
                if (widget.water_depth != null)
                  Text(
                      '${AppLocalizations.of(context).translate('water_depth')}: ${widget.water_depth}',
                      style: const TextStyle(fontSize: 16)),
                if (widget.distance != null)
                  Text(
                      '${AppLocalizations.of(context).translate('distance')}: ${widget.distance}',
                      style: const TextStyle(fontSize: 16)),
                Text(
                    '${AppLocalizations.of(context).translate('description')}:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(widget.description, style: const TextStyle(fontSize: 16)),
                if (widget.focus != null)
                  Text(
                      '${AppLocalizations.of(context).translate('focus')}: ${widget.focus}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                if (widget.compulsory != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${AppLocalizations.of(context).translate('compulsory')}:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.compulsory}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
