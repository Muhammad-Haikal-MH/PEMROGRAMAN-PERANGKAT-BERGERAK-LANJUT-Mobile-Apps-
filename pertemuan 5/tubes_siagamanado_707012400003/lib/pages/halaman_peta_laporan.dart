
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HalamanPetaLaporan extends StatefulWidget {
  const HalamanPetaLaporan({super.key});

  @override
  State<HalamanPetaLaporan> createState() =>
      _HalamanPetaLaporanState();
}

class _HalamanPetaLaporanState
    extends State<HalamanPetaLaporan> {
  // Posisi awal Google Maps: Kota Manado.
  static const LatLng _pusatManado = LatLng(
    1.4748,
    124.8421,
  );

  // STATE LOKAL: titik yang dipilih pengguna.
  LatLng? _posisiTerpilih;

  void _pilihTitik(LatLng posisi) {
    setState(() {
      _posisiTerpilih = posisi;
    });
  }

  void _gunakanLokasi() {
    if (_posisiTerpilih == null) return;

    // Kembalikan koordinat ke halaman Form.
    Navigator.pop(
      context,
      _posisiTerpilih,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = {
      if (_posisiTerpilih != null)
        Marker(
          markerId: const MarkerId(
            'lokasi-kejadian',
          ),
          position: _posisiTerpilih!,
          infoWindow: const InfoWindow(
            title: 'Lokasi Kejadian',
            snippet: 'Titik laporan bencana',
          ),
        ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pilih Lokasi Kejadian',
        ),
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest,
            child: const Text(
              'Ketuk peta untuk menentukan lokasi '
              'terjadinya bencana.',
            ),
          ),

          // PETA GOOGLE MAPS
          Expanded(
            child: GoogleMap(
              initialCameraPosition:
                  const CameraPosition(
                target: _pusatManado,
                zoom: 13,
              ),

              markers: markers,
              mapType: MapType.normal,
              zoomControlsEnabled: true,
              myLocationButtonEnabled: false,

              onTap: _pilihTitik,
            ),
          ),

          // INFORMASI KOORDINAT
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [
                  if (_posisiTerpilih == null)
                    const ListTile(
                      leading: Icon(
                        Icons.location_searching,
                      ),
                      title: Text(
                        'Belum ada lokasi dipilih',
                      ),
                      subtitle: Text(
                        'Ketuk peta untuk memilih lokasi.',
                      ),
                    )
                  else
                    ListTile(
                      leading: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      title: const Text(
                        'Koordinat terpilih',
                      ),
                      subtitle: Text(
                        'Latitude: '
                        '${_posisiTerpilih!.latitude.toStringAsFixed(6)}\n'
                        'Longitude: '
                        '${_posisiTerpilih!.longitude.toStringAsFixed(6)}',
                      ),
                      isThreeLine: true,
                    ),

                  const SizedBox(height: 12),

                  ElevatedButton.icon(
                    onPressed:
                        _posisiTerpilih == null
                            ? null
                            : _gunakanLokasi,
                    icon: const Icon(
                      Icons.check_circle_outline,
                    ),
                    label: const Text(
                      'Gunakan Lokasi Ini',
                    ),
                  ),

                  TextButton.icon(
                    onPressed: _posisiTerpilih == null
                        ? null
                        : () {
                            setState(() {
                              _posisiTerpilih = null;
                            });
                          },
                    icon: const Icon(
                      Icons.delete_outline,
                    ),
                    label: const Text(
                      'Hapus Pilihan Lokasi',
                    ),
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
