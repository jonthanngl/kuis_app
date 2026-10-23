import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Membaca nilai dari provider hanya sekali saat render
    final quizProvider = context.read<QuizProvider>();
    final int score = quizProvider.score;
    final String name = quizProvider.userName;
    final int totalSoal = quizProvider.questions.length;
    final int maxScore = totalSoal * 10; // Disesuaikan dengan logika di checkAnswer (10 poin per soal)

    // Menentukan pesan umpan balik berdasarkan perolehan skor
    String feedbackMessage;
    if (score == maxScore) {
      feedbackMessage = 'Sempurna! Kamu menguasai semua materi.';
    } else if (score >= (maxScore / 2)) {
      feedbackMessage = 'Kerja bagus! Tingkatkan terus belajarmu.';
    } else {
      feedbackMessage = 'Jangan menyerah! Ayo coba pelajari lagi.';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Kuis'),
        centerTitle: true,
        automaticallyImplyLeading: false, // Mencegah tombol back dari sistem agar tidak merusak alur
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ikon Trofi
              const Icon(
                Icons.emoji_events_rounded,
                size: 150,
                color: Colors.amber,
              ),
              const SizedBox(height: 24),

              // Nama Pengguna
              Text(
                'Kerja Bagus, $name!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Kartu Skor Akhir (UI Kontras)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 48),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Skor Kamu',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$score / $maxScore',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Pesan Evaluasi
              Text(
                feedbackMessage,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Tombol Ulangi Kuis (Menggunakan Reusable Widget)
              CustomButton(
                text: 'Mulai Ulang Kuis',
                width: 250, // Membatasi lebar tombol agar proporsional
                onPressed: () {
                  // Mereset state aplikasi melalui provider
                  quizProvider.resetQuiz();

                  // Navigasi kembali ke halaman Login sambil menghapus semua riwayat halaman sebelumnya
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}