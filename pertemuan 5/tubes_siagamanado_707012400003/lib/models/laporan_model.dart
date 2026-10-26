
class LaporanBencana {
  final String id;
  final String judul;
  final String jenisBencana;
  final String deskripsi;
  final DateTime tanggalLaporan;
  final double? latitude;
  final double? longitude;

  const LaporanBencana({
    required this.id,
    required this.judul,
    required this.jenisBencana,
    required this.deskripsi,
    required this.tanggalLaporan,
    this.latitude,
    this.longitude,
  });
}
