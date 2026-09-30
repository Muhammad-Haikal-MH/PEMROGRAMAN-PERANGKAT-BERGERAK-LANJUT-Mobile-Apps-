import 'package:flutter/material.dart';

class HalamanRiwayatLaporan extends StatelessWidget {
  const HalamanRiwayatLaporan({super.key});

  void _tampilkanPesan(
    BuildContext context,
    String pesan,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Laporan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.check_circle),
              title: Text('Lampu jalan rusak'),
              subtitle: Text('Laporan selesai ditangani'),
              trailing: Text('Selesai'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.pending),
              title: Text('Jalan berlubang'),
              subtitle: Text('Sedang diproses'),
              trailing: Text('Proses'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.check_circle),
              title: Text('Sampah menumpuk'),
              subtitle: Text('Laporan selesai ditangani'),
              trailing: Text('Selesai'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _tampilkanPesan(
            context,
            'Membuat laporan baru',
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                _tampilkanPesan(
                  context,
                  'Mencari laporan',
                );
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                _tampilkanPesan(
                  context,
                  'Filter laporan',
                );
              },
              icon: const Icon(Icons.filter_list),
            ),
            const SizedBox(width: 48),
            IconButton(
              onPressed: () {
                _tampilkanPesan(
                  context,
                  'Mengurutkan laporan',
                );
              },
              icon: const Icon(Icons.sort),
            ),
            IconButton(
              onPressed: () {
                _tampilkanPesan(
                  context,
                  'Menu lainnya',
                );
              },
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
      ),
    );
  }
}