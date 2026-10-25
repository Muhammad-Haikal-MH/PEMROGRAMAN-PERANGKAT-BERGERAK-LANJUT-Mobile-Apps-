import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  String _formatTanggal(DateTime tanggal) {
    final hari = tanggal.day.toString().padLeft(2, '0');
    final bulan = tanggal.month.toString().padLeft(2, '0');

    return '$hari/$bulan/${tanggal.year}';
  }

  void _bukaDetail(BuildContext context, String id) {
    Navigator.pushNamed(context, AppRoutes.detailPengajuan, arguments: id);
  }

  void _tandaiSelesai(BuildContext context, Pengajuan pengajuan) {
    if (pengajuan.selesaiDitindaklanjuti) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pengajuan ini sudah selesai ditindaklanjuti.'),
        ),
      );
      return;
    }

    context.read<PengajuanModel>().tandaiSelesai(pengajuan.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pengajuan "${pengajuan.bidangLayanan}" '
          'ditandai selesai.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();
    final daftarPengajuan = model.daftarPengajuan;

    final totalSelesai = daftarPengajuan
        .where((item) => item.selesaiDitindaklanjuti)
        .length;

    final totalProses = daftarPengajuan.length - totalSelesai;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Sambutan warga.
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                  child: Icon(
                    Icons.account_balance,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang!',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Nusantara Cerdas Mobile membantu '
                        'Anda mengakses layanan warga dengan mudah.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Ringkasan Pengajuan',
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        // Ringkasan dihitung dari PengajuanModel.
        Row(
          children: [
            Expanded(
              child: _KartuRingkasan(
                judul: 'Total',
                jumlah: daftarPengajuan.length,
                ikon: Icons.assignment_outlined,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _KartuRingkasan(
                judul: 'Diproses',
                jumlah: totalProses,
                ikon: Icons.pending_actions,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _KartuRingkasan(
                judul: 'Selesai',
                jumlah: totalSelesai,
                ikon: Icons.task_alt,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: Text(
                'Riwayat Pengajuan',
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Text('${daftarPengajuan.length} pengajuan'),
          ],
        ),

        const SizedBox(height: 8),

        const Text(
          'Ketuk kartu untuk melihat rincian. '
          'Tekan dan tahan kartu untuk menandai pengajuan selesai.',
        ),

        const SizedBox(height: 12),

        if (daftarPengajuan.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
              child: Column(
                children: [
                  Icon(
                    Icons.assignment_add,
                    size: 52,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Belum ada pengajuan',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tekan tombol "Buat Pengajuan" '
                    'untuk mengajukan layanan baru.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        else
          ...daftarPengajuan.map((pengajuan) {
            final sudahSelesai = pengajuan.selesaiDitindaklanjuti;

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,

                // Ketukan tunggal membuka rincian pengajuan.
                onTap: () {
                  _bukaDetail(context, pengajuan.id);
                },

                // Sentuhan panjang menandai pengajuan selesai.
                onLongPress: () {
                  _tandaiSelesai(context, pengajuan);
                },

                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            sudahSelesai
                                ? Icons.check
                                : Icons.assignment_outlined,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pengajuan.bidangLayanan,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(pengajuan.namaLengkap),

                              const SizedBox(height: 4),

                              Text(
                                'Sesi ${pengajuan.sesiKunjungan} • '
                                '${_formatTanggal(pengajuan.waktuPengajuan)}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),

                              const SizedBox(height: 8),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Chip(
                                  avatar: Icon(
                                    sudahSelesai
                                        ? Icons.check_circle
                                        : Icons.hourglass_top,
                                    size: 16,
                                  ),
                                  label: Text(
                                    sudahSelesai
                                        ? 'Selesai ditindaklanjuti'
                                        : 'Menunggu tindak lanjut',
                                  ),
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 4),

                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      ],
    );
  }
}

class _KartuRingkasan extends StatelessWidget {
  final String judul;
  final int jumlah;
  final IconData ikon;

  const _KartuRingkasan({
    required this.judul,
    required this.jumlah,
    required this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Icon(ikon, size: 26),
            const SizedBox(height: 8),
            Text(
              '$jumlah',
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              judul,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
