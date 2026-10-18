import 'package:flutter/foundation.dart';

@immutable
class Pendaftar {
  const Pendaftar({
    required this.nama,
    required this.email,
    required this.sesi,
  });

  final String nama;
  final String email;
  final String sesi;
}

class PendaftarModel extends ChangeNotifier {
  final List<Pendaftar> _pendaftar = [];

  List<Pendaftar> get pendaftar => List.unmodifiable(_pendaftar);

  void tambah(Pendaftar pendaftar) {
    _pendaftar.add(pendaftar);
    notifyListeners();
  }

  int jumlahSesi(String sesi) =>
      _pendaftar.where((pendaftar) => pendaftar.sesi == sesi).length;
}
