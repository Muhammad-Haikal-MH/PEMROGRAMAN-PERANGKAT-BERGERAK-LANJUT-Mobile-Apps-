import 'package:flutter/material.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pilar = [
      {
        'nama': 'Smart Governance',
        'ikon': Icons.account_balance,
        'deskripsi': 'Pelayanan pemerintahan yang efektif dan transparan.',
      },
      {
        'nama': 'Smart Economy',
        'ikon': Icons.trending_up,
        'deskripsi': 'Mendorong pertumbuhan ekonomi dan peluang usaha warga.',
      },
      {
        'nama': 'Smart Living',
        'ikon': Icons.home,
        'deskripsi': 'Meningkatkan kualitas hidup masyarakat.',
      },
      {
        'nama': 'Smart Mobility',
        'ikon': Icons.directions_bus,
        'deskripsi': 'Mendukung transportasi kota yang terintegrasi.',
      },
      {
        'nama': 'Smart Environment',
        'ikon': Icons.eco,
        'deskripsi': 'Mewujudkan lingkungan kota yang berkelanjutan.',
      },
      {
        'nama': 'Smart People',
        'ikon': Icons.people,
        'deskripsi': 'Meningkatkan kualitas dan partisipasi masyarakat.',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(
                      Icons.location_city,
                      size: 34,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nusantara Cerdas',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Menuju Kota Cerdas, Maju, dan Berkelanjutan',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Enam Pilar Smart City',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...pilar.map(
            (item) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Icon(item['ikon'] as IconData),
                  title: Text(
                    item['nama'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    item['deskripsi'] as String,
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