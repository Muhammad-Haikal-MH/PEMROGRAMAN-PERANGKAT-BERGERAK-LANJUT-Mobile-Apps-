import 'package:flutter/material.dart';

class HalamanDetail extends StatelessWidget {
  final String judul;
  final String keterangan;

  const HalamanDetail({
    super.key,
    required this.judul,
    required this.keterangan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              keterangan,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kembali'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  'Data dari halaman detail',
                );
              },
              child: const Text('Kembali dengan Nilai'),
            ),
          ],
        ),
      ),
    );
  }
}