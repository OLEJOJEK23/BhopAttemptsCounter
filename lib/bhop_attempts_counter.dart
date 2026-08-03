import 'package:flutter/material.dart';
import 'package:tryes_counter/core/theme/theme_manager.dart';

import 'features/home.dart';

class BhopAttemptsCounter extends StatelessWidget {
  const BhopAttemptsCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager.instance,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'Bhop Attempts Counter',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.grey[100],
            cardColor: Colors.white,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color(0xFF121212),
            cardColor: const Color(0xFF1E1E1E),
          ),
          themeMode: themeMode,
          home: const MyHomePage(title: 'Bhop Attempts Counter'),
        );
      },
    );
  }
}
