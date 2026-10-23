import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk kuis favorit
    final List<Map<String, dynamic>> favoriteData = [
      {'title': 'Pemrograman Mobile', 'icon': Icons.phone_android_rounded},
      {'title': 'Kecerdasan Buatan', 'icon': Icons.psychology_rounded},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuis Favorit'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: favoriteData.length,
        itemBuilder: (context, index) {
          final item = favoriteData[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: Icon(
                item['icon'] as IconData,
                size: 32,
                color: Colors.redAccent,
              ),
              title: Text(
                item['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.favorite_rounded, color: Colors.redAccent),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${item['title']} dihapus dari favorit')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}