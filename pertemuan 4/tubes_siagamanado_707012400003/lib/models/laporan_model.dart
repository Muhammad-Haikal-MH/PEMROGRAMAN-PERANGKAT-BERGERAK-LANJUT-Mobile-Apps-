
import 'package:flutter/foundation.dart';

class LaporanBencana {
  final String id;
  final String judul;
  final String jenisBencana;
  final String deskripsi;
  final DateTime tanggalLaporan;
  final double? latitude;
  final double? longitude;

  const LaporanBencana({
    required this.id,
    required this.judul,
    required this.jenisBencana,
    required this.deskripsi,
    required this.tanggalLaporan,
    this.latitude,
    this.longitude,
  });
}

class LaporanModel extends ChangeNotifier {
  final List<LaporanBencana> _daftarLaporan = [];

  // Daftar laporan yang dapat dibaca halaman lain.
  List<LaporanBencana> get daftarLaporan =>
      List.unmodifiable(_daftarLaporan);

  // Jumlah laporan untuk ditampilkan di Beranda atau Profil.
  int get jumlahLaporan => _daftarLaporan.length;

  // Menambahkan laporan baru ke daftar.
  void tambahLaporan({
    required String judul,
    required String jenisBencana,
    required String deskripsi,
    double? latitude,
    double? longitude,
  }) {
    final laporanBaru = LaporanBencana(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      judul: judul.trim(),
      jenisBencana: jenisBencana,
      deskripsi: deskripsi.trim(),
      tanggalLaporan: DateTime.now(),
      latitude: latitude,
      longitude: longitude,
    );

    _daftarLaporan.insert(0, laporanBaru);

    // Memberi tahu semua halaman yang mendengarkan model ini.
    notifyListeners();
  }

  // Menghapus laporan berdasarkan ID.
  void hapusLaporan(String id) {
    final jumlahSebelum = _daftarLaporan.length;

    _daftarLaporan.removeWhere(
      (laporan) => laporan.id == id,
    );

    if (_daftarLaporan.length != jumlahSebelum) {
      notifyListeners();
    }
  }
}
