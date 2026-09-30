import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritModel>(
      builder: (context, favoritModel, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
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
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pengguna aplikasi Siaga Manado Mobile',
              ),
              const SizedBox(height: 24),
              Card(
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.badge),
                      title: Text('Identitas Pengguna'),
                      subtitle: Text('Warga'),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.star),
                      title: const Text('Layanan/Laporan Favorit'),
                      subtitle: Text(
                        '${favoritModel.totalFavorit} laporan ditandai sebagai favorit',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Daftar Favorit',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favoritModel.daftarFavorit.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                  itemBuilder: (context, index) {
                    final nama =
                        favoritModel.daftarFavorit[index];

                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.star),
                        title: Text(nama),
                        trailing: IconButton(
                          onPressed: () {
                            context
                                .read<FavoritModel>()
                                .hapusFavorit(nama);
                          },
                          icon: const Icon(Icons.delete_outline),
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