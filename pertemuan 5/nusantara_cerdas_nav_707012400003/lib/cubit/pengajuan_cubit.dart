import 'package:flutter_bloc/flutter_bloc.dart';

class PengajuanState {
  final List<String> keranjang;
  final List<String> riwayatPengajuan;

  PengajuanState({
    required List<String> keranjang,
    required List<String> riwayatPengajuan,
  })  : keranjang = List.unmodifiable(keranjang),
        riwayatPengajuan =
            List.unmodifiable(riwayatPengajuan);

  int get totalPengajuan => keranjang.length;

  int get totalTerkirim => riwayatPengajuan.length;

  bool sudahDiKeranjang(String namaLayanan) {
    return keranjang.contains(namaLayanan);
  }
}

class PengajuanCubit extends Cubit<PengajuanState> {
  PengajuanCubit()
      : super(
          PengajuanState(
            keranjang: [],
            riwayatPengajuan: [],
          ),
        );

  void tambahPengajuan(String namaLayanan) {
    final nama = namaLayanan.trim();

    if (nama.isEmpty || state.sudahDiKeranjang(nama)) {
      return;
    }

    emit(
      PengajuanState(
        keranjang: [...state.keranjang, nama],
        riwayatPengajuan: state.riwayatPengajuan,
      ),
    );
  }

  void hapusPengajuan(String namaLayanan) {
    if (!state.sudahDiKeranjang(namaLayanan)) return;

    emit(
      PengajuanState(
        keranjang: state.keranjang
            .where((nama) => nama != namaLayanan)
            .toList(),
        riwayatPengajuan: state.riwayatPengajuan,
      ),
    );
  }

  void kirimSemuaPengajuan() {
    if (state.keranjang.isEmpty) return;

    emit(
      PengajuanState(
        keranjang: [],
        riwayatPengajuan: [
          ...state.riwayatPengajuan,
          ...state.keranjang,
        ],
      ),
    );
  }

  void kosongkanKeranjang() {
    if (state.keranjang.isEmpty) return;

    emit(
      PengajuanState(
        keranjang: [],
        riwayatPengajuan: state.riwayatPengajuan,
      ),
    );
  }
}