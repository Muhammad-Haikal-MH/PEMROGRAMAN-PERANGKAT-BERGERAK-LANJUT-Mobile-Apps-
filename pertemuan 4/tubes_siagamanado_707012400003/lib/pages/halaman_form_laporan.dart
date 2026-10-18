
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/laporan_model.dart';
import '../models/lokasi_model.dart';
import '../navigation/app_routes.dart';

class HalamanFormLaporan extends StatefulWidget {
  const HalamanFormLaporan({super.key});

  @override
  State<HalamanFormLaporan> createState() =>
      _HalamanFormLaporanState();
}

class _HalamanFormLaporanState
    extends State<HalamanFormLaporan> {
  final _formKey = GlobalKey<FormState>();

  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();

  String? _jenisBencana;
  bool _konfirmasiKebenaran = false;
  bool _sedangMengirim = false;

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  Future<void> _pilihLokasi() async {
    await Navigator.pushNamed(
      context,
      AppRoutes.petaLaporan,
    );
  }

  void _kirimLaporan() {
    // 1. Validasi judul dan deskripsi.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // 2. Validasi pilihan jenis bencana.
    if (_jenisBencana == null) {
      _tampilkanPesan(
        'Silakan pilih jenis bencana.',
      );
      return;
    }

    // 3. Validasi konfirmasi pengguna.
    if (!_konfirmasiKebenaran) {
      _tampilkanPesan(
        'Centang konfirmasi kebenaran laporan.',
      );
      return;
    }

    // 4. Pastikan lokasi kejadian sudah dipilih.
    final lokasi = context.read<LokasiModel>();

    if (!lokasi.sudahMemilihLokasi) {
      _tampilkanPesan(
        'Silakan tentukan lokasi kejadian pada peta.',
      );
      return;
    }

    setState(() {
      _sedangMengirim = true;
    });

    try {
      // 5. Simpan laporan melalui Provider.
      context.read<LaporanModel>().tambahLaporan(
        judul: _judulController.text,
        jenisBencana: _jenisBencana!,
        deskripsi: _deskripsiController.text,
        latitude: lokasi.latitude,
        longitude: lokasi.longitude,
      );

      // 6. Bersihkan input setelah berhasil.
      _judulController.clear();
      _deskripsiController.clear();

      setState(() {
        _jenisBencana = null;
        _konfirmasiKebenaran = false;
      });

      // 7. Hapus titik terpilih agar tidak salah
      // digunakan untuk laporan berikutnya.
      lokasi.hapusLokasi();

      _tampilkanPesan(
        'Laporan berhasil ditambahkan!',
      );

      // Kembali ke halaman sebelumnya setelah berhasil.
      Navigator.pop(context);
    } catch (e) {
      _tampilkanPesan(
        'Gagal menyimpan laporan: $e',
      );
    } finally {
      if (mounted) {
        setState(() {
          _sedangMengirim = false;
        });
      }
    }
  }

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(pesan)),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Laporan Bencana'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Informasi Kejadian',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Isi informasi berikut sesuai kondisi '
              'yang kamu ketahui.',
            ),

            const SizedBox(height: 24),

            // INPUT JUDUL LAPORAN
            TextFormField(
              controller: _judulController,
              textCapitalization:
                  TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Judul laporan',
                hintText: 'Contoh: Banjir di kawasan permukiman',
                prefixIcon: Icon(Icons.edit_note),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Judul laporan wajib diisi.';
                }

                if (value.trim().length < 5) {
                  return 'Judul minimal 5 karakter.';
                }

                return null;
              },
            ),

            const SizedBox(height: 24),

            // RADIO BUTTON JENIS BENCANA
            RadioGroup<String>(
              groupValue: _jenisBencana,
              onChanged: (String? value) {
                setState(() {
                  _jenisBencana = value;
                });
              },
              child: Column(
                children: [
                  for (final jenis in const [
                    'Banjir',
                    'Tanah Longsor',
                    'Kebakaran',
                    'Gempa Bumi',
                    'Angin Kencang',
                    'Lainnya',
                  ])
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(jenis),
                      value: jenis,
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // INPUT DESKRIPSI
            TextFormField(
              controller: _deskripsiController,
              minLines: 3,
              maxLines: 5,
              textCapitalization:
                  TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Deskripsi kejadian',
                hintText:
                    'Jelaskan kondisi, waktu, dan dampak kejadian...',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.description_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Deskripsi kejadian wajib diisi.';
                }

                if (value.trim().length < 10) {
                  return 'Deskripsi minimal 10 karakter.';
                }

                return null;
              },
            ),

            const SizedBox(height: 24),

            // LOKASI DARI LOKASIMODEL
            const Text(
              'Lokasi Kejadian',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Consumer<LokasiModel>(
              builder: (context, lokasi, child) {
                if (!lokasi.sudahMemilihLokasi) {
                  return const Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.location_off_outlined,
                      ),
                      title: Text(
                        'Lokasi belum dipilih',
                      ),
                      subtitle: Text(
                        'Tentukan titik kejadian melalui peta.',
                      ),
                    ),
                  );
                }

                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    title: Text(
                      lokasi.namaLokasi ??
                          'Lokasi kejadian terpilih',
                    ),
                    subtitle: Text(
                      'Lat: ${lokasi.latitude!.toStringAsFixed(6)}\n'
                      'Lng: ${lokasi.longitude!.toStringAsFixed(6)}',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      tooltip: 'Hapus lokasi',
                      onPressed: () {
                        context
                            .read<LokasiModel>()
                            .hapusLokasi();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: _pilihLokasi,
              icon: const Icon(Icons.map_outlined),
              label: const Text('Pilih Lokasi pada Peta'),
            ),

            const SizedBox(height: 16),

            // CHECKBOX KONFIRMASI
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity:
                  ListTileControlAffinity.leading,
              value: _konfirmasiKebenaran,
              title: const Text(
                'Saya menyatakan informasi ini benar '
                'sesuai kondisi yang saya ketahui.',
              ),
              onChanged: (value) {
                setState(() {
                  _konfirmasiKebenaran = value ?? false;
                });
              },
            ),

            const SizedBox(height: 24),

            // TOMBOL KIRIM LAPORAN
            ElevatedButton.icon(
              onPressed: _sedangMengirim
                  ? null
                  : _kirimLaporan,
              icon: _sedangMengirim
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.send),
              label: Text(
                _sedangMengirim
                    ? 'Mengirim laporan...'
                    : 'Kirim Laporan',
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
