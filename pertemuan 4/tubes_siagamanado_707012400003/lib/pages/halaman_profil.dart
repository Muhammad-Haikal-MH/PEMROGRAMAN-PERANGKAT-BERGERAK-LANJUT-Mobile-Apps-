
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/laporan_model.dart';
import '../models/favorit_model.dart';

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    // Membaca data laporan dari Provider.
    final laporanModel = context.watch<LaporanModel>();

    // Tetap mendengarkan model favorit Modul 3.
    return Consumer<FavoritModel>(
      builder: (context, favoritModel, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Warga Kota Manado',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Pengguna aplikasi Siaga Manado Mobile',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // INFORMASI DAN STATISTIK PENGGUNA
              Card(
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.badge),
                      title: Text('Identitas Pengguna'),
                      subtitle: Text('Warga'),
                    ),

                    const Divider(height: 1),

                    // Data laporan berasal dari LaporanModel.
                    ListTile(
                      leading: const Icon(
                        Icons.assignment_outlined,
                      ),
                      title: const Text('Laporan Saya'),
                      subtitle: Text(
                        '${laporanModel.jumlahLaporan} laporan '
                        'dikirim melalui formulir',
                      ),
                      trailing: CircleAvatar(
                        child: Text(
                          laporanModel.jumlahLaporan.toString(),
                        ),
                      ),
                    ),

                    const Divider(height: 1),

                    // Data favorit tetap dari Modul 3.
                    ListTile(
                      leading: const Icon(Icons.star),
                      title: const Text('Laporan Favorit'),
                      subtitle: Text(
                        '${favoritModel.totalFavorit} laporan '
                        'ditandai sebagai favorit',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // DAFTAR FAVORIT
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Daftar Favorit',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),

              const SizedBox(height: 12),

              if (favoritModel.daftarFavorit.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.star_border,
                          size: 48,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Belum ada laporan favorit.',
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount:
                      favoritModel.daftarFavorit.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                  itemBuilder: (context, index) {
                    final nama =
                        favoritModel.daftarFavorit[index];

                    return Card(
                      child: ListTile(
                        leading: const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        title: Text(nama),
                        trailing: IconButton(
                          tooltip: 'Hapus dari favorit',
                          onPressed: () {
                            context
                                .read<FavoritModel>()
                                .hapusFavorit(nama);
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
