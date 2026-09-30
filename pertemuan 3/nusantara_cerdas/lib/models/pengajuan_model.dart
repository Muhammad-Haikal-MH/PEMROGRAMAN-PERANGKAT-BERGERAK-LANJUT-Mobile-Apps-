import 'package:flutter/foundation.dart';

class PengajuanModel extends ChangeNotifier {
  final List<String> _layananDiajukan = [];

  List<String> get layananDiajukan {
    return List.unmodifiable(_layananDiajukan);
  }

  int get totalPengajuan {
    return _layananDiajukan.length;
  }

  void tambahPengajuan(String namaLayanan) {
    _layananDiajukan.add(namaLayanan);
    notifyListeners();
  }
}