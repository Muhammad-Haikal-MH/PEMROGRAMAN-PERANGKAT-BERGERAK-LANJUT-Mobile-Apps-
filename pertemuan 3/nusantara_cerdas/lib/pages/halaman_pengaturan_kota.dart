import 'package:flutter/material.dart';

class HalamanPengaturanKota extends StatelessWidget {
  const HalamanPengaturanKota({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Kota'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: SwitchListTile(
              value: true,
              onChanged: (value) {},
              title: const Text(
                'Notifikasi Layanan',
              ),
              subtitle: const Text(
                'Terima informasi terbaru layanan kota.',
              ),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Kota Nusantara'),
              subtitle: Text(
                'Wilayah layanan aplikasi.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}