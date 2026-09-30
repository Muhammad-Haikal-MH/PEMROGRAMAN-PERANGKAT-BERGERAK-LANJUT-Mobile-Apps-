import 'package:flutter/material.dart';

class HalamanTentangAplikasi extends StatelessWidget {
  const HalamanTentangAplikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 48,
                child: Icon(
                  Icons.location_city,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Nusantara Cerdas Mobile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Aplikasi layanan warga untuk mendukung '
                'transformasi menuju kota cerdas.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text('Versi 1.0.0'),
            ],
          ),
        ),
      ),
    );
  }
}