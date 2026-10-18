
import 'package:flutter/material.dart';

import '../pages/halaman_detail_laporan.dart';
import '../pages/halaman_form_laporan.dart';
import '../pages/halaman_informasi.dart';
import '../pages/halaman_laporan.dart';
import '../pages/halaman_peta_laporan.dart';
import '../pages/halaman_pengaturan.dart';
import '../pages/halaman_profil.dart';
import '../pages/halaman_tentang.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  // Route halaman utama.
  static const String beranda = '/';
  static const String laporan = '/laporan';
  static const String informasi = '/informasi';
  static const String profil = '/profil';

  // Route Modul 2-3.
  static const String detailLaporan = '/detail-laporan';
  static const String pengaturan = '/pengaturan';
  static const String tentang = '/tentang';

  // Route baru Modul 4.
  static const String formLaporan = '/form-laporan';
  static const String petaLaporan = '/peta-laporan';

  // Route yang terdaftar melalui MaterialApp.routes.
  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      pengaturan: (context) => const HalamanPengaturan(),
      tentang: (context) => const HalamanTentang(),
    };
  }

  // Route yang diproses melalui MaterialApp.onGenerateRoute.
  static Route<dynamic>? bentukRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case laporan:
        return MaterialPageRoute(
          builder: (context) => const HalamanLaporan(),
          settings: settings,
        );

      case informasi:
        return MaterialPageRoute(
          builder: (context) => const HalamanInformasi(),
          settings: settings,
        );

      case profil:
        return MaterialPageRoute(
          builder: (context) => const HalamanProfil(),
          settings: settings,
        );

      // FORM PELAPORAN BENCANA - MODUL 4
      case formLaporan:
        return MaterialPageRoute(
          builder: (context) => const HalamanFormLaporan(),
          settings: settings,
        );

      // GOOGLE MAPS - MODUL 4
      case petaLaporan:
        return MaterialPageRoute(
          builder: (context) => const HalamanPetaLaporan(),
          settings: settings,
        );

      // DETAIL LAPORAN DENGAN ARGUMEN
      case detailLaporan:
        final arguments = settings.arguments;

        if (arguments is Map<String, String>) {
          return MaterialPageRoute(
            builder: (context) => HalamanDetailLaporan(
              judul: arguments['judul'] ?? 'Laporan',
              lokasi: arguments['lokasi'] ??
                  'Lokasi tidak diketahui',
              status: arguments['status'] ??
                  'Belum diketahui',
              deskripsi: arguments['deskripsi'] ??
                  'Tidak ada deskripsi laporan.',
            ),
            settings: settings,
          );
        }

        return MaterialPageRoute(
          builder: (context) => const HalamanDetailLaporan(
            judul: 'Data Tidak Valid',
            lokasi: 'Tidak tersedia',
            status: 'Tidak tersedia',
            deskripsi:
                'Data laporan yang dikirim tidak valid.',
          ),
          settings: settings,
        );

      default:
        return null;
    }
  }

  // Penanganan route yang tidak terdaftar.
  static Route<dynamic> routeTidakDikenal(
    RouteSettings settings,
  ) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Route Tidak Ditemukan'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Halaman tidak ditemukan.',
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
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      beranda,
                      (route) => false,
                    );
                  },
                  child: const Text('Kembali ke Beranda'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
