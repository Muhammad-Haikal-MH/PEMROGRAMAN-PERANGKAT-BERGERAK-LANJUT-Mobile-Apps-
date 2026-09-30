import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  void _bukaCatatan(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.catatan,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 48,
            child: Icon(
              Icons.person,
              size: 48,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Profil Mahasiswa',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Mahasiswa Sistem Informasi Kota Cerdas',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              _bukaCatatan(context);
            },
            icon: const Icon(Icons.note),
            label: const Text('Buka Halaman Catatan'),
          ),
        ],
      ),
    );
  }
}