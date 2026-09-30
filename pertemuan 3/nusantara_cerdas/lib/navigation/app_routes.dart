import 'package:flutter/material.dart';
import '../pages/halaman_detail_layanan.dart';
import '../pages/halaman_pengaturan_kota.dart';
import '../pages/halaman_riwayat_laporan.dart';
import '../pages/halaman_tentang_aplikasi.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detailLayanan = '/detail-layanan';
  static const String pengaturanKota = '/pengaturan-kota';
  static const String tentangAplikasi = '/tentang-aplikasi';
  static const String riwayatLaporan = '/riwayat-laporan';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) {
        return const KerangkaNavigasi();
      },
      pengaturanKota: (context) {
        return const HalamanPengaturanKota();
      },
      tentangAplikasi: (context) {
        return const HalamanTentangAplikasi();
      },
      riwayatLaporan: (context) {
        return const HalamanRiwayatLaporan();
      },
    };
  }

  static Route<dynamic> bentukRoute(
    RouteSettings settings,
  ) {
    if (settings.name == detailLayanan) {
      final arguments = settings.arguments;

      if (arguments is Map<String, String>) {
        return MaterialPageRoute(
          builder: (context) {
            return HalamanDetailLayanan(
              namaLayanan:
                  arguments['namaLayanan'] ?? '',
              dinasPenanggungJawab:
                  arguments['dinasPenanggungJawab'] ?? '',
              jamOperasional:
                  arguments['jamOperasional'] ?? '',
              keterangan:
                  arguments['keterangan'] ?? '',
            );
          },
        );
      }

      return MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Data Tidak Valid',
              ),
            ),
            body: const Center(
              child: Text(
                'Data detail layanan tidak valid.',
              ),
            ),
          );
        },
      );
    }

    return routeTidakDikenal(settings);
  }

  static Route<dynamic> routeTidakDikenal(
    RouteSettings settings,
  ) {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Route Tidak Ditemukan',
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Halaman tidak ditemukan.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Route "${settings.name}" tidak terdaftar.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Kembali'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}