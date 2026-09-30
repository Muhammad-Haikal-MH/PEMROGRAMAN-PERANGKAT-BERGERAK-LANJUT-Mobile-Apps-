import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pengajuan_model.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_layanan.dart';
import '../pages/halaman_warga.dart';
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
    HalamanLayanan(),
    HalamanWarga(),
  ];

  final List<String> _judul = const [
    'Beranda',
    'Layanan',
    'Warga',
  ];

  void _pilihTujuan(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final layarLebar = lebar >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _judul[_indeksTerpilih],
        ),
        centerTitle: true,
      ),
      drawer: _buatDrawer(),
      body: layarLebar
          ? _tataLetakLebar()
          : _halaman[_indeksTerpilih],
      bottomNavigationBar:
          layarLebar ? null : _buatBilahBawah(),
    );
  }

  Widget _buatBilahBawah() {
    return NavigationBar(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: _pilihTujuan,
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        const NavigationDestination(
          icon: Icon(Icons.miscellaneous_services_outlined),
          selectedIcon:
              Icon(Icons.miscellaneous_services),
          label: 'Layanan',
        ),
        NavigationDestination(
          icon: _buatIkonWarga(),
          selectedIcon: _buatIkonWarga(
            terpilih: true,
          ),
          label: 'Warga',
        ),
      ],
    );
  }

  Widget _tataLetakLebar() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _indeksTerpilih,
          onDestinationSelected: _pilihTujuan,
          extended: true,
          destinations: [
            const NavigationRailDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: Text('Beranda'),
            ),
            const NavigationRailDestination(
              icon: Icon(
                Icons.miscellaneous_services_outlined,
              ),
              selectedIcon: Icon(
                Icons.miscellaneous_services,
              ),
              label: Text('Layanan'),
            ),
            NavigationRailDestination(
              icon: _buatIkonWarga(),
              selectedIcon: _buatIkonWarga(
                terpilih: true,
              ),
              label: const Text('Warga'),
            ),
          ],
        ),
        const VerticalDivider(
          width: 1,
        ),
        Expanded(
          child: _halaman[_indeksTerpilih],
        ),
      ],
    );
  }

  Widget _buatIkonWarga({
    bool terpilih = false,
  }) {
    final totalPengajuan =
        context.select<PengajuanModel, int>(
      (model) => model.totalPengajuan,
    );

    return Badge(
      isLabelVisible: totalPengajuan > 0,
      label: Text(
        '$totalPengajuan',
      ),
      child: Icon(
        terpilih
            ? Icons.person
            : Icons.person_outline,
      ),
    );
  }

  Widget _buatDrawer() {
    return NavigationDrawer(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: (indeks) {
        if (indeks >= 0 && indeks <= 2) {
          _pilihTujuan(indeks);
          Navigator.pop(context);
        }
      },
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(
            28,
            24,
            16,
            12,
          ),
          child: Text(
            'Nusantara Cerdas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Beranda'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(
            Icons.miscellaneous_services_outlined,
          ),
          selectedIcon: Icon(
            Icons.miscellaneous_services,
          ),
          label: Text('Layanan'),
        ),
        NavigationDrawerDestination(
          icon: _buatIkonWarga(),
          selectedIcon: _buatIkonWarga(
            terpilih: true,
          ),
          label: const Text('Warga'),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Divider(),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text(
            'Pengaturan Kota',
          ),
          onTap: () {
            Navigator.pop(context);

            Navigator.pushNamed(
              context,
              AppRoutes.pengaturanKota,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text(
            'Tentang Aplikasi',
          ),
          onTap: () {
            Navigator.pop(context);

            Navigator.pushNamed(
              context,
              AppRoutes.tentangAplikasi,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text(
            'Riwayat Laporan',
          ),
          onTap: () {
            Navigator.pop(context);

            Navigator.pushNamed(
              context,
              AppRoutes.riwayatLaporan,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text(
            'Keluar',
          ),
          onTap: () {
            Navigator.pop(context);

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'Keluar',
                  ),
                  content: const Text(
                    'Apakah Anda ingin keluar dari aplikasi?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Batal',
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context);

                        ScaffoldMessenger.of(
                          this.context,
                        ).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Simulasi keluar dari aplikasi.',
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Keluar',
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}