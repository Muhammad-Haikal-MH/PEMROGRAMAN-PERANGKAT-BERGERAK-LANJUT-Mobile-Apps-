import 'package:flutter/material.dart';

class HalamanDetailLayanan extends StatelessWidget {
  final String namaLayanan;
  final String dinasPenanggungJawab;
  final String jamOperasional;
  final String keterangan;

  const HalamanDetailLayanan({
    super.key,
    required this.namaLayanan,
    required this.dinasPenanggungJawab,
    required this.jamOperasional,
    required this.keterangan,
  });

  void _ajukanPermohonan(BuildContext context) {
    Navigator.pop(
      context,
      'Permohonan $namaLayanan telah diajukan',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Layanan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                child: Icon(
                  Icons.miscellaneous_services,
                  size: 42,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              namaLayanan,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buatInformasi(
                      Icons.account_balance,
                      'Dinas Penanggung Jawab',
                      dinasPenanggungJawab,
                    ),
                    const Divider(height: 24),
                    _buatInformasi(
                      Icons.access_time,
                      'Jam Operasional',
                      jamOperasional,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Keterangan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              keterangan,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  _ajukanPermohonan(context);
                },
                icon: const Icon(Icons.send),
                label: const Text('Ajukan Permohonan'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buatInformasi(
    IconData ikon,
    String label,
    String nilai,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(ikon),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                nilai,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}