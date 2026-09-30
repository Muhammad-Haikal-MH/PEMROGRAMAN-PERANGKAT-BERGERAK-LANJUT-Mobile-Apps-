import 'package:flutter/material.dart';

class HalamanInformasi extends StatelessWidget {
  const HalamanInformasi({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.flood),
                text: 'Banjir',
              ),
              Tab(
                icon: Icon(Icons.landslide),
                text: 'Longsor',
              ),
              Tab(
                icon: Icon(Icons.warning),
                text: 'Lainnya',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buatDaftar([
                  'Waspada genangan saat hujan deras.',
                  'Hindari melewati jalan yang tergenang.',
                  'Pantau informasi dari petugas terkait.',
                ]),
                _buatDaftar([
                  'Waspadai area dengan kemiringan tanah tinggi.',
                  'Hindari berada di bawah tebing ketika hujan.',
                  'Segera laporkan tanda-tanda pergerakan tanah.',
                ]),
                _buatDaftar([
                  'Laporkan pohon tumbang melalui layanan laporan.',
                  'Hindari kabel listrik yang jatuh.',
                  'Ikuti arahan petugas di lokasi bencana.',
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buatDaftar(List<String> informasi) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: informasi.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(informasi[index]),
          ),
        );
      },
    );
  }
}