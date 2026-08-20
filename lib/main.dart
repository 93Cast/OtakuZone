import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const AnimeApp());
}

class AnimeApp extends StatefulWidget {
  const AnimeApp({super.key});

  @override
  State<AnimeApp> createState() =>
      _AnimeAppState();
}

class _AnimeAppState extends State<AnimeApp> {
  // =====================================================
  // ESTADO DEL TEMA
  // =====================================================

  bool isDarkMode = false;

  // =====================================================
  // CARGAR PREFERENCIA
  // =====================================================

  @override
  void initState() {
    super.initState();

    loadTheme();
  }

  Future<void> loadTheme() async {
    final preferences =
        await SharedPreferences.getInstance();

    final savedTheme =
        preferences.getBool('isDarkMode');

    if (!mounted) {
      return;
    }

    setState(() {
      isDarkMode = savedTheme ?? false;
    });
  }

  // =====================================================
  // CAMBIAR TEMA
  // =====================================================

  Future<void> toggleTheme() async {
    final preferences =
        await SharedPreferences.getInstance();

    setState(() {
      isDarkMode = !isDarkMode;
    });

    await preferences.setBool(
      'isDarkMode',
      isDarkMode,
    );
  }

  // =====================================================
  // INTERFAZ
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Anime App',

      // =================================================
      // LIGHT MODE
      // =================================================

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),

      // =================================================
      // DARK MODE
      // =================================================

      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

      // =================================================
      // TEMA ACTUAL
      // =================================================

      themeMode: isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,

      // =================================================
      // PANTALLA PRINCIPAL
      // =================================================

      home: HomeScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: toggleTheme,
      ),
    );
  }
}
