import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  void _bukaRiwayatLaporan(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.riwayatLaporan,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 24),
          const CircleAvatar(
            radius: 48,
            child: Icon(
              Icons.person,
              size: 52,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Muhammad Haikal',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'SIKC 48-03',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'NIM: 707012400003',
          ),
          const SizedBox(height: 32),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.history),
              ),
              title: const Text(
                'Riwayat Laporan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Lihat laporan warga yang pernah dibuat.',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                _bukaRiwayatLaporan(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}