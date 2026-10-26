import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super(<String>{});

  bool isFavorit(String namaLayanan) {
    return state.contains(namaLayanan);
  }

  void tandai(String namaLayanan) {
    if (namaLayanan.trim().isEmpty ||
        state.contains(namaLayanan)) {
      return;
    }

    final favoritBaru = Set<String>.from(state);
    favoritBaru.add(namaLayanan);

    emit(favoritBaru);
  }

  void batalTandai(String namaLayanan) {
    if (!state.contains(namaLayanan)) return;

    final favoritBaru = Set<String>.from(state);
    favoritBaru.remove(namaLayanan);

    emit(favoritBaru);
  }

  void ubahFavorit(String namaLayanan) {
    if (isFavorit(namaLayanan)) {
      batalTandai(namaLayanan);
    } else {
      tandai(namaLayanan);
    }
  }
}