import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  int _currentIndex = 0;
  int _score = 0;
  bool _isDarkMode = false;

  final List<Question> _questions = [
    Question(
      questionText: 'Apa framework yang digunakan untuk membuat aplikasi ini?',
      options: ['React Native', 'Flutter', 'Kotlin', 'Swift'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'Manakah yang BUKAN merupakan jenis widget di Flutter?',
      options: ['StatelessWidget', 'StatefulWidget', 'InheritedWidget', 'DynamicWidget'],
      correctAnswerIndex: 3,
    ),
    Question(
      questionText: 'Apa fungsi utama dari State Management?',
      options: ['Mendesain UI', 'Menyimpan data di database', 'Mengelola perubahan data dan state UI', 'Menghubungkan API'],
      correctAnswerIndex: 2,
    ),
  ];

  String get userName => _userName;
  int get currentIndex => _currentIndex;
  int get score => _score;
  bool get isDarkMode => _isDarkMode;
  List<Question> get questions => _questions;
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
    notifyListeners();
  }

  void resetQuiz() {
    _currentIndex = 0;
    _score = 0;
    _userName = '';
    notifyListeners();
  }
}