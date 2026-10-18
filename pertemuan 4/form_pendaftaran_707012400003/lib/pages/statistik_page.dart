import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pendaftar_model.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PendaftarModel>();
    final jumlah = {
      'Pagi': model.jumlahSesi('Pagi'),
      'Siang': model.jumlahSesi('Siang'),
      'Sore': model.jumlahSesi('Sore'),
    };
    final maksimum = jumlah.values.fold<int>(
      0,
      (nilai, item) => item > nilai ? item : nilai,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Pendaftar')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah pendaftar per sesi',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            for (final sesi in jumlah.entries)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    SizedBox(width: 64, child: Text(sesi.key)),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: maksimum == 0 ? 0 : sesi.value / maksimum,
                        minHeight: 18,
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text('${sesi.value}'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
