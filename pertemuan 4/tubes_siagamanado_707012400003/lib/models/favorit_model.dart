import 'package:flutter/foundation.dart';

class FavoritModel extends ChangeNotifier {
  final List<String> _daftarFavorit = [];

  List<String> get daftarFavorit {
    return List.unmodifiable(_daftarFavorit);
  }

  int get totalFavorit {
    return _daftarFavorit.length;
  }

  bool isFavorit(String namaLaporan) {
    return _daftarFavorit.contains(namaLaporan);
  }

  void tambahFavorit(String namaLaporan) {
    if (!_daftarFavorit.contains(namaLaporan)) {
      _daftarFavorit.add(namaLaporan);
      notifyListeners();
    }
  }

  void hapusFavorit(String namaLaporan) {
    if (_daftarFavorit.contains(namaLaporan)) {
      _daftarFavorit.remove(namaLaporan);
      notifyListeners();
    }
  }

  void ubahFavorit(String namaLaporan) {
    if (isFavorit(namaLaporan)) {
      hapusFavorit(namaLaporan);
    } else {
      tambahFavorit(namaLaporan);
    }
  }
}