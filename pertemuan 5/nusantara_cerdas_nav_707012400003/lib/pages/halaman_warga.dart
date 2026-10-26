import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../model/layanan.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  void _bukaLayanan(
    BuildContext context,
    String namaLayanan,
  ) {
    final layanan = KatalogLayanan.cari(namaLayanan);

    if (layanan == null) return;

    Navigator.pushNamed(
      context,
      AppRoutes.rincianLayanan,
      arguments: layanan,
    );
  }

  void _kirimSemua(BuildContext context) {
    final cubit = context.read<PengajuanCubit>();
    final jumlah = cubit.state.totalPengajuan;

    if (jumlah == 0) return;

    cubit.kirimSemuaPengajuan();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$jumlah layanan berhasil dicatat sebagai pengajuan.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Layanan Warga',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Kelola layanan favorit dan beberapa permohonan '
          'dalam satu keranjang.',
        ),
        const SizedBox(height: 24),

        // DAFTAR FAVORIT
        Text(
          'Layanan Favorit',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, favorit) {
            if (favorit.isEmpty) {
              return const Card(
                child: ListTile(
                  leading: Icon(Icons.star_border),
                  title: Text('Belum ada layanan favorit'),
                  subtitle: Text(
                    'Tandai layanan menggunakan ikon bintang '
                    'di halaman Layanan.',
                  ),
                ),
              );
            }

            final daftar = favorit.toList()..sort();

            return Column(
              children: daftar.map((nama) {
                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    title: Text(nama),
                    onTap: () => _bukaLayanan(context, nama),
                    trailing: IconButton(
                      tooltip: 'Hapus favorit',
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        context
                            .read<FavoritCubit>()
                            .batalTandai(nama);
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),

        const SizedBox(height: 24),

        // KERANJANG PENGAJUAN
        Text(
          'Keranjang Pengajuan',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        BlocBuilder<PengajuanCubit, PengajuanState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                    title: const Text('Total Layanan'),
                    trailing: Text(
                      '${state.totalPengajuan}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge,
                    ),
                  ),
                ),

                if (state.keranjang.isEmpty)
                  const Card(
                    child: ListTile(
                      title: Text('Keranjang masih kosong'),
                      subtitle: Text(
                        'Buka rincian layanan untuk '
                        'menambahkan permohonan.',
                      ),
                    ),
                  )
                else
                  ...state.keranjang.map(
                    (nama) => Card(
                      child: ListTile(
                        leading: const Icon(
                          Icons.assignment_outlined,
                        ),
                        title: Text(nama),
                        trailing: IconButton(
                          tooltip: 'Hapus dari keranjang',
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                          onPressed: () {
                            context
                                .read<PengajuanCubit>()
                                .hapusPengajuan(nama);
                          },
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                FilledButton.icon(
                  onPressed: state.keranjang.isEmpty
                      ? null
                      : () => _kirimSemua(context),
                  icon: const Icon(Icons.send),
                  label: const Text('Kirim Semua Pengajuan'),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 24),

        // RIWAYAT PENGAJUAN
        Text(
          'Riwayat Pengajuan',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        BlocBuilder<PengajuanCubit, PengajuanState>(
          builder: (context, state) {
            if (state.riwayatPengajuan.isEmpty) {
              return const Card(
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text('Belum ada pengajuan terkirim'),
                ),
              );
            }

            return Column(
              children: [
                for (final nama in state.riwayatPengajuan)
                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                      title: Text(nama),
                      subtitle: const Text(
                        'Tercatat sebagai pengajuan',
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}