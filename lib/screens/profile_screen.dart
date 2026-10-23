import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil state dari provider
    final quizProvider = context.watch<QuizProvider>();
    final String userName = quizProvider.userName;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Foto Profil Dummy
              CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                child: Icon(
                  Icons.person_rounded,
                  size: 60,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 24),

              // Nama Pengguna dari Provider
              Text(
                userName.isNotEmpty ? userName : 'Pengguna',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              Text(
                'Mahasiswa Ilmu Komputer',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 32),

              // Statistik Dummy
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(context, 'Kuis Selesai', '12'),
                  Container(height: 40, width: 1, color: Colors.grey.shade300),
                  _buildStatItem(context, 'Skor Rata-rata', '85'),
                ],
              ),
              const SizedBox(height: 48),

              // Tombol Logout
              CustomButton(
                text: 'Keluar',
                width: 200,
                onPressed: () {
                  // Hapus nama pengguna dari provider
                  quizProvider.setUserName('');
                  quizProvider.resetQuiz();

                  // Kembali ke halaman Login
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

  // Widget pembantu untuk kolom statistik
  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}