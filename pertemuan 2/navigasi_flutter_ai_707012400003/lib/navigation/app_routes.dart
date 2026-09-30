import 'package:flutter/material.dart';
import '../pages/halaman_detail.dart';
import '../pages/halaman_pengaturan.dart';
import 'kerangka_navigasi.dart';
import '../pages/halaman_catatan.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detail = '/detail';
  static const String pengaturan = '/pengaturan';
  static const String catatan = '/catatan';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      pengaturan: (context) => const HalamanPengaturan(),
      catatan: (context) => const HalamanCatatan(),
    };
  }

  static Route<dynamic> bentukRoute(RouteSettings settings) {
    if (settings.name == detail) {
      final arguments = settings.arguments;

      if (arguments is Map<String, String>) {
        return MaterialPageRoute(
          builder: (context) => HalamanDetail(
            judul: arguments['judul'] ?? 'Detail',
            keterangan: arguments['keterangan'] ?? '',
          ),
        );
      }

      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('Argument route tidak valid.'),
          ),
        ),
      );
    }

    return routeTidakDikenal(settings);
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Route Tidak Ditemukan'),
          ),
          body: Center(
            child: Text(
              'Route "${settings.name}" tidak ditemukan.',
            ),
          ),
        );
      },
    );
  }
}