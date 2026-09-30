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
                'Terima informasi terbaru mengenai layanan kota.',
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text(
                'Kota Nusantara',
              ),
              subtitle: const Text(
                'Wilayah layanan aplikasi saat ini.',
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text(
                'Bahasa',
              ),
              subtitle: const Text(
                'Bahasa Indonesia',
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}