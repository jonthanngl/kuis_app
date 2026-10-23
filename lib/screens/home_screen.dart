import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = context.watch<QuizProvider>().userName;
    final isDark = context.watch<QuizProvider>().isDarkMode;

    // Data dummy untuk tampilan card
    final List<Map<String, dynamic>> quizCategories = [
      {'title': 'Pemrograman Mobile', 'icon': Icons.phone_android_rounded, 'color': Colors.blue, 'active': true},
      {'title': 'Basis Data', 'icon': Icons.storage_rounded, 'color': Colors.orange, 'active': false},
      {'title': 'Kecerdasan Buatan', 'icon': Icons.psychology_rounded, 'color': Colors.purple, 'active': false},
      {'title': 'Jaringan Komputer', 'icon': Icons.router_rounded, 'color': Colors.green, 'active': false},
      {'title': 'UI/UX Design', 'icon': Icons.design_services_rounded, 'color': Colors.pink, 'active': false},
      {'title': 'Algoritma', 'icon': Icons.account_tree_rounded, 'color': Colors.teal, 'active': false},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda Kuis'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => context.read<QuizProvider>().toggleTheme(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Welcome
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColor, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Halo, $userName!', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  const Text('Siap untuk menguji pengetahuanmu hari ini?', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Pilih Kategori Kuis', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Grid View Kategori
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: quizCategories.length,
                    itemBuilder: (context, index) {
                      final cat = quizCategories[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            if (cat['active']) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizScreen()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Kuis ${cat['title']} belum tersedia!')),
                              );
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(color: cat['color'].withOpacity(0.2), shape: BoxShape.circle),
                                child: Icon(cat['icon'], size: 40, color: cat['color']),
                              ),
                              const SizedBox(height: 12),
                              Text(cat['title'], textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}