
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/laporan_model.dart';
import '../models/favorit_model.dart';
import '../navigation/app_routes.dart';

class HalamanLaporan extends StatelessWidget {
  const HalamanLaporan({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil laporan dari Provider.
    // Halaman otomatis diperbarui ketika data berubah.
    final laporanModel = context.watch<LaporanModel>();

    final laporanDinamis =
        laporanModel.daftarLaporan.map((laporan) {
      final String lokasi;

      if (laporan.latitude != null &&
          laporan.longitude != null) {
        lokasi =
            'Koordinat: ${laporan.latitude!.toStringAsFixed(6)}, '
            '${laporan.longitude!.toStringAsFixed(6)}';
      } else {
        lokasi = 'Lokasi belum tersedia';
      }

      return <String, String>{
        'id': laporan.id,
        'judul': laporan.judul,
        'lokasi': lokasi,
        'status': 'Menunggu Verifikasi',
        'deskripsi': laporan.deskripsi,
      };
    }).toList();

    // Data contoh Modul 2–3 tetap dipertahankan.
    final List<Map<String, String>> laporanContoh = [
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

    // Laporan baru diletakkan di bagian paling atas.
    final List<Map<String, String>> semuaLaporan = [
      ...laporanDinamis,
      ...laporanContoh,
    ];

    return Consumer<FavoritModel>(
      builder: (context, favoritModel, child) {
        return Column(
          children: [
            // Ringkasan jumlah laporan.
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                8,
              ),
              child: Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.assignment_outlined),
                  ),
                  title: const Text('Total Laporan'),
                  subtitle: const Text(
                    'Termasuk laporan yang dikirim melalui formulir.',
                  ),
                  trailing: Text(
                    semuaLaporan.length.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),

            // Daftar laporan.
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: semuaLaporan.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12);
                },
                itemBuilder: (context, index) {
                  final item = semuaLaporan[index];

                  final String judul = item['judul']!;
                  final String lokasi = item['lokasi']!;
                  final String status = item['status']!;
                  final String deskripsi =
                      item['deskripsi']!;

                  final bool disukai =
                      favoritModel.isFavorit(judul);

                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(
                          Icons.warning_amber,
                        ),
                      ),

                      title: Text(judul),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(
                          top: 6,
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(lokasi),
                            const SizedBox(height: 4),
                            Text('Status: $status'),
                          ],
                        ),
                      ),

                      isThreeLine: true,

                      trailing: IconButton(
                        tooltip: disukai
                            ? 'Hapus dari favorit'
                            : 'Tambah ke favorit',
                        onPressed: () {
                          context
                              .read<FavoritModel>()
                              .ubahFavorit(judul);
                        },
                        icon: Icon(
                          disukai
                              ? Icons.star
                              : Icons.star_border,
                          color: disukai
                              ? Colors.amber
                              : null,
                        ),
                      ),

                      onTap: () async {
                        final hasil =
                            await Navigator.pushNamed(
                          context,
                          AppRoutes.detailLaporan,
                          arguments: {
                            'judul': judul,
                            'lokasi': lokasi,
                            'status': status,
                            'deskripsi': deskripsi,
                          },
                        );

                        if (!context.mounted) {
                          return;
                        }

                        if (hasil is String) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(hasil),
                              ),
                            );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
