import 'package:flutter/foundation.dart';

class Pengajuan {
  final String id;
  final String namaLengkap;
  final String email;
  final String bidangLayanan;
  final String sesiKunjungan;
  final DateTime waktuPengajuan;
  final bool selesaiDitindaklanjuti;

  const Pengajuan({
    required this.id,
    required this.namaLengkap,
    required this.email,
    required this.bidangLayanan,
    required this.sesiKunjungan,
    required this.waktuPengajuan,
    this.selesaiDitindaklanjuti = false,
  });

  // Membuat salinan pengajuan dengan perubahan tertentu.
  Pengajuan copyWith({bool? selesaiDitindaklanjuti}) {
    return Pengajuan(
      id: id,
      namaLengkap: namaLengkap,
      email: email,
      bidangLayanan: bidangLayanan,
      sesiKunjungan: sesiKunjungan,
      waktuPengajuan: waktuPengajuan,
      selesaiDitindaklanjuti:
          selesaiDitindaklanjuti ?? this.selesaiDitindaklanjuti,
    );
  }
}

class PengajuanModel extends ChangeNotifier {
  final List<Pengajuan> _daftarPengajuan = [];

  // Bidang layanan yang tersedia pada aplikasi.
  static const List<String> bidangLayanan = [
    'Administrasi Kependudukan',
    'Perizinan Usaha',
    'Layanan Kesehatan',
    'Bantuan Sosial',
  ];

  // Getter agar data dapat dibaca oleh halaman lain.
  List<Pengajuan> get daftarPengajuan => List.unmodifiable(_daftarPengajuan);

  int get jumlahPengajuan => _daftarPengajuan.length;

  // Menghitung jumlah pengajuan pada setiap bidang.
  Map<String, int> get statistikPerBidang {
    final Map<String, int> hasil = {
      for (final bidang in bidangLayanan) bidang: 0,
    };

    for (final pengajuan in _daftarPengajuan) {
      hasil[pengajuan.bidangLayanan] =
          (hasil[pengajuan.bidangLayanan] ?? 0) + 1;
    }

    return hasil;
  }

  // Simulasi pengiriman kemudian simpan data.
  Future<void> tambahPengajuan({
    required String namaLengkap,
    required String email,
    required String bidangLayanan,
    required String sesiKunjungan,
  }) async {
    // Simulasi proses pengiriman ke server.
    await Future<void>.delayed(const Duration(seconds: 2));

    final pengajuanBaru = Pengajuan(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      namaLengkap: namaLengkap.trim(),
      email: email.trim(),
      bidangLayanan: bidangLayanan,
      sesiKunjungan: sesiKunjungan,
      waktuPengajuan: DateTime.now(),
    );

    _daftarPengajuan.insert(0, pengajuanBaru);

    // Beri tahu semua halaman yang memakai model ini.
    notifyListeners();
  }

  // Menandai pengajuan selesai ditindaklanjuti.
  void tandaiSelesai(String id) {
    final indeks = _daftarPengajuan.indexWhere(
      (pengajuan) => pengajuan.id == id,
    );

    if (indeks == -1) return;

    if (_daftarPengajuan[indeks].selesaiDitindaklanjuti) {
      return;
    }

    _daftarPengajuan[indeks] = _daftarPengajuan[indeks].copyWith(
      selesaiDitindaklanjuti: true,
    );

    notifyListeners();
  }

  // Mengambil satu pengajuan berdasarkan ID.
  Pengajuan? cariPengajuan(String id) {
    for (final pengajuan in _daftarPengajuan) {
      if (pengajuan.id == id) {
        return pengajuan;
      }
    }

    return null;
  }
}
