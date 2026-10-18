import 'dart:async';

import 'package:flutter/material.dart';

class HalamanDetailLaporan extends StatefulWidget {
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
  State<HalamanDetailLaporan> createState() =>
      _HalamanDetailLaporanState();
}

class _HalamanDetailLaporanState
    extends State<HalamanDetailLaporan> {
  bool _isMemuat = false;

  Future<void> _prosesLaporan() async {
    setState(() {
      _isMemuat = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) {
      return;
    }

    setState(() {
      _isMemuat = false;
    });

    Navigator.pop(
      context,
      'Laporan "${widget.judul}" telah berhasil diproses.',
    );
  }

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
              widget.judul,
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
                      subtitle: Text(widget.lokasi),
                    ),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('Status'),
                      subtitle: Text(widget.status),
                    ),
                    ListTile(
                      leading: const Icon(Icons.description),
                      title: const Text('Keterangan'),
                      subtitle: Text(widget.deskripsi),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _isMemuat ? null : _prosesLaporan,
                icon: _isMemuat
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.check),
                label: Text(
                  _isMemuat
                      ? 'Sedang Memproses...'
                      : 'Tandai Ditangani',
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _isMemuat
                    ? null
                    : () {
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