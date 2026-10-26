
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
  static const String beranda = '/';
  static const String laporan = '/laporan';
  static const String informasi = '/informasi';
  static const String profil = '/profil';

  static const String detailLaporan = '/detail-laporan';
  static const String formLaporan = '/form-laporan';
  static const String petaLaporan = '/peta-laporan';

  static const String pengaturan = '/pengaturan';
  static const String tentang = '/tentang';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (_) => const KerangkaNavigasi(),
      pengaturan: (_) => const HalamanPengaturan(),
      tentang: (_) => const HalamanTentang(),
    };
  }

  static Route<dynamic>? bentukRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case laporan:
        return MaterialPageRoute(
          builder: (_) => const HalamanLaporan(),
          settings: settings,
        );

      case informasi:
        return MaterialPageRoute(
          builder: (_) => const HalamanInformasi(),
          settings: settings,
        );

      case profil:
        return MaterialPageRoute(
          builder: (_) => const HalamanProfil(),
          settings: settings,
        );

      case formLaporan:
        return MaterialPageRoute(
          builder: (_) => const HalamanFormLaporan(),
          settings: settings,
        );

      case petaLaporan:
        return MaterialPageRoute(
          builder: (_) => const HalamanPetaLaporan(),
          settings: settings,
        );

      case detailLaporan:
        final arguments = settings.arguments;

        if (arguments is Map<String, String>) {
          return MaterialPageRoute(
            builder: (_) => HalamanDetailLaporan(
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
          builder: (_) => const HalamanDetailLaporan(
            judul: 'Data Tidak Valid',
            lokasi: 'Tidak tersedia',
            status: 'Tidak tersedia',
            deskripsi: 'Data laporan tidak valid.',
          ),
          settings: settings,
        );

      default:
        return null;
    }
  }

  static Route<dynamic> routeTidakDikenal(
    RouteSettings settings,
  ) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Halaman Tidak Ditemukan'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 56,
              ),
              const SizedBox(height: 16),
              Text(
                'Route "${settings.name}" tidak ditemukan.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
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
    );
  }
}
