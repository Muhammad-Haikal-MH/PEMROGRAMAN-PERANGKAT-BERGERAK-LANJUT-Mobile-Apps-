
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/laporan_cubit.dart';
import '../models/laporan_model.dart';
import '../navigation/app_routes.dart';

class HalamanLaporan extends StatelessWidget {
  const HalamanLaporan({super.key});

  static const List<Map<String, String>> laporanContoh = [
    {
      'judul': 'Banjir di Kecamatan Malalayang',
      'lokasi': 'Kecamatan Malalayang',
      'status': 'Sedang Ditangani',
      'deskripsi':
          'Laporan genangan air yang mengganggu akses masyarakat.',
    },
    {
      'judul': 'Tanah Longsor di Kecamatan Bunaken',
      'lokasi': 'Kecamatan Bunaken',
      'status': 'Diverifikasi',
      'deskripsi':
          'Material tanah menutup sebagian akses jalan.',
    },
    {
      'judul': 'Pohon Tumbang di Kecamatan Sario',
      'lokasi': 'Kecamatan Sario',
      'status': 'Selesai',
      'deskripsi':
          'Pohon tumbang telah dievakuasi dan jalan kembali normal.',
    },
  ];

  Future<void> _bukaDetail(
    BuildContext context,
    Map<String, String> laporan,
  ) async {
    final hasil = await Navigator.pushNamed(
      context,
      AppRoutes.detailLaporan,
      arguments: {
        'judul': laporan['judul'] ?? '',
        'lokasi': laporan['lokasi'] ?? '',
        'status': laporan['status'] ?? '',
        'deskripsi': laporan['deskripsi'] ?? '',
      },
    );

    if (!context.mounted) return;

    if (hasil is String) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(hasil)),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaporanCubit, List<LaporanBencana>>(
      builder: (context, daftarLaporan) {
        // Ubah laporan dari Cubit menjadi data tampilan.
        final laporanBaru = daftarLaporan.map((laporan) {
          final lokasi = laporan.latitude != null &&
                  laporan.longitude != null
              ? '${laporan.latitude!.toStringAsFixed(6)}, '
                  '${laporan.longitude!.toStringAsFixed(6)}'
              : 'Lokasi belum tersedia';

          return <String, String>{
            'judul': laporan.judul,
            'lokasi': lokasi,
            'status': 'Menunggu Verifikasi',
            'deskripsi': laporan.deskripsi,
          };
        }).toList();

        final semuaLaporan = <Map<String, String>>[
          ...laporanBaru,
          ...laporanContoh,
        ];

        return Column(
          children: [
            // RINGKASAN
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16, 16, 16, 8,
              ),
              child: Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.assignment_outlined),
                  ),
                  title: const Text('Total Laporan'),
                  subtitle: const Text(
                    'Termasuk laporan contoh dan laporan baru.',
                  ),
                  trailing: Text(
                    '${semuaLaporan.length}',
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

            // DAFTAR LAPORAN
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: semuaLaporan.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: 12),

                itemBuilder: (context, index) {
                  final laporan = semuaLaporan[index];
                  final judul = laporan['judul'] ?? '';
                  final lokasi = laporan['lokasi'] ?? '';
                  final status = laporan['status'] ?? '';

                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.warning_amber),
                      ),

                      title: Text(judul),

                      subtitle: Text(
                        '$lokasi\nStatus: $status',
                      ),

                      isThreeLine: true,

                      // STATUS FAVORIT DARI CUBIT
                      trailing: BlocSelector<
                          FavoritCubit,
                          Set<String>,
                          bool>(
                        selector: (state) {
                          return state.contains(judul);
                        },
                        builder: (context, disukai) {
                          return IconButton(
                            tooltip: disukai
                                ? 'Hapus dari favorit'
                                : 'Tambah ke favorit',
                            onPressed: () {
                              context
                                  .read<FavoritCubit>()
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
                          );
                        },
                      ),

                      onTap: () {
                        _bukaDetail(context, laporan);
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
