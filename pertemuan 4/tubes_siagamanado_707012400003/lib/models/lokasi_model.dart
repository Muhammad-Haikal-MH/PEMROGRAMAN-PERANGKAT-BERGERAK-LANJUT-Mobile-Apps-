
import 'package:flutter/foundation.dart';

class LokasiModel extends ChangeNotifier {
  // Koordinat Kota Manado sebagai posisi awal kamera peta.
  static const double latitudeAwal = 1.4748;
  static const double longitudeAwal = 124.8421;

  double? _latitude;
  double? _longitude;
  String? _namaLokasi;

  // Getter agar halaman lain dapat membaca lokasi pilihan.
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  String? get namaLokasi => _namaLokasi;

  // Mengecek apakah pengguna sudah memilih titik.
  bool get sudahMemilihLokasi =>
      _latitude != null && _longitude != null;

  // Digunakan sebagai pusat awal kamera Google Maps.
  double get pusatLatitude => _latitude ?? latitudeAwal;
  double get pusatLongitude => _longitude ?? longitudeAwal;

  // Menyimpan koordinat yang dipilih pengguna di peta.
  void pilihLokasi({
    required double latitude,
    required double longitude,
    String? namaLokasi,
  }) {
    _latitude = latitude;
    _longitude = longitude;
    _namaLokasi = namaLokasi;

    notifyListeners();
  }

  // Menghapus lokasi yang sudah dipilih.
  void hapusLokasi() {
    _latitude = null;
    _longitude = null;
    _namaLokasi = null;

    notifyListeners();
  }
}
