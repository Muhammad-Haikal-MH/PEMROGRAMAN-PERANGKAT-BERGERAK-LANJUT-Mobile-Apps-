import 'package:flutter/material.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
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
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      Icons.location_city,
                      size: 36,
                      color: Theme.of(context).colorScheme.onPrimary,
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
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Layanan Smart City untuk warga',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Enam Pilar Smart City',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buatKartuPilar(
            context,
            'Smart Governance',
            Icons.account_balance,
            'Pelayanan pemerintahan yang transparan, efektif, dan berbasis teknologi.',
          ),
          _buatKartuPilar(
            context,
            'Smart Economy',
            Icons.trending_up,
            'Mendukung pertumbuhan ekonomi dan inovasi masyarakat melalui teknologi.',
          ),
          _buatKartuPilar(
            context,
            'Smart Living',
            Icons.health_and_safety,
            'Meningkatkan kualitas hidup warga melalui layanan publik yang mudah diakses.',
          ),
          _buatKartuPilar(
            context,
            'Smart Mobility',
            Icons.directions_car,
            'Mendukung transportasi yang aman, terintegrasi, dan efisien.',
          ),
          _buatKartuPilar(
            context,
            'Smart Environment',
            Icons.eco,
            'Mendorong pengelolaan lingkungan yang berkelanjutan dan ramah lingkungan.',
          ),
          _buatKartuPilar(
            context,
            'Smart People',
            Icons.people,
            'Meningkatkan kemampuan dan partisipasi masyarakat dalam membangun kota.',
          ),
        ],
      ),
    );
  }

  Widget _buatKartuPilar(
    BuildContext context,
    String nama,
    IconData ikon,
    String deskripsi,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          child: Icon(ikon),
        ),
        title: Text(
          nama,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(deskripsi),
        ),
      ),
    );
  }
}