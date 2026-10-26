
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super(<String>{});

  // Daftar seluruh judul laporan favorit.
  Set<String> get daftarFavorit => state;

  // Jumlah laporan favorit.
  int get totalFavorit => state.length;

  // Mengecek status favorit.
  bool isFavorit(String judul) {
    return state.contains(judul);
  }

  // Menambahkan laporan favorit.
  void tambahFavorit(String judul) {
    if (state.contains(judul)) return;

    emit(
      Set.unmodifiable({
        ...state,
        judul,
      }),
    );
  }

  // Menghapus laporan favorit.
  void hapusFavorit(String judul) {
    if (!state.contains(judul)) return;

    final favoritBaru = Set<String>.from(state);
    favoritBaru.remove(judul);

    emit(Set.unmodifiable(favoritBaru));
  }

  // Mengubah status favorit.
  void ubahFavorit(String judul) {
    if (isFavorit(judul)) {
      hapusFavorit(judul);
    } else {
      tambahFavorit(judul);
    }
  }
}
