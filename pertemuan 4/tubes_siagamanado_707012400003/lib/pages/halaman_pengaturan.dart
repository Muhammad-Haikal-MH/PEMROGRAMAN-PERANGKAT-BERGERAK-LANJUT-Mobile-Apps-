import 'package:flutter/material.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            value: true,
            onChanged: (value) {},
            title: const Text('Notifikasi'),
            subtitle: const Text(
              'Terima pemberitahuan mengenai informasi kebencanaan.',
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Bahasa'),
            subtitle: const Text('Bahasa Indonesia'),
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Lokasi'),
            subtitle: const Text('Kota Manado'),
          ),
        ],
      ),
    );
  }
}