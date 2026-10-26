import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_layanan.dart';
import '../pages/halaman_warga.dart';

class KerangkaNavigasi extends StatefulWidget {
  final int initialIndex;

  const KerangkaNavigasi({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<KerangkaNavigasi> createState() =>
      _KerangkaNavigasiState();
}

class _KerangkaNavigasiState
    extends State<KerangkaNavigasi> {
  late int _indeksTerpilih;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanWarga(),
  ];

  final List<String> _judul = const [
    'Nusantara Cerdas',
    'Daftar Layanan',
    'Layanan Warga',
  ];

  @override
  void initState() {
    super.initState();
    _indeksTerpilih = widget.initialIndex;
  }

  void _pilihTujuan(int indeks) {
    if (indeks < 0 || indeks >= _halaman.length) return;

    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final layarLebar = MediaQuery.sizeOf(context).width >= 600;

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
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Beranda'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.miscellaneous_services_outlined),
                      selectedIcon: Icon(Icons.miscellaneous_services),
                      label: Text('Layanan'),
                    ),
                    NavigationRailDestination(
                      icon: BadgePengajuan(),
                      selectedIcon: BadgePengajuan(
                        terpilih: true,
                      ),
                      label: Text('Warga'),
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
                  icon: Icon(Icons.miscellaneous_services_outlined),
                  selectedIcon: Icon(Icons.miscellaneous_services),
                  label: 'Layanan',
                ),
                NavigationDestination(
                  icon: BadgePengajuan(),
                  selectedIcon: BadgePengajuan(
                    terpilih: true,
                  ),
                  label: 'Warga',
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
      children: const [
        Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                child: Icon(Icons.account_balance),
              ),
              SizedBox(height: 12),
              Text(
                'Nusantara Cerdas Mobile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Layanan Digital Warga'),
            ],
          ),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          label: Text('Beranda'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.miscellaneous_services_outlined),
          label: Text('Layanan'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.people_outline),
          label: Text('Warga'),
        ),
      ],
    );
  }
}

// Widget badge terpisah supaya BlocSelector
// hanya membangun ulang bagian badge.
class BadgePengajuan extends StatelessWidget {
  final bool terpilih;

  const BadgePengajuan({
    super.key,
    this.terpilih = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
        PengajuanCubit,
        PengajuanState,
        int>(
      selector: (state) => state.totalPengajuan,
      builder: (context, total) {
        return Badge(
          isLabelVisible: total > 0,
          label: Text('$total'),
          child: Icon(
            terpilih ? Icons.people : Icons.people_outline,
          ),
        );
      },
    );
  }
}