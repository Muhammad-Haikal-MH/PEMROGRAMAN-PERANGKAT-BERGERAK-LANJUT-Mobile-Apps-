import 'package:flutter/foundation.dart';

class FavoritModel extends ChangeNotifier {
  final Set<String> _layananFavorit = {};

  Set<String> get layananFavorit {
    return Set.unmodifiable(_layananFavorit);
  }

  bool isFavorit(String namaLayanan) {
    return _layananFavorit.contains(namaLayanan);
  }

  void tandai(String namaLayanan) {
    if (_layananFavorit.add(namaLayanan)) {
      notifyListeners();
    }
  }

  void batalTandai(String namaLayanan) {
    if (_layananFavorit.remove(namaLayanan)) {
      notifyListeners();
    }
  }
}