import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  int _currentIndex = 0;
  int _score = 0;
  bool _isDarkMode = false;

  final List<Map<String, String>> _history = [
    {'title': 'Pemrograman Mobile', 'score': '100/100', 'date': '22 Okt 2026'},
    {'title': 'Basis Data', 'score': '80/100', 'date': '20 Okt 2026'},
    {'title': 'Algoritma', 'score': '90/100', 'date': '18 Okt 2026'},
  ];

  final List<Question> _questions = [
    Question(questionText: 'Apa framework dari Google untuk membuat UI multi-platform?', options: ['React Native', 'Flutter', 'Kotlin', 'Swift'], correctAnswerIndex: 1),
    Question(questionText: 'Bahasa pemrograman utama yang digunakan dalam Flutter adalah?', options: ['Java', 'Dart', 'C++', 'Python'], correctAnswerIndex: 1),
    Question(questionText: 'Manakah widget yang state-nya tidak dapat diubah setelah dibuat?', options: ['StatefulWidget', 'StatelessWidget', 'InheritedWidget', 'Container'], correctAnswerIndex: 1),
    Question(questionText: 'Fungsi utama dari metode setState() adalah?', options: ['Menghapus data', 'Memicu build ulang UI', 'Berpindah halaman', 'Menyimpan ke database'], correctAnswerIndex: 1),
    Question(questionText: 'Widget apa yang digunakan untuk membuat daftar yang bisa di-scroll?', options: ['Column', 'Row', 'ListView', 'Stack'], correctAnswerIndex: 2),
    Question(questionText: 'Apa perintah terminal untuk mengecek isu pada instalasi Flutter?', options: ['flutter run', 'flutter build', 'flutter doctor', 'flutter clean'], correctAnswerIndex: 2),
    Question(questionText: 'Manakah yang BUKAN merupakan jenis State Management?', options: ['Provider', 'Bloc', 'Redux', 'MySQL'], correctAnswerIndex: 3),
    Question(questionText: 'Widget apa yang mengatur tata letak anak-anaknya secara horizontal?', options: ['Column', 'Row', 'ListView', 'Grid'], correctAnswerIndex: 1),
    Question(questionText: 'File konfigurasi utama pada proyek Flutter adalah?', options: ['pubspec.yaml', 'build.gradle', 'AndroidManifest.xml', 'main.dart'], correctAnswerIndex: 0),
    Question(questionText: 'Untuk membuat navigasi antar halaman di Flutter, kita menggunakan?', options: ['Router', 'Navigator', 'Link', 'Intent'], correctAnswerIndex: 1),
  ];

  String get userName => _userName;
  int get currentIndex => _currentIndex;
  int get score => _score;
  bool get isDarkMode => _isDarkMode;
  List<Question> get questions => _questions;
  List<Map<String, String>> get history => _history;
  bool get isFinished => _currentIndex >= _questions.length;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == _questions[_currentIndex].correctAnswerIndex) {
      _score += 10;
    }
    _currentIndex++;

    if (_currentIndex == _questions.length) {
      _saveCurrentQuizToHistory();
    }

    notifyListeners();
  }

  void _saveCurrentQuizToHistory() {
    final maxScore = _questions.length * 10;
    final now = DateTime.now();
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Ags', 'Sep', 'Okt', 'Nov', 'Des'];
    final dateStr = '${now.day} ${months[now.month - 1]} ${now.year}';

    _history.insert(0, {
      'title': 'Kuis Flutter & Pemrograman Mobile',
      'score': '$_score/$maxScore',
      'date': dateStr,
    });
  }

  void resetQuiz() {
    _currentIndex = 0;
    _score = 0;
    notifyListeners();
  }
}
