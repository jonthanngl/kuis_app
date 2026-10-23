import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil riwayat kuis secara dinamis dari QuizProvider
    final quizProvider = context.watch<QuizProvider>();
    final List<Map<String, String>> historyData = quizProvider.history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Kuis'),
        centerTitle: true,
      ),
      body: historyData.isEmpty
          ? const Center(
              child: Text(
                'Belum ada riwayat kuis.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: historyData.length,
              itemBuilder: (context, index) {
                final item = historyData[index];
                final scoreStr = item['score'] ?? '0/100';
                
                // Cek apakah skor sempurna (misal 100/100 atau max score)
                final parts = scoreStr.split('/');
                final bool isPerfect = parts.length == 2 && parts[0] == parts[1];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      child: Icon(Icons.history_rounded, color: Theme.of(context).primaryColor),
                    ),
                    title: Text(
                      item['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(item['date']!),
                    trailing: Text(
                      scoreStr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isPerfect ? Colors.green : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
