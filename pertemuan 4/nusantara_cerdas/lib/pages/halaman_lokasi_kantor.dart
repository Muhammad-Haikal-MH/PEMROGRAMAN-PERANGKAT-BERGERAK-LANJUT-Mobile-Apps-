import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HalamanLokasiKantor extends StatelessWidget {
  const HalamanLokasiKantor({super.key});

  // Titik pusat peta: Jakarta.
  static const LatLng _pusatPeta = LatLng(-6.2088, 106.8456);

  // Tiga lokasi contoh kantor layanan.
  // Ganti koordinat dan nama ini dengan lokasi kantor sebenarnya.
  static final Set<Marker> _markersKantor = {
    Marker(
      markerId: MarkerId('kantor-pusat'),
      position: LatLng(-6.1754, 106.8272),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Pusat',
        snippet: 'Contoh kantor layanan utama',
      ),
    ),
    Marker(
      markerId: MarkerId('kantor-selatan'),
      position: LatLng(-6.2607, 106.7816),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Selatan',
        snippet: 'Contoh kantor layanan wilayah selatan',
      ),
    ),
    Marker(
      markerId: MarkerId('kantor-timur'),
      position: LatLng(-6.2250, 106.9004),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Timur',
        snippet: 'Contoh kantor layanan wilayah timur',
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // INFORMASI HALAMAN
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lokasi Kantor Layanan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                'Pilih penanda pada peta untuk melihat '
                'informasi kantor layanan.',
              ),
            ],
          ),
        ),

        // GOOGLE MAPS
        Expanded(
          child: GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _pusatPeta,
              zoom: 11.5,
            ),
            markers: _markersKantor,
            mapType: MapType.normal,
            compassEnabled: true,
            zoomControlsEnabled: true,
            mapToolbarEnabled: true,
            myLocationButtonEnabled: false,
          ),
        ),

        // PETUNJUK
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${_markersKantor.length} kantor layanan '
                    'ditampilkan pada peta.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
