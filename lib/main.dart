import 'package:flutter/material.dart';
import 'package:inotal_hub/screen/Dashboard.dart';
import 'package:inotal_hub/screen/Dashboard2.dart';
import 'package:inotal_hub/screen/main_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // ===== GANTI SCREEN DI SINI =====
  static const Widget firstScreen = MainNavigation();

  // contoh:
  // static const Widget firstScreen = RegisterScreen();
  // static const Widget firstScreen = AdminHomeScreen();
  // static const Widget firstScreen = NavScreen(
  //   role: "admin",
  //   name: "Alya",
  //   userId: 1,
  // );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'INOTALHub',

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orangeAccent,
        ),

        scaffoldBackgroundColor: Colors.white,

        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(
            color: Colors.orangeAccent,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orangeAccent,
            ),
          ),
        ),

        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.orangeAccent,
          selectionColor: Colors.orangeAccent,
          selectionHandleColor: Colors.orangeAccent,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            foregroundColor: Colors.white,
          ),
        ),
      ),

      home: firstScreen,
    );
  }
}