import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.account_balance,
                  size: 50,
                ),
                const SizedBox(height: 16),
                Text(
                  'Selamat Datang!',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Nusantara Cerdas Mobile membantu warga '
                  'menemukan layanan pemerintah, menyimpan '
                  'layanan favorit, dan mengajukan beberapa '
                  'layanan dalam satu kunjungan.',
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.layanan,
                    );
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Jelajahi Layanan'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Bidang Pelayanan',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Card(
          child: ListTile(
            leading: Icon(Icons.business_center_outlined),
            title: Text('Perizinan'),
            subtitle: Text(
              'Layanan izin usaha dan kegiatan masyarakat.',
            ),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.medical_services_outlined),
            title: Text('Kesehatan'),
            subtitle: Text(
              'Layanan pemeriksaan dan konsultasi kesehatan.',
            ),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.directions_bus_outlined),
            title: Text('Transportasi'),
            subtitle: Text(
              'Layanan administrasi dan pengaduan transportasi.',
            ),
          ),
        ),
      ],
    );
  }
}