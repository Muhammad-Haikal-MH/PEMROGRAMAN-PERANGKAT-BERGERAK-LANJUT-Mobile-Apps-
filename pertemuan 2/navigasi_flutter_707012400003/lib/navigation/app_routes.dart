// lib/navigation/app_routes.dart (versi lengkap, tulis ulang seluruh berkas)
import 'package:flutter/material.dart';
import '../pages/halaman_detail.dart';
import '../pages/halaman_pengaturan.dart';
import 'kerangka_navigasi.dart';
import '../pages/halaman_catatan.dart';

class AppRoutes {
 static const String beranda = '/';
 static const String pengaturan = '/pengaturan';
 static const String detail = '/detail';

//  TAMBAHAN 2 - pada kelompok konstanta nama route
 static const String catatan = '/catatan';
 
 static Map<String, WidgetBuilder> daftarRoute() {
 return {
 // route beranda kini mengarah ke kerangka navigasi
 beranda: (context) => const KerangkaNavigasi(),
 pengaturan: (context) => const HalamanPengaturan(),
 catatan: (context) => const HalamanCatatan(),
 };
 }
 static Route<dynamic>? bentukRoute(RouteSettings settings) {
 if (settings.name == detail) {
  final argumen = settings.arguments as Map<String, String>? ?? const {};
 return MaterialPageRoute(
 builder: (context) => HalamanDetail(
 judul: argumen['judul'] ?? 'Tanpa Judul',
 keterangan: argumen['keterangan'] ?? 'Tidak ada keterangan.',
 ),
 );
 }
 return null;
 }
 static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
 return MaterialPageRoute(
 builder: (context) => Scaffold(
 appBar: AppBar(title: const Text('Route Tidak Ditemukan')),
 body: Center(child: Text('Route ${settings.name} belum terdaftar.')),
 ),
 );
 }
}
