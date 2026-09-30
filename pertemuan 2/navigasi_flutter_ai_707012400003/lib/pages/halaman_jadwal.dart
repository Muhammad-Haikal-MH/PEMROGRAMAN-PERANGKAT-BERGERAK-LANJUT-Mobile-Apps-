import 'package:flutter/material.dart';

class HalamanJadwal extends StatelessWidget {
  const HalamanJadwal({super.key});

  Widget _buatDaftarJadwal(
    BuildContext context,
    List<String> daftarJadwal,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: daftarJadwal.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemBuilder: (context, index) {
        final String jadwal = daftarJadwal[index];

        return Card(
          child: ListTile(
            leading: const Icon(Icons.book),
            title: Text(jadwal),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: <String, String>{
                  'judul': jadwal,
                  'keterangan': 'Detail jadwal mata kuliah $jadwal.',
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.today),
                text: 'Senin',
              ),
              Tab(
                icon: Icon(Icons.event),
                text: 'Rabu',
              ),
              Tab(
                icon: Icon(Icons.event_available),
                text: 'Jumat',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buatDaftarJadwal(
                  context,
                  [
                    'Basis Data 07.00',
                    'Matematika Diskrit 10.00',
                  ],
                ),
                _buatDaftarJadwal(
                  context,
                  [
                    'PPB Lanjut 08.00',
                    'Jaringan 13.00',
                  ],
                ),
                _buatDaftarJadwal(
                  context,
                  [
                    'Kecerdasan Artifisial 09.00',
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}