import 'package:flutter/foundation.dart';

class PesanChat {
  final String id;
  final String teks;
  final bool dariWarga;
  final DateTime waktu;

  const PesanChat({
    required this.id,
    required this.teks,
    required this.dariWarga,
    required this.waktu,
  });
}

class ChatModel extends ChangeNotifier {
  final List<PesanChat> _daftarPesan = [
    PesanChat(
      id: 'pesan-awal',
      teks:
          'Halo! Selamat datang di layanan Tanya Petugas. '
          'Ada yang bisa kami bantu?',
      dariWarga: false,
      waktu: DateTime.now(),
    ),
  ];

  // Halaman chat membaca daftar pesan melalui getter.
  List<PesanChat> get daftarPesan => List.unmodifiable(_daftarPesan);

  int get jumlahPesan => _daftarPesan.length;

  // Mengirim pesan dari warga dan mensimulasikan balasan petugas.
  Future<void> kirimPesan(String teks) async {
    final pesan = teks.trim();

    if (pesan.isEmpty) return;

    // Tambahkan pesan warga.
    _daftarPesan.add(
      PesanChat(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        teks: pesan,
        dariWarga: true,
        waktu: DateTime.now(),
      ),
    );

    notifyListeners();

    // Simulasi waktu respons petugas.
    await Future<void>.delayed(const Duration(milliseconds: 900));

    // Balasan ini masih simulasi, bukan petugas sungguhan.
    _daftarPesan.add(
      PesanChat(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        teks:
            'Terima kasih atas pesan Anda. '
            'Pesan telah diterima dan akan ditindaklanjuti '
            'oleh petugas.',
        dariWarga: false,
        waktu: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  // Menghapus seluruh percakapan dan mengembalikan pesan awal.
  void resetPercakapan() {
    _daftarPesan
      ..clear()
      ..add(
        PesanChat(
          id: 'pesan-awal-${DateTime.now().microsecondsSinceEpoch}',
          teks:
              'Halo! Selamat datang di layanan Tanya Petugas. '
              'Ada yang bisa kami bantu?',
          dariWarga: false,
          waktu: DateTime.now(),
        ),
      );

    notifyListeners();
  }
}
