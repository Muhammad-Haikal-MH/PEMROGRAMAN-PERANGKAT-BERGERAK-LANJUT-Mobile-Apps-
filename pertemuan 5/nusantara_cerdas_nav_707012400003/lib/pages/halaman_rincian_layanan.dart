import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../model/layanan.dart';

class HalamanRincianLayanan extends StatefulWidget {
  final Layanan layanan;

  const HalamanRincianLayanan({
    super.key,
    required this.layanan,
  });

  @override
  State<HalamanRincianLayanan> createState() =>
      _HalamanRincianLayananState();
}

class _HalamanRincianLayananState
    extends State<HalamanRincianLayanan> {
  bool _sedangMengirim = false;

  Future<void> _ajukanPermohonan() async {
    if (_sedangMengirim) return;

    setState(() {
      _sedangMengirim = true;
    });

    // Simulasi proses pengiriman permohonan.
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    final cubit = context.read<PengajuanCubit>();

    if (cubit.state.sudahDiKeranjang(widget.layanan.nama)) {
      setState(() {
        _sedangMengirim = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Layanan ini sudah berada di keranjang.',
          ),
        ),
      );
      return;
    }

    cubit.tambahPengajuan(widget.layanan.nama);

    Navigator.pop(
      context,
      '${widget.layanan.nama} berhasil ditambahkan '
      'ke keranjang pengajuan.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final layanan = widget.layanan;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Layanan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.description_outlined,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    layanan.nama,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(layanan.bidang),
                  ),
                  const SizedBox(height: 16),
                  Text(layanan.deskripsi),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // FAVORIT DARI CUBIT
          BlocSelector<FavoritCubit, Set<String>, bool>(
            selector: (state) {
              return state.contains(layanan.nama);
            },
            builder: (context, disukai) {
              return OutlinedButton.icon(
                onPressed: _sedangMengirim
                    ? null
                    : () {
                        context
                            .read<FavoritCubit>()
                            .ubahFavorit(layanan.nama);
                      },
                icon: Icon(
                  disukai ? Icons.star : Icons.star_border,
                  color: disukai ? Colors.amber : null,
                ),
                label: Text(
                  disukai
                      ? 'Hapus dari Favorit'
                      : 'Tambah ke Favorit',
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          // LOADING MENGGUNAKAN SETSTATE
          ElevatedButton.icon(
            onPressed:
                _sedangMengirim ? null : _ajukanPermohonan,
            icon: _sedangMengirim
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.send),
            label: Text(
              _sedangMengirim
                  ? 'Sedang Mengirim...'
                  : 'Ajukan Permohonan',
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Permohonan akan ditambahkan ke keranjang. '
            'Buka tujuan Warga untuk mengirim seluruh '
            'layanan sekaligus.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}