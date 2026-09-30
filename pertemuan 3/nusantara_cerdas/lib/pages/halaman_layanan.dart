import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorit_model.dart';

class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                text: 'Perizinan',
                icon: Icon(Icons.description),
              ),
              Tab(
                text: 'Kesehatan',
                icon: Icon(Icons.local_hospital),
              ),
              Tab(
                text: 'Transportasi',
                icon: Icon(Icons.directions_bus),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buatDaftarLayanan(
                  context,
                  [
                    {
                      'nama': 'Izin Usaha',
                      'dinas': 'Dinas Penanaman Modal',
                      'jam': '08.00 - 15.00',
                      'keterangan':
                          'Pengurusan izin usaha bagi masyarakat dan pelaku usaha.',
                    },
                    {
                      'nama': 'Izin Bangunan',
                      'dinas': 'Dinas Pekerjaan Umum',
                      'jam': '08.00 - 15.00',
                      'keterangan':
                          'Layanan pengajuan izin pembangunan bangunan.',
                    },
                    {
                      'nama': 'Izin Reklame',
                      'dinas': 'Dinas Perizinan',
                      'jam': '08.00 - 14.00',
                      'keterangan':
                          'Layanan pengurusan izin pemasangan reklame.',
                    },
                  ],
                ),
                _buatDaftarLayanan(
                  context,
                  [
                    {
                      'nama': 'Pendaftaran Puskesmas',
                      'dinas': 'Dinas Kesehatan',
                      'jam': '07.00 - 14.00',
                      'keterangan':
                          'Pendaftaran layanan kesehatan di puskesmas.',
                    },
                    {
                      'nama': 'Kartu Sehat',
                      'dinas': 'Dinas Kesehatan',
                      'jam': '08.00 - 15.00',
                      'keterangan':
                          'Layanan administrasi kartu kesehatan masyarakat.',
                    },
                    {
                      'nama': 'Ambulans Kota',
                      'dinas': 'Dinas Kesehatan',
                      'jam': '24 Jam',
                      'keterangan':
                          'Layanan ambulans untuk kebutuhan darurat.',
                    },
                  ],
                ),
                _buatDaftarLayanan(
                  context,
                  [
                    {
                      'nama': 'Kartu Transportasi',
                      'dinas': 'Dinas Perhubungan',
                      'jam': '08.00 - 16.00',
                      'keterangan':
                          'Pengajuan kartu transportasi masyarakat.',
                    },
                    {
                      'nama': 'Perizinan Parkir',
                      'dinas': 'Dinas Perhubungan',
                      'jam': '08.00 - 15.00',
                      'keterangan':
                          'Pengurusan izin penggunaan area parkir.',
                    },
                    {
                      'nama': 'Informasi Rute Bus',
                      'dinas': 'Dinas Perhubungan',
                      'jam': '24 Jam',
                      'keterangan':
                          'Informasi rute dan jadwal transportasi kota.',
                    },
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buatDaftarLayanan(
    BuildContext context,
    List<Map<String, String>> daftar,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: daftar.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemBuilder: (context, index) {
        final layanan = daftar[index];
        final nama = layanan['nama']!;

        final isFavorit = context.watch<FavoritModel>().isFavorit(nama);

        return Card(
          child: ListTile(
            leading: const Icon(Icons.miscellaneous_services),
            title: Text(
              nama,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(layanan['dinas']!),
            trailing: IconButton(
              onPressed: () {
                final favorit = context.read<FavoritModel>();

                if (favorit.isFavorit(nama)) {
                  favorit.batalTandai(nama);
                } else {
                  favorit.tandai(nama);
                }
              },
              icon: Icon(
                isFavorit ? Icons.star : Icons.star_border,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail-layanan',
                arguments: layanan,
              );
            },
          ),
        );
      },
    );
  }
}