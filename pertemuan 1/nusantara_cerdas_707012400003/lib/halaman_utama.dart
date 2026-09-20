import 'package:flutter/material.dart';
import 'kepala_kota.dart';
import 'kartu_pilar.dart';
import 'panel_laporan.dart';

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nusantara Cerdas'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KepalaKota(),

            const SizedBox(height: 20),

            const Text(
              'Enam Pilar Smart City',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const KartuPilar(
              nama: 'Smart Governance',
              ikon: Icons.account_balance,
              deskripsi:
                  'Meningkatkan kualitas pelayanan publik melalui pemerintahan digital yang transparan dan efektif.',
            ),

            const KartuPilar(
              nama: 'Smart Economy',
              ikon: Icons.business_center,
              deskripsi:
                  'Mendorong pertumbuhan ekonomi melalui inovasi, kewirausahaan, dan pemanfaatan teknologi.',
            ),

            const KartuPilar(
              nama: 'Smart Living',
              ikon: Icons.health_and_safety,
              deskripsi:
                  'Meningkatkan kualitas hidup warga melalui layanan kesehatan, keamanan, dan fasilitas publik.',
            ),

            const KartuPilar(
              nama: 'Smart Mobility',
              ikon: Icons.directions_car,
              deskripsi:
                  'Mewujudkan sistem transportasi yang terintegrasi, aman, nyaman, dan efisien.',
            ),

            const KartuPilar(
              nama: 'Smart Environment',
              ikon: Icons.eco,
              deskripsi:
                  'Mendukung lingkungan yang bersih dan berkelanjutan melalui pengelolaan sumber daya yang cerdas.',
            ),

            const KartuPilar(
              nama: 'Smart People',
              ikon: Icons.people,
              deskripsi:
                  'Meningkatkan kemampuan dan partisipasi masyarakat melalui pendidikan dan pemanfaatan teknologi.',
            ),

            const SizedBox(height: 20),

            const PanelLaporanWarga(),
          ],
        ),
      ),
    );
  }
}
