import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';

class HalamanDetailPengajuan extends StatelessWidget {
  final String pengajuanId;

  const HalamanDetailPengajuan({super.key, required this.pengajuanId});

  String _formatTanggal(DateTime tanggal) {
    final hari = tanggal.day.toString().padLeft(2, '0');
    final bulan = tanggal.month.toString().padLeft(2, '0');
    final jam = tanggal.hour.toString().padLeft(2, '0');
    final menit = tanggal.minute.toString().padLeft(2, '0');

    return '$hari/$bulan/${tanggal.year} • $jam:$menit';
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();
    final pengajuan = model.cariPengajuan(pengajuanId);

    if (pengajuan == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Pengajuan')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search_off, size: 60),
                SizedBox(height: 16),
                Text(
                  'Pengajuan tidak ditemukan.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Data mungkin sudah tidak tersedia '
                  'di sesi aplikasi ini.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final selesai = pengajuan.selesaiDitindaklanjuti;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengajuan')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // HEADER STATUS
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    selesai ? Icons.check_circle : Icons.pending_actions,
                    size: 44,
                    color: selesai
                        ? Colors.green
                        : Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    pengajuan.bidangLayanan,
                    style: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    avatar: Icon(
                      selesai
                          ? Icons.check_circle_outline
                          : Icons.hourglass_top,
                      size: 18,
                    ),
                    label: Text(
                      selesai
                          ? 'Selesai ditindaklanjuti'
                          : 'Menunggu tindak lanjut',
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'Informasi Pemohon',
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          _ItemDetail(
            ikon: Icons.person_outline,
            judul: 'Nama lengkap',
            isi: pengajuan.namaLengkap,
          ),

          _ItemDetail(
            ikon: Icons.email_outlined,
            judul: 'Alamat email',
            isi: pengajuan.email,
          ),

          _ItemDetail(
            ikon: Icons.miscellaneous_services,
            judul: 'Bidang layanan',
            isi: pengajuan.bidangLayanan,
          ),

          _ItemDetail(
            ikon: Icons.schedule,
            judul: 'Sesi kunjungan',
            isi: pengajuan.sesiKunjungan,
          ),

          _ItemDetail(
            ikon: Icons.calendar_month,
            judul: 'Waktu pengajuan',
            isi: _formatTanggal(pengajuan.waktuPengajuan),
          ),

          _ItemDetail(
            ikon: Icons.confirmation_number_outlined,
            judul: 'ID pengajuan',
            isi: pengajuan.id,
          ),

          const SizedBox(height: 20),

          if (!selesai)
            OutlinedButton.icon(
              onPressed: () {
                context.read<PengajuanModel>().tandaiSelesai(pengajuan.id);

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Pengajuan ditandai selesai.'),
                    ),
                  );
              },
              icon: const Icon(Icons.task_alt),
              label: const Text('Tandai Selesai Ditindaklanjuti'),
            ),
        ],
      ),
    );
  }
}

class _ItemDetail extends StatelessWidget {
  final IconData ikon;
  final String judul;
  final String isi;

  const _ItemDetail({
    required this.ikon,
    required this.judul,
    required this.isi,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(ikon),
        title: Text(judul, style: Theme.of(context).textTheme.bodySmall),
        subtitle: SelectableText(isi),
      ),
    );
  }
}
