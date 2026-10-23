import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk riwayat kuis
    final List<Map<String, String>> historyData = [
      {'title': 'Pemrograman Mobile', 'score': '100/100', 'date': '22 Okt 2026'},
      {'title': 'Basis Data', 'score': '80/100', 'date': '20 Okt 2026'},
      {'title': 'Algoritma', 'score': '90/100', 'date': '18 Okt 2026'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Kuis'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: historyData.length,
        itemBuilder: (context, index) {
          final item = historyData[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Icon(Icons.history_rounded, color: Theme.of(context).primaryColor),
              ),
              title: Text(
                item['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['date']!),
              trailing: Text(
                item['score']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: item['score'] == '100/100' ? Colors.green : Theme.of(context).primaryColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}