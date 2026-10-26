import 'package:flutter_test/flutter_test.dart';

import '../lib/cubit/favorit_cubit.dart';
import '../lib/cubit/pengajuan_cubit.dart';

void main() {
  test('FavoritCubit menambah dan menghapus favorit', () {
    final cubit = FavoritCubit();

    cubit.tandai('Izin Usaha Mikro');

    expect(cubit.state.contains('Izin Usaha Mikro'), true);

    cubit.batalTandai('Izin Usaha Mikro');

    expect(cubit.state.isEmpty, true);

    cubit.close();
  });

  test('PengajuanCubit mengelola keranjang', () {
    final cubit = PengajuanCubit();

    cubit.tambahPengajuan('Izin Usaha Mikro');
    cubit.tambahPengajuan('Pemeriksaan Kesehatan');

    expect(cubit.state.totalPengajuan, 2);

    cubit.kirimSemuaPengajuan();

    expect(cubit.state.totalPengajuan, 0);
    expect(cubit.state.totalTerkirim, 2);

    cubit.close();
  });
}