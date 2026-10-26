import 'package:flutter/material.dart';

import '../model/layanan.dart';
import '../pages/halaman_rincian_layanan.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  AppRoutes._();

  static const String beranda = '/';
  static const String layanan = '/layanan';
  static const String warga = '/warga';
  static const String rincianLayanan = '/rincian-layanan';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (_) => const KerangkaNavigasi(
            initialIndex: 0,
          ),
      layanan: (_) => const KerangkaNavigasi(
            initialIndex: 1,
          ),
      warga: (_) => const KerangkaNavigasi(
            initialIndex: 2,
          ),
    };
  }

  static Route<dynamic>? bentukRoute(
    RouteSettings settings,
  ) {
    if (settings.name == rincianLayanan) {
      final arguments = settings.arguments;

      if (arguments is Layanan) {
        return MaterialPageRoute(
          builder: (_) => HalamanRincianLayanan(
            layanan: arguments,
          ),
          settings: settings,
        );
      }

      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text('Rincian Layanan'),
          ),
          body: const Center(
            child: Text('Data layanan tidak valid.'),
          ),
        ),
        settings: settings,
      );
    }

    return null;
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
          child: FilledButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                beranda,
                (route) => false,
              );
            },
            child: const Text('Kembali ke Beranda'),
          ),
        ),
      ),
    );
  }
}