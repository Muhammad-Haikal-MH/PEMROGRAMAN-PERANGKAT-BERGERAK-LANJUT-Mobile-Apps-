import 'package:flutter/material.dart';

class PanelLaporanWarga extends StatefulWidget {
  const PanelLaporanWarga({super.key});

  @override
  State<PanelLaporanWarga> createState() => _PanelLaporanWargaState();
}

class _PanelLaporanWargaState extends State<PanelLaporanWarga> {
  int _jumlahLaporan = 0;

  void _laporanMasuk() {
    setState(() {
      _jumlahLaporan++;
    });
  }

  void _laporanSelesai() {
    setState(() {
      if (_jumlahLaporan > 0) {
        _jumlahLaporan--;
      }
    });
  }

  void _resetHarian() {
    setState(() {
      _jumlahLaporan = 0;
    });
  }

  String _statusPelayanan() {
    if (_jumlahLaporan < 5) {
      return 'Pelayanan Lancar';
    } else if (_jumlahLaporan <= 10) {
      return 'Pelayanan Sibuk';
    } else {
      return 'Perlu Penambahan Petugas';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Laporan Warga',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.assignment,
                  size: 32,
                  color: Colors.indigo,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jumlah Laporan Hari Ini',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '$_jumlahLaporan',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _statusPelayanan(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _laporanMasuk,
                  icon: const Icon(Icons.add),
                  label: const Text('Laporan Masuk'),
                ),
                ElevatedButton.icon(
                  onPressed: _laporanSelesai,
                  icon: const Icon(Icons.check),
                  label: const Text('Laporan Selesai'),
                ),
                OutlinedButton.icon(
                  onPressed: _resetHarian,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset Harian'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
