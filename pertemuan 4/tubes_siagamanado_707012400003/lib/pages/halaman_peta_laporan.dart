
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../models/lokasi_model.dart';

class HalamanPetaLaporan extends StatelessWidget {
  const HalamanPetaLaporan({super.key});

  @override
  Widget build(BuildContext context) {
    final lokasi = context.watch<LokasiModel>();

    final LatLng? posisiTerpilih =
        lokasi.sudahMemilihLokasi
            ? LatLng(
                lokasi.latitude!,
                lokasi.longitude!,
              )
            : null;

    final Set<Marker> markers = {
      if (posisiTerpilih != null)
        Marker(
          markerId: const MarkerId('lokasi-kejadian'),
          position: posisiTerpilih,
          infoWindow: InfoWindow(
            title: lokasi.namaLokasi ?? 'Lokasi Kejadian',
            snippet: 'Titik laporan bencana',
          ),
        ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Lokasi Kejadian'),
      ),
      body: Column(
        children: [
          // PETUNJUK PENGGUNAAN PETA
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest,
            child: const Text(
              'Ketuk peta untuk menentukan lokasi kejadian. '
              'Pastikan titik yang dipilih sesuai dengan '
              'lokasi bencana yang dilaporkan.',
            ),
          ),

          // GOOGLE MAPS
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  lokasi.pusatLatitude,
                  lokasi.pusatLongitude,
                ),
                zoom: 13,
              ),
              mapType: MapType.normal,
              markers: markers,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,

              // Simpan koordinat saat peta diketuk.
              onTap: (LatLng posisi) {
                context.read<LokasiModel>().pilihLokasi(
                  latitude: posisi.latitude,
                  longitude: posisi.longitude,
                  namaLokasi: 'Titik kejadian terpilih',
                );
              },
            ),
          ),

          // INFORMASI KOORDINAT DAN TOMBOL AKSI
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (posisiTerpilih == null)
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.location_searching),
                      title: Text('Lokasi belum dipilih'),
                      subtitle: Text(
                        'Ketuk peta untuk memilih titik kejadian.',
                      ),
                    )
                  else
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      title: const Text(
                        'Koordinat terpilih',
                      ),
                      subtitle: Text(
                        'Latitude: '
                        '${posisiTerpilih.latitude.toStringAsFixed(6)}\n'
                        'Longitude: '
                        '${posisiTerpilih.longitude.toStringAsFixed(6)}',
                      ),
                      isThreeLine: true,
                    ),

                  const SizedBox(height: 8),

                  // KONFIRMASI LOKASI
                  ElevatedButton.icon(
                    onPressed: lokasi.sudahMemilihLokasi
                        ? () {
                            Navigator.pop(context);
                          }
                        : null,
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Gunakan Lokasi Ini'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                    ),
                  ),

                  // HAPUS TITIK TERPILIH
                  TextButton.icon(
                    onPressed: lokasi.sudahMemilihLokasi
                        ? () {
                            context
                                .read<LokasiModel>()
                                .hapusLokasi();
                          }
                        : null,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Hapus Pilihan Lokasi'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
