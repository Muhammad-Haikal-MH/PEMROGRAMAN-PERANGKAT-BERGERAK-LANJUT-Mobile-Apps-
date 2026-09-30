import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';
import '../navigation/app_routes.dart';

class HalamanLaporan extends StatelessWidget {
  const HalamanLaporan({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> laporan = [
      {
        'judul': 'Banjir di Kecamatan Malalayang',
        'lokasi': 'Kecamatan Malalayang',
        'status': 'Sedang Ditangani',
        'deskripsi':
            'Laporan genangan air yang mengganggu akses masyarakat di sekitar wilayah Malalayang.',
      },
      {
        'judul': 'Tanah Longsor di Kecamatan Bunaken',
        'lokasi': 'Kecamatan Bunaken',
        'status': 'Diverifikasi',
        'deskripsi':
            'Material tanah menutup sebagian akses jalan dan membutuhkan penanganan petugas.',
      },
      {
        'judul': 'Pohon Tumbang di Kecamatan Sario',
        'lokasi': 'Kecamatan Sario',
        'status': 'Selesai',
        'deskripsi':
            'Pohon tumbang telah dievakuasi dan akses jalan telah kembali normal.',
      },
    ];

    return Consumer<FavoritModel>(
      builder: (context, favoritModel, child) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: laporan.length,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 12);
          },
          itemBuilder: (context, index) {
            final item = laporan[index];
            final String judul = item['judul']!;
            final bool disukai = favoritModel.isFavorit(judul);

            return Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.warning_amber),
                ),
                title: Text(judul),
                subtitle: Text(
                  '${item['lokasi']}\nStatus: ${item['status']}',
                ),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: disukai
                          ? 'Hapus dari favorit'
                          : 'Tambah ke favorit',
                      onPressed: () {
                        context
                            .read<FavoritModel>()
                            .ubahFavorit(judul);
                      },
                      icon: Icon(
                        disukai ? Icons.star : Icons.star_border,
                        color: disukai ? Colors.amber : null,
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
                onTap: () async {
                  final hasil = await Navigator.pushNamed(
                    context,
                    AppRoutes.detailLaporan,
                    arguments: {
                      'judul': item['judul']!,
                      'lokasi': item['lokasi']!,
                      'status': item['status']!,
                      'deskripsi': item['deskripsi']!,
                    },
                  );

                  if (!context.mounted) {
                    return;
                  }

                  if (hasil is String) {
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
      },
    );
  }
}