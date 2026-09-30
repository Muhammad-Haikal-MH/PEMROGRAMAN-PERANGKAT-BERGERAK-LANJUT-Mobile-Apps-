import 'package:flutter/material.dart';

class HalamanDetailLaporan extends StatelessWidget {
  final String judul;
  final String lokasi;
  final String status;
  final String deskripsi;

  const HalamanDetailLaporan({
    super.key,
    required this.judul,
    required this.lokasi,
    required this.status,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Laporan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.report,
              size: 64,
            ),
            const SizedBox(height: 20),
            Text(
              judul,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text('Lokasi'),
                      subtitle: Text(lokasi),
                    ),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('Status'),
                      subtitle: Text(status),
                    ),
                    ListTile(
                      leading: const Icon(Icons.description),
                      title: const Text('Keterangan'),
                      subtitle: Text(deskripsi),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pop(
                    context,
                    'Laporan "$judul" telah berhasil diperbarui.',
                  );
                },
                icon: const Icon(Icons.check),
                label: const Text('Tandai Ditangani'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}