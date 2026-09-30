import 'package:flutter/material.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pilar = [
      {
        'nama': 'Smart Governance',
        'ikon': Icons.account_balance,
        'deskripsi': 'Meningkatkan pelayanan publik berbasis teknologi.',
      },
      {
        'nama': 'Smart Economy',
        'ikon': Icons.trending_up,
        'deskripsi': 'Mendukung aktivitas ekonomi dan usaha masyarakat.',
      },
      {
        'nama': 'Smart Living',
        'ikon': Icons.home,
        'deskripsi': 'Meningkatkan kualitas hidup dan keselamatan warga.',
      },
      {
        'nama': 'Smart Mobility',
        'ikon': Icons.directions_car,
        'deskripsi': 'Mendukung mobilitas masyarakat secara lebih efektif.',
      },
      {
        'nama': 'Smart Environment',
        'ikon': Icons.eco,
        'deskripsi': 'Mendukung pengelolaan lingkungan kota.',
      },
      {
        'nama': 'Smart People',
        'ikon': Icons.people,
        'deskripsi': 'Mendorong masyarakat yang aktif dan berdaya.',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 32,
                    child: Icon(
                      Icons.shield,
                      size: 36,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Siaga Manado',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Sistem Informasi Pelaporan dan Informasi Kebencanaan',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Enam Pilar Smart City',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pilar.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 320,
              mainAxisExtent: 150,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final item = pilar[index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(item['ikon']),
                      const SizedBox(height: 8),
                      Text(
                        item['nama'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['deskripsi'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}