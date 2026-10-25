import 'package:flutter/material.dart';

import '../pages/halaman_warga.dart';
import '../pages/halaman_tanya_petugas.dart';
import '../pages/halaman_lokasi_kantor.dart';
import '../pages/halaman_statistik_layanan.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;

  // Empat halaman utama aplikasi.
  final List<Widget> _halaman = const [
    HalamanWarga(),
    HalamanTanyaPetugas(),
    HalamanLokasiKantor(),
    HalamanStatistikLayanan(),
  ];

  final List<String> _judul = const [
    'Nusantara Cerdas Mobile',
    'Tanya Petugas',
    'Lokasi Kantor',
    'Statistik Layanan',
  ];

  void _pilihTujuan(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  // Form dibuka menggunakan named route, bukan
  // Navigator.push langsung ke kelas halaman.
  void _bukaFormulir() {
    Navigator.pushNamed(context, AppRoutes.rincianLayanan);
  }

  @override
  Widget build(BuildContext context) {
    final lebarLayar = MediaQuery.of(context).size.width;
    final layarLebar = lebarLayar >= 700;

    return Scaffold(
      appBar: AppBar(
        title: Text(_judul[_indeksTerpilih]),
        centerTitle: false,
        actions: [
          if (_indeksTerpilih == 0)
            IconButton(
              tooltip: 'Buat pengajuan baru',
              onPressed: _bukaFormulir,
              icon: const Icon(Icons.add_circle_outline),
            ),
          const SizedBox(width: 8),
        ],
      ),

      drawer: _buatDrawer(),

      body: layarLebar
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: _indeksTerpilih,
                  onDestinationSelected: _pilihTujuan,
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Warga'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.chat_outlined),
                      selectedIcon: Icon(Icons.chat),
                      label: Text('Tanya Petugas'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.location_on_outlined),
                      selectedIcon: Icon(Icons.location_on),
                      label: Text('Lokasi Kantor'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.bar_chart_outlined),
                      selectedIcon: Icon(Icons.bar_chart),
                      label: Text('Statistik'),
                    ),
                  ],
                ),

                const VerticalDivider(width: 1),

                Expanded(
                  child: IndexedStack(
                    index: _indeksTerpilih,
                    children: _halaman,
                  ),
                ),
              ],
            )
          : IndexedStack(index: _indeksTerpilih, children: _halaman),

      // FAB hanya tampil di halaman Warga.
      floatingActionButton: _indeksTerpilih == 0
          ? FloatingActionButton.extended(
              onPressed: _bukaFormulir,
              icon: const Icon(Icons.add),
              label: const Text('Buat Pengajuan'),
            )
          : null,

      bottomNavigationBar: layarLebar
          ? null
          : NavigationBar(
              selectedIndex: _indeksTerpilih,
              onDestinationSelected: _pilihTujuan,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Warga',
                ),
                NavigationDestination(
                  icon: Icon(Icons.chat_outlined),
                  selectedIcon: Icon(Icons.chat),
                  label: 'Chat',
                ),
                NavigationDestination(
                  icon: Icon(Icons.location_on_outlined),
                  selectedIcon: Icon(Icons.location_on),
                  label: 'Lokasi',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart),
                  label: 'Statistik',
                ),
              ],
            ),
    );
  }

  Widget _buatDrawer() {
    return NavigationDrawer(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: (indeks) {
        Navigator.pop(context);
        _pilihTujuan(indeks);
      },
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(24, 20, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                child: Icon(Icons.account_balance, size: 30),
              ),
              SizedBox(height: 12),
              Text(
                'Nusantara Cerdas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('Layanan Digital Warga'),
            ],
          ),
        ),

        const NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Warga'),
        ),

        const NavigationDrawerDestination(
          icon: Icon(Icons.chat_outlined),
          selectedIcon: Icon(Icons.chat),
          label: Text('Tanya Petugas'),
        ),

        const NavigationDrawerDestination(
          icon: Icon(Icons.location_on_outlined),
          selectedIcon: Icon(Icons.location_on),
          label: Text('Lokasi Kantor'),
        ),

        const NavigationDrawerDestination(
          icon: Icon(Icons.bar_chart_outlined),
          selectedIcon: Icon(Icons.bar_chart),
          label: Text('Statistik Layanan'),
        ),

        const Divider(),

        ListTile(
          leading: const Icon(Icons.add_circle_outline),
          title: const Text('Buat Pengajuan Baru'),
          onTap: () {
            Navigator.pop(context);
            _bukaFormulir();
          },
        ),
      ],
    );
  }
}
