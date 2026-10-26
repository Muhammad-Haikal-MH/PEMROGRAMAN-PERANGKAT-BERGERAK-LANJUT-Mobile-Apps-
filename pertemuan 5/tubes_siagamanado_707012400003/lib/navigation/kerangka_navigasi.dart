
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_informasi.dart';
import '../pages/halaman_laporan.dart';
import '../pages/halaman_profil.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() =>
      _KerangkaNavigasiState();
}

class _KerangkaNavigasiState
    extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanLaporan(),
    HalamanInformasi(),
    HalamanProfil(),
  ];

  final List<String> _judul = const [
    'Beranda',
    'Laporan',
    'Informasi',
    'Profil',
  ];

  void _pilihTujuan(int indeks) {
    if (indeks < 0 || indeks >= _halaman.length) return;

    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  void _bukaFormLaporan() {
    Navigator.pushNamed(
      context,
      AppRoutes.formLaporan,
    );
  }

  @override
  Widget build(BuildContext context) {
    final lebarLayar = MediaQuery.sizeOf(context).width;
    final layarLebar = lebarLayar >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(_judul[_indeksTerpilih]),
        centerTitle: true,
      ),

      drawer: _buatDrawer(),

      body: layarLebar
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: _indeksTerpilih,
                  onDestinationSelected: _pilihTujuan,
                  extended: true,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Beranda'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.report_outlined),
                      selectedIcon: Icon(Icons.report),
                      label: Text('Laporan'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.info_outline),
                      selectedIcon: Icon(Icons.info),
                      label: Text('Informasi'),
                    ),
                    NavigationRailDestination(
                      icon: BadgeFavorit(),
                      selectedIcon: BadgeFavorit(
                        terpilih: true,
                      ),
                      label: Text('Profil'),
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
          : IndexedStack(
              index: _indeksTerpilih,
              children: _halaman,
            ),

      // State lokal navigasi tetap menggunakan setState().
      floatingActionButton: _indeksTerpilih == 1
          ? FloatingActionButton.extended(
              onPressed: _bukaFormLaporan,
              icon: const Icon(Icons.add),
              label: const Text('Buat Laporan'),
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
                  label: 'Beranda',
                ),
                NavigationDestination(
                  icon: Icon(Icons.report_outlined),
                  selectedIcon: Icon(Icons.report),
                  label: 'Laporan',
                ),
                NavigationDestination(
                  icon: Icon(Icons.info_outline),
                  selectedIcon: Icon(Icons.info),
                  label: 'Informasi',
                ),
                NavigationDestination(
                  icon: BadgeFavorit(),
                  selectedIcon: BadgeFavorit(
                    terpilih: true,
                  ),
                  label: 'Profil',
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
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                child: Icon(Icons.shield),
              ),
              SizedBox(height: 12),
              Text(
                'Siaga Manado',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Sistem Informasi Kebencanaan'),
            ],
          ),
        ),

        const NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          label: Text('Beranda'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.report_outlined),
          label: Text('Laporan'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.info_outline),
          label: Text('Informasi'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.person_outline),
          label: Text('Profil'),
        ),

        const Divider(),

        ListTile(
          leading: const Icon(Icons.add_circle_outline),
          title: const Text('Buat Laporan Bencana'),
          onTap: () {
            Navigator.pop(context);
            _bukaFormLaporan();
          },
        ),

        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Pengaturan'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              AppRoutes.pengaturan,
            );
          },
        ),

        ListTile(
          leading: const Icon(Icons.help_outline),
          title: const Text('Tentang Aplikasi'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              AppRoutes.tentang,
            );
          },
        ),
      ],
    );
  }
}

// Badge dibangun ulang hanya jika total favorit berubah.
class BadgeFavorit extends StatelessWidget {
  final bool terpilih;

  const BadgeFavorit({
    super.key,
    this.terpilih = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoritCubit, Set<String>, int>(
      selector: (state) => state.length,
      builder: (context, total) {
        return Badge(
          isLabelVisible: total > 0,
          label: Text('$total'),
          child: Icon(
            terpilih
                ? Icons.person
                : Icons.person_outline,
          ),
        );
      },
    );
  }
}
