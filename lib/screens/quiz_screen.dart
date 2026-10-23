import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/option_card.dart';
import 'result_screen.dart'; // Akan dibuat di tahap selanjutnya

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  void _handleAnswer(BuildContext context, int selectedIndex) {
    final provider = context.read<QuizProvider>();
    provider.checkAnswer(selectedIndex);

    // Jika soal sudah habis, pindah ke halaman hasil
    if (provider.isFinished) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ResultScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuis Berlangsung'),
        centerTitle: true,
        automaticallyImplyLeading: false, // Mencegah user kembali ke halaman login saat kuis berjalan
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          // Pencegahan error jika build terpanggil saat navigasi perpindahan layar
          if (quizProvider.isFinished) {
            return const Center(child: CircularProgressIndicator());
          }

          final question = quizProvider.questions[quizProvider.currentIndex];
          final progress = (quizProvider.currentIndex + 1) / quizProvider.questions.length;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Indikator Progres Dinamis
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: Colors.grey.withValues(alpha: 0.3),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Soal ${quizProvider.currentIndex + 1} dari ${quizProvider.questions.length}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Teks Pertanyaan
                Expanded(
                  flex: 2,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        question.questionText,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Opsi Jawaban (Adaptive Design)
                Expanded(
                  flex: 3,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Jika layar lebar (Tablet/Web) gunakan GridView
                      if (constraints.maxWidth > 600) {
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.5, // Proporsi lebar dan tinggi kartu
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: question.options.length,
                          itemBuilder: (context, index) {
                            return OptionCard(
                              text: question.options[index],
                              onTap: () => _handleAnswer(context, index),
                            );
                          },
                        );
                      }
                      // Jika layar kecil (Smartphone) gunakan ListView vertikal
                      else {
                        return ListView.builder(
                          itemCount: question.options.length,
                          itemBuilder: (context, index) {
                            return OptionCard(
                              text: question.options[index],
                              onTap: () => _handleAnswer(context, index),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}