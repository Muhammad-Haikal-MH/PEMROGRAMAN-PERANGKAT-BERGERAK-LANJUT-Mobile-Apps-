class Layanan {
  final String nama;
  final String bidang;
  final String deskripsi;

  const Layanan({
    required this.nama,
    required this.bidang,
    required this.deskripsi,
  });
}

class KatalogLayanan {
  static const List<String> bidang = [
    'Perizinan',
    'Kesehatan',
    'Transportasi',
  ];

  static const List<Layanan> semua = [
    Layanan(
      nama: 'Izin Usaha Mikro',
      bidang: 'Perizinan',
      deskripsi: 'Pengajuan izin usaha bagi pelaku usaha mikro.',
    ),
    Layanan(
      nama: 'Izin Mendirikan Bangunan',
      bidang: 'Perizinan',
      deskripsi: 'Informasi dan pengajuan perizinan bangunan.',
    ),
    Layanan(
      nama: 'Izin Kegiatan Masyarakat',
      bidang: 'Perizinan',
      deskripsi: 'Pengajuan izin penyelenggaraan kegiatan masyarakat.',
    ),
    Layanan(
      nama: 'Pemeriksaan Kesehatan',
      bidang: 'Kesehatan',
      deskripsi: 'Pendaftaran pemeriksaan kesehatan dasar.',
    ),
    Layanan(
      nama: 'Konsultasi Kesehatan',
      bidang: 'Kesehatan',
      deskripsi: 'Pendaftaran konsultasi dengan petugas kesehatan.',
    ),
    Layanan(
      nama: 'Imunisasi',
      bidang: 'Kesehatan',
      deskripsi: 'Informasi dan pendaftaran layanan imunisasi.',
    ),
    Layanan(
      nama: 'Kartu Transportasi',
      bidang: 'Transportasi',
      deskripsi: 'Pengajuan kartu akses transportasi publik.',
    ),
    Layanan(
      nama: 'Izin Trayek',
      bidang: 'Transportasi',
      deskripsi: 'Informasi pengajuan izin trayek kendaraan.',
    ),
    Layanan(
      nama: 'Pengaduan Transportasi',
      bidang: 'Transportasi',
      deskripsi: 'Pelaporan masalah pelayanan transportasi.',
    ),
  ];

  static List<Layanan> berdasarkanBidang(String namaBidang) {
    return semua
        .where((layanan) => layanan.bidang == namaBidang)
        .toList();
  }

  static Layanan? cari(String nama) {
    for (final layanan in semua) {
      if (layanan.nama == nama) {
        return layanan;
      }
    }
    return null;
  }
}