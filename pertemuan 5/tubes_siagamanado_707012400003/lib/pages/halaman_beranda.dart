
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/laporan_cubit.dart';
import '../models/laporan_model.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  String _formatTanggal(DateTime tanggal) {
    final hari = tanggal.day.toString().padLeft(2, '0');
    final bulan = tanggal.month.toString().padLeft(2, '0');

    return '$hari/$bulan/${tanggal.year}';
  }

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
        'deskripsi': 'Mendukung aktivitas ekonomi masyarakat.',
      },
      {
        'nama': 'Smart Living',
        'ikon': Icons.home,
        'deskripsi': 'Meningkatkan kualitas hidup dan keselamatan warga.',
      },
      {
        'nama': 'Smart Mobility',
        'ikon': Icons.directions_car,
        'deskripsi': 'Mendukung mobilitas masyarakat secara efektif.',
      },
      {
        'nama': 'Smart Environment',
        'ikon': Icons.eco,
        'deskripsi': 'Mendukung pengelolaan lingkungan kota.',
      },
      {
        'nama': 'Smart People',
        'ikon': Icons.people,
        'deskripsi': 'Mendorong masyarakat aktif dan berdaya.',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IDENTITAS APLIKASI
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
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
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
                          'Sistem Informasi Pelaporan '
                          'dan Informasi Kebencanaan',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // DATA LAPORAN DARI CUBIT
          BlocBuilder<LaporanCubit, List<LaporanBencana>>(
            builder: (context, daftarLaporan) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.assignment_outlined),
                      ),
                      title: const Text('Total Laporan Saya'),
                      subtitle: const Text(
                        'Laporan yang dikirim pada sesi aplikasi.',
                      ),
                      trailing: Text(
                        '${daftarLaporan.length}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Laporan Terbaru',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 12),

                  if (daftarLaporan.isEmpty)
                    const Card(
                      child: ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text(
                          'Belum ada laporan baru',
                        ),
                        subtitle: Text(
                          'Laporan yang dikirim akan '
                          'muncul di bagian ini.',
                        ),
                      ),
                    )
                  else
                    ...daftarLaporan.take(3).map(
                      (laporan) => Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.report_outlined,
                          ),
                          title: Text(laporan.judul),
                          subtitle: Text(
                            '${laporan.jenisBencana} • '
                            '${_formatTanggal(laporan.tanggalLaporan)}',
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),

          // ENAM PILAR SMART CITY
          Text(
            'Enam Pilar Smart City',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pilar.length,
            gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
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
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Icon(item['ikon'] as IconData),

                      const SizedBox(height: 8),

                      Text(
                        item['nama'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        item['deskripsi'] as String,
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
