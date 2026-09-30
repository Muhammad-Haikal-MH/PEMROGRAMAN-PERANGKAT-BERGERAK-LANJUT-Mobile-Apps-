import 'package:flutter/material.dart';

class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  Widget _buatDaftarLayanan(
    BuildContext context,
    List<Map<String, String>> daftarLayanan,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: daftarLayanan.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        final Map<String, String> layanan = daftarLayanan[index];

        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              child: Icon(
                layanan['ikon'] == 'izin'
                    ? Icons.description_outlined
                    : layanan['ikon'] == 'kesehatan'
                        ? Icons.local_hospital_outlined
                        : Icons.directions_bus_outlined,
              ),
            ),
            title: Text(
              layanan['nama'] ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                layanan['keterangan'] ?? '',
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final String? hasil = await Navigator.pushNamed<String>(
                context,
                '/detail-layanan',
                arguments: <String, String>{
                  'namaLayanan': layanan['nama'] ?? '',
                  'dinasPenanggungJawab':
                      layanan['dinas'] ?? '',
                  'jamOperasional':
                      layanan['jam'] ?? '',
                  'keterangan':
                      layanan['keterangan'] ?? '',
                },
              );

              if (!context.mounted) {
                return;
              }

              if (hasil != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(hasil),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.description_outlined),
                text: 'Perizinan',
              ),
              Tab(
                icon: Icon(Icons.local_hospital_outlined),
                text: 'Kesehatan',
              ),
              Tab(
                icon: Icon(Icons.directions_bus_outlined),
                text: 'Transportasi',
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
                      'dinas': 'Dinas Penanaman Modal dan Pelayanan Terpadu',
                      'jam': '08.00 - 15.00',
                      'keterangan':
                          'Layanan pengajuan izin usaha bagi warga dan pelaku usaha.',
                      'ikon': 'izin',
                    },
                    {
                      'nama': 'Izin Mendirikan Bangunan',
                      'dinas': 'Dinas Pekerjaan Umum dan Tata Ruang',
                      'jam': '08.00 - 15.00',
                      'keterangan':
                          'Layanan pengajuan perizinan pembangunan dan bangunan.',
                      'ikon': 'izin',
                    },
                    {
                      'nama': 'Izin Reklame',
                      'dinas': 'Dinas Pelayanan Terpadu',
                      'jam': '08.00 - 14.00',
                      'keterangan':
                          'Layanan pengajuan izin pemasangan media reklame.',
                      'ikon': 'izin',
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
                          'Layanan pendaftaran dan pemeriksaan kesehatan di puskesmas.',
                      'ikon': 'kesehatan',
                    },
                    {
                      'nama': 'Ambulans Kota',
                      'dinas': 'Dinas Kesehatan',
                      'jam': '24 Jam',
                      'keterangan':
                          'Layanan bantuan transportasi medis darurat bagi warga.',
                      'ikon': 'kesehatan',
                    },
                    {
                      'nama': 'Jadwal Imunisasi',
                      'dinas': 'Dinas Kesehatan',
                      'jam': '08.00 - 15.00',
                      'keterangan':
                          'Informasi dan layanan jadwal imunisasi masyarakat.',
                      'ikon': 'kesehatan',
                    },
                  ],
                ),
                _buatDaftarLayanan(
                  context,
                  [
                    {
                      'nama': 'Kartu Transportasi Kota',
                      'dinas': 'Dinas Perhubungan',
                      'jam': '08.00 - 16.00',
                      'keterangan':
                          'Layanan pendaftaran kartu transportasi umum kota.',
                      'ikon': 'transportasi',
                    },
                    {
                      'nama': 'Pengaduan Transportasi',
                      'dinas': 'Dinas Perhubungan',
                      'jam': '24 Jam',
                      'keterangan':
                          'Layanan pengaduan terkait fasilitas dan transportasi umum.',
                      'ikon': 'transportasi',
                    },
                    {
                      'nama': 'Informasi Rute Bus',
                      'dinas': 'Dinas Perhubungan',
                      'jam': '06.00 - 22.00',
                      'keterangan':
                          'Informasi rute dan jadwal operasional bus kota.',
                      'ikon': 'transportasi',
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
}