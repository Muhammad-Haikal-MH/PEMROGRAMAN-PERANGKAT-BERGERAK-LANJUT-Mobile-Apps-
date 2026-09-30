import 'package:flutter/material.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_jadwal.dart';
import '../pages/halaman_profil.dart';
class KerangkaNavigasi extends StatefulWidget {
 const KerangkaNavigasi({super.key});
 @override
 State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}
class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
 int _indeksTerpilih = 0;
 final List<Widget> _halaman = const [
  HalamanBeranda(),
 HalamanJadwal(),
 HalamanProfil(),
 ];
 final List<String> _judul = const ['Beranda', 'Jadwal', 'Profil'];
 void _pilihTujuan(int indeks) {
 setState(() => _indeksTerpilih = indeks);
 }
@override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(title: Text(_judul[_indeksTerpilih])),
 body: _halaman[_indeksTerpilih],
 bottomNavigationBar: NavigationBar(
 selectedIndex: _indeksTerpilih,
 onDestinationSelected: _pilihTujuan,
 destinations: const [
 NavigationDestination(
 icon: Icon(Icons.home_outlined),
 selectedIcon: Icon(Icons.home),
 label: 'Beranda',
 ),
 NavigationDestination(
 icon: Icon(Icons.calendar_month_outlined),
 selectedIcon: Icon(Icons.calendar_month),
 label: 'Jadwal',
 ),
 NavigationDestination(
 icon: Icon(Icons.person_outline),
 selectedIcon: Icon(Icons.person),
 label: 'Profil',
 ),
 ],
 ),
 );
 }
}