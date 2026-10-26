import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../model/layanan.dart';
import '../navigation/app_routes.dart';

class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  Future<void> _bukaRincian(
    BuildContext context,
    Layanan layanan,
  ) async {
    final hasil = await Navigator.pushNamed(
      context,
      AppRoutes.rincianLayanan,
      arguments: layanan,
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
    return DefaultTabController(
      length: KatalogLayanan.bidang.length,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Pilih bidang layanan dan tekan ikon bintang '
              'untuk menyimpannya sebagai favorit.',
            ),
          ),

          TabBar(
            isScrollable: true,
            tabs: KatalogLayanan.bidang
                .map((bidang) => Tab(text: bidang))
                .toList(),
          ),

          Expanded(
            child: TabBarView(
              children: KatalogLayanan.bidang.map((bidang) {
                final daftar =
                    KatalogLayanan.berdasarkanBidang(bidang);

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: daftar.length,
                  itemBuilder: (context, index) {
                    final layanan = daftar[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.description_outlined),
                        ),
                        title: Text(layanan.nama),
                        subtitle: Text(layanan.deskripsi),
                        isThreeLine: true,
                        onTap: () {
                          _bukaRincian(context, layanan);
                        },

                        // Ikon bintang memperbarui dirinya
                        // berdasarkan state FavoritCubit.
                        trailing: BlocSelector<
                            FavoritCubit,
                            Set<String>,
                            bool>(
                          selector: (state) {
                            return state.contains(layanan.nama);
                          },
                          builder: (context, disukai) {
                            return IconButton(
                              tooltip: disukai
                                  ? 'Hapus dari favorit'
                                  : 'Tambah ke favorit',
                              icon: Icon(
                                disukai
                                    ? Icons.star
                                    : Icons.star_border,
                                color: disukai
                                    ? Colors.amber
                                    : null,
                              ),
                              onPressed: () {
                                context
                                    .read<FavoritCubit>()
                                    .ubahFavorit(layanan.nama);
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}