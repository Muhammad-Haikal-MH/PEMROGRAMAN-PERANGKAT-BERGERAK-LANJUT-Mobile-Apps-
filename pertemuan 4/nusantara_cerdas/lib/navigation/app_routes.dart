import 'package:flutter/material.dart';

import '../pages/halaman_rincian_layanan.dart';
import '../pages/halaman_detail_pengajuan.dart';
import '../pages/halaman_tanya_petugas.dart';
import '../pages/halaman_lokasi_kantor.dart';
import '../pages/halaman_statistik_layanan.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  AppRoutes._();

  static const String warga = '/';
  static const String rincianLayanan = '/rincian-layanan';
  static const String tanyaPetugas = '/tanya-petugas';
  static const String lokasiKantor = '/lokasi-kantor';
  static const String statistikLayanan = '/statistik-layanan';
  static const String detailPengajuan = '/detail-pengajuan';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {warga: (_) => const KerangkaNavigasi()};
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    switch (settings.name) {
      case rincianLayanan:
        return MaterialPageRoute(
          builder: (_) => const HalamanRincianLayanan(),
          settings: settings,
        );

      case tanyaPetugas:
        return MaterialPageRoute(
          builder: (_) => const HalamanTanyaPetugas(),
          settings: settings,
        );

      case lokasiKantor:
        return MaterialPageRoute(
          builder: (_) => const HalamanLokasiKantor(),
          settings: settings,
        );

      case statistikLayanan:
        return MaterialPageRoute(
          builder: (_) => const HalamanStatistikLayanan(),
          settings: settings,
        );

      case detailPengajuan:
        final arguments = settings.arguments;

        if (arguments is String) {
          return MaterialPageRoute(
            builder: (_) => HalamanDetailPengajuan(pengajuanId: arguments),
            settings: settings,
          );
        }

        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text('Detail Pengajuan')),
            body: Center(child: Text('ID pengajuan tidak valid.')),
          ),
          settings: settings,
        );

      default:
        return null;
    }
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Halaman Tidak Ditemukan')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 56),
                const SizedBox(height: 16),
                Text(
                  'Route "${settings.name}" tidak terdaftar.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      warga,
                      (route) => false,
                    );
                  },
                  child: const Text('Kembali ke Warga'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
