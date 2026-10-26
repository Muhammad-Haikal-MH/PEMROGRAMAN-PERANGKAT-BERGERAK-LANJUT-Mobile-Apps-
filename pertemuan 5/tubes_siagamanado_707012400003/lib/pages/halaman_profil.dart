
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/laporan_cubit.dart';
import '../models/laporan_model.dart';

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
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

          // INFORMASI PENGGUNA
          Card(
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.badge),
                  title: Text('Identitas Pengguna'),
                  subtitle: Text('Warga'),
                ),

                const Divider(height: 1),

                // JUMLAH LAPORAN DARI LAPORANCUBIT
                BlocSelector<
                    LaporanCubit,
                    List<LaporanBencana>,
                    int>(
                  selector: (state) => state.length,
                  builder: (context, total) {
                    return ListTile(
                      leading: const Icon(
                        Icons.assignment_outlined,
                      ),
                      title: const Text('Laporan Saya'),
                      subtitle: Text(
                        '$total laporan telah dikirim',
                      ),
                      trailing: CircleAvatar(
                        child: Text('$total'),
                      ),
                    );
                  },
                ),

                const Divider(height: 1),

                // JUMLAH FAVORIT DARI FAVORITCUBIT
                BlocSelector<
                    FavoritCubit,
                    Set<String>,
                    int>(
                  selector: (state) => state.length,
                  builder: (context, total) {
                    return ListTile(
                      leading: const Icon(Icons.star),
                      title: const Text('Laporan Favorit'),
                      subtitle: Text(
                        '$total laporan ditandai favorit',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

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

          // DAFTAR FAVORIT REAKTIF
          BlocBuilder<FavoritCubit, Set<String>>(
            builder: (context, favorit) {
              if (favorit.isEmpty) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Icon(
                          Icons.star_border,
                          size: 48,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Belum ada laporan favorit.',
                        ),
                      ],
                    ),
                  ),
                );
              }

              final daftar = favorit.toList()..sort();

              return ListView.separated(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount: daftar.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 8),

                itemBuilder: (context, index) {
                  final judul = daftar[index];

                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),

                      title: Text(judul),

                      trailing: IconButton(
                        tooltip: 'Hapus favorit',
                        onPressed: () {
                          context
                              .read<FavoritCubit>()
                              .hapusFavorit(judul);
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
