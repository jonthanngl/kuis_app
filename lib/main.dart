import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/quiz_provider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => QuizProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        return MaterialApp(
          title: 'Quiz App UTS',
          debugShowCheckedModeBanner: false,
          themeMode: quizProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

          // TEMA TERANG
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            primaryColor: Colors.blue,
            scaffoldBackgroundColor: Colors.grey.shade50,
            textTheme: GoogleFonts.poppinsTextTheme(),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: GoogleFonts.poppins(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            cardTheme: CardThemeData(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),

          // TEMA GELAP (DIPERBARUI)
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.blueAccent, // Warna utama lebih cerah untuk dark mode
            scaffoldBackgroundColor: const Color(0xFF121212), // Standar Material Dark
            colorScheme: const ColorScheme.dark(
              primary: Colors.blueAccent,
              surface: Color(0xFF1E1E1E), // Warna elemen melayang (Card, Dialog)
            ),
            textTheme: GoogleFonts.poppinsTextTheme(
              ThemeData(brightness: Brightness.dark).textTheme,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: const Color(0xFF121212),
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            cardTheme: CardThemeData(
              color: Color(0xFF1E1E1E),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF1E1E1E),
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.white54,
            ),
          ),
          home: const LoginScreen(),
        );
      },
    );
  }
}