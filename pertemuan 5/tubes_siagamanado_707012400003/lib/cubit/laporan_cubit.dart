import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/laporan_model.dart';

class LaporanCubit extends Cubit<List<LaporanBencana>> {
  LaporanCubit() : super(const <LaporanBencana>[]);

  void tambahLaporan({
    required String judul,
    required String jenisBencana,
    required String deskripsi,
    required double latitude,
    required double longitude,
  }) {
    final laporanBaru = LaporanBencana(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      judul: judul.trim(),
      jenisBencana: jenisBencana,
      deskripsi: deskripsi.trim(),
      tanggalLaporan: DateTime.now(),
      latitude: latitude,
      longitude: longitude,
    );

    emit(List<LaporanBencana>.unmodifiable([laporanBaru, ...state]));
  }
}
