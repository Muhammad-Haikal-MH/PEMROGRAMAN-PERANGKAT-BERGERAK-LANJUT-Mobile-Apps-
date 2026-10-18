
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/laporan_model.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  String _formatTanggal(DateTime tanggal) {
    final hari = tanggal.day.toString().padLeft(2, '0');
    final bulan = tanggal.month.toString().padLeft(2, '0');
    final tahun = tanggal.year;

    return '$hari/$bulan/$tahun';
  }

  @override
  Widget build(BuildContext context) {
    // Mendengarkan perubahan data laporan dari Provider.
    final laporanModel = context.watch<LaporanModel>();
    final daftarLaporan = laporanModel.daftarLaporan;
    final jumlahLaporan = laporanModel.jumlahLaporan;

    final List<Map<String, dynamic>> pilar = [
      {
        'nama': 'Smart Governance',
        'ikon': Icons.account_balance,
        'deskripsi':
            'Meningkatkan pelayanan publik berbasis teknologi.',
      },
      {
        'nama': 'Smart Economy',
        'ikon': Icons.trending_up,
        'deskripsi':
            'Mendukung aktivitas ekonomi dan usaha masyarakat.',
      },
      {
        'nama': 'Smart Living',
        'ikon': Icons.home,
        'deskripsi':
            'Meningkatkan kualitas hidup dan keselamatan warga.',
      },
      {
        'nama': 'Smart Mobility',
        'ikon': Icons.directions_car,
        'deskripsi':
            'Mendukung mobilitas masyarakat secara lebih efektif.',
      },
      {
        'nama': 'Smart Environment',
        'ikon': Icons.eco,
        'deskripsi':
            'Mendukung pengelolaan lingkungan kota.',
      },
      {
        'nama': 'Smart People',
        'ikon': Icons.people,
        'deskripsi':
            'Mendorong masyarakat yang aktif dan berdaya.',
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

          // RINGKASAN LAPORAN DARI PROVIDER
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.assignment_outlined,
                      size: 32,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Laporan',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          jumlahLaporan.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const Text(
                          'Laporan yang ditambahkan selama sesi aplikasi',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // LAPORAN TERBARU
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
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Belum ada laporan. Laporan yang '
                        'dikirim melalui formulir akan muncul '
                        'di bagian ini.',
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...daftarLaporan.take(3).map(
              (laporan) => Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.report_outlined),
                  ),
                  title: Text(
                    laporan.judul,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${laporan.jenisBencana} • '
                    '${_formatTanggal(laporan.tanggalLaporan)}',
                  ),
                  isThreeLine: false,
                ),
              ),
            ),

          const SizedBox(height: 24),

          // ENAM PILAR SMART CITY
          Text(
            'Enam Pilar Smart City',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
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
