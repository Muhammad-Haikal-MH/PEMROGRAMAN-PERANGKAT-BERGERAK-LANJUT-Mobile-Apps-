import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';

class HalamanStatistikLayanan extends StatelessWidget {
  const HalamanStatistikLayanan({super.key});

  @override
  Widget build(BuildContext context) {
    // Membaca data terbaru dari Provider.
    final model = context.watch<PengajuanModel>();
    final statistik = model.statistikPerBidang;
    final bidang = PengajuanModel.bidangLayanan;

    final nilaiMaksimum = statistik.values.isEmpty
        ? 0
        : statistik.values.reduce((a, b) => a > b ? a : b);

    // Beri sedikit ruang di atas batang tertinggi.
    final batasAtas = nilaiMaksimum == 0 ? 5.0 : nilaiMaksimum.toDouble() + 1;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Statistik Layanan',
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        const Text(
          'Jumlah pengajuan yang tercatat berdasarkan '
          'bidang layanan.',
        ),

        const SizedBox(height: 20),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Jumlah Pengajuan per Bidang',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  height: 300,
                  child: BarChart(
                    BarChartData(
                      maxY: batasAtas,
                      minY: 0,
                      alignment: BarChartAlignment.spaceAround,

                      gridData: const FlGridData(
                        show: true,
                        drawVerticalLine: false,
                      ),

                      borderData: FlBorderData(show: false),

                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),

                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),

                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 36,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(fontSize: 11),
                              );
                            },
                          ),
                        ),

                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 54,
                            getTitlesWidget: (value, meta) {
                              final indeks = value.toInt();

                              if (indeks < 0 || indeks >= bidang.length) {
                                return const SizedBox.shrink();
                              }

                              return SideTitleWidget(
                                meta: meta,
                                space: 8,
                                child: Text(
                                  '${indeks + 1}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      barGroups: List.generate(bidang.length, (indeks) {
                        final jumlah = statistik[bidang[indeks]] ?? 0;

                        return BarChartGroupData(
                          x: indeks,
                          barRods: [
                            BarChartRodData(
                              toY: jumlah.toDouble(),
                              width: 28,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(6),
                              ),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Nomor batang menunjukkan urutan bidang '
                  'layanan pada daftar di bawah.',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Rincian Pengajuan',
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        ...bidang.asMap().entries.map((entri) {
          final indeks = entri.key;
          final namaBidang = entri.value;
          final jumlah = statistik[namaBidang] ?? 0;

          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('${indeks + 1}')),
              title: Text(namaBidang),
              trailing: Text(
                '$jumlah pengajuan',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        }),

        const SizedBox(height: 8),

        Text(
          'Total seluruh pengajuan: ${model.jumlahPengajuan}',
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
