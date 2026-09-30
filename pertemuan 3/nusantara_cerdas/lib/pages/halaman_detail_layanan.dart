import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pengajuan_model.dart';

class HalamanDetailLayanan extends StatefulWidget {
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

  @override
  State<HalamanDetailLayanan> createState() =>
      _HalamanDetailLayananState();
}

class _HalamanDetailLayananState
    extends State<HalamanDetailLayanan> {
  bool _sedangMengirim = false;

  Future<void> _ajukanPermohonan() async {
    if (_sedangMengirim) {
      return;
    }

    setState(() {
      _sedangMengirim = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) {
      return;
    }

    context.read<PengajuanModel>().tambahPengajuan(
          widget.namaLayanan,
        );

    setState(() {
      _sedangMengirim = false;
    });

    Navigator.pop(
      context,
      'Permohonan ${widget.namaLayanan} telah diajukan',
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
            const Icon(
              Icons.miscellaneous_services,
              size: 64,
            ),
            const SizedBox(height: 20),
            Text(
              widget.namaLayanan,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.account_balance),
              title: const Text('Dinas Penanggung Jawab'),
              subtitle: Text(
                widget.dinasPenanggungJawab,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.access_time),
              title: const Text('Jam Operasional'),
              subtitle: Text(
                widget.jamOperasional,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Keterangan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.keterangan,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed:
                    _sedangMengirim
                        ? null
                        : _ajukanPermohonan,
                icon: _sedangMengirim
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(
                        Icons.send,
                      ),
                label: Text(
                  _sedangMengirim
                      ? 'Sedang Mengirim...'
                      : 'Ajukan Permohonan',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}