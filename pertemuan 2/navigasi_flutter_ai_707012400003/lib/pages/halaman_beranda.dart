import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key});

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {
  String _pesan = 'Belum ada data yang dikirim balik.';

  Future<void> _bukaDetail() async {
    final hasil = await Navigator.pushNamed(
      context,
      AppRoutes.detail,
      arguments: <String, String>{
        'judul': 'Detail Mata Kuliah',
        'keterangan':
            'Mata kuliah ini membahas Pemrograman Perangkat Bergerak Lanjut.',
      },
    );

    if (!mounted) {
      return;
    }

    if (hasil is String) {
      setState(() {
        _pesan = hasil;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Halaman Beranda',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(_pesan),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _bukaDetail,
            child: const Text('Buka Halaman Detail'),
          ),
        ],
      ),
    );
  }
}