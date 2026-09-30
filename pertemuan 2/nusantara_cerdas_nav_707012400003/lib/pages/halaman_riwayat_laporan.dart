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
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.report),
              ),
              title: const Text(
                'Jalan Rusak',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Laporan sedang diproses',
              ),
              trailing: const Icon(
                Icons.pending_actions,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.report),
              ),
              title: const Text(
                'Lampu Jalan Mati',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Laporan telah selesai ditangani',
              ),
              trailing: const Icon(
                Icons.check_circle_outline,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.report),
              ),
              title: const Text(
                'Sampah Menumpuk',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Menunggu penanganan petugas',
              ),
              trailing: const Icon(
                Icons.schedule,
              ),
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
          children: [
            IconButton(
              onPressed: () {
                _tampilkanPesan(
                  context,
                  'Mencari laporan',
                );
              },
              tooltip: 'Cari',
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                _tampilkanPesan(
                  context,
                  'Memfilter laporan',
                );
              },
              tooltip: 'Filter',
              icon: const Icon(Icons.filter_list),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                _tampilkanPesan(
                  context,
                  'Mengurutkan laporan',
                );
              },
              tooltip: 'Urutkan',
              icon: const Icon(Icons.sort),
            ),
            IconButton(
              onPressed: () {
                _tampilkanPesan(
                  context,
                  'Menu lainnya',
                );
              },
              tooltip: 'Lainnya',
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}