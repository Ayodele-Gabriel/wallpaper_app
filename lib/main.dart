import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_studio/utilities/constants/app_theme.dart';
import 'package:wallpaper_studio/utilities/routing/route_paths.dart';
import 'package:wallpaper_studio/utilities/routing/routing.dart';
import 'package:window_size/window_size.dart' as window_size;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    const windowWidth = 800.0;
    const windowHeight = 800.0;

    // Get screen info
    final screen = await window_size.getScreenList();
    if (screen.isNotEmpty) {
      final screenFrame = screen.first.visibleFrame;

      // Calculate centered position
      final left = screenFrame.left +
          (screenFrame.width - windowWidth) / 2;
      final top = screenFrame.top +
          (screenFrame.height - windowHeight) / 2;

      // Set window size and position
      window_size.setWindowFrame(
        Rect.fromLTWH(left, top, windowWidth, windowHeight),
      );
    }

    // Optional: prevent resizing smaller than default
    window_size.setWindowMinSize(const Size(windowWidth, windowHeight));
  }

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: RoutePaths.dashboard,
      onGenerateRoute: Routing.generateRoute,
    );
  }
}