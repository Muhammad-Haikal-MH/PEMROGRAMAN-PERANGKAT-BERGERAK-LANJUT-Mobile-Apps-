
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../cubit/laporan_cubit.dart';
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

  // STATE LOKAL MODUL 5
  bool _sedangMengirim = false;
  LatLng? _lokasiTerpilih;

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(pesan)),
      );
  }

  // Membuka Google Maps dan menerima koordinat.
  Future<void> _pilihLokasi() async {
    final hasil = await Navigator.pushNamed<LatLng>(
      context,
      AppRoutes.petaLaporan,
    );

    if (!mounted) return;

    if (hasil != null) {
      setState(() {
        _lokasiTerpilih = hasil;
      });
    }
  }

  // Simulasi pengiriman, kemudian simpan ke Cubit.
  Future<void> _kirimLaporan() async {
    if (_sedangMengirim) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_jenisBencana == null) {
      _tampilkanPesan('Pilih jenis bencana.');
      return;
    }

    if (!_konfirmasiKebenaran) {
      _tampilkanPesan(
        'Centang konfirmasi kebenaran laporan.',
      );
      return;
    }

    if (_lokasiTerpilih == null) {
      _tampilkanPesan(
        'Tentukan lokasi kejadian terlebih dahulu.',
      );
      return;
    }

    // LOADING LOKAL MENGGUNAKAN SETSTATE
    setState(() {
      _sedangMengirim = true;
    });

    try {
      // Simulasi proses pengiriman.
      await Future<void>.delayed(
        const Duration(seconds: 2),
      );

      if (!mounted) return;

      // STATE BERSAMA MENGGUNAKAN CUBIT
      context.read<LaporanCubit>().tambahLaporan(
        judul: _judulController.text,
        jenisBencana: _jenisBencana!,
        deskripsi: _deskripsiController.text,
        latitude: _lokasiTerpilih!.latitude,
        longitude: _lokasiTerpilih!.longitude,
      );

      setState(() {
        _sedangMengirim = false;
      });

      // Kembali ke halaman Laporan dengan hasil.
      Navigator.pop(
        context,
        'Laporan berhasil ditambahkan.',
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _sedangMengirim = false;
      });

      _tampilkanPesan(
        'Gagal menambahkan laporan: $e',
      );
    }
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
            Text(
              'Informasi Kejadian',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Lengkapi informasi kejadian bencana '
              'sesuai kondisi yang diketahui.',
            ),

            const SizedBox(height: 24),

            // JUDUL LAPORAN
            TextFormField(
              controller: _judulController,
              enabled: !_sedangMengirim,
              decoration: const InputDecoration(
                labelText: 'Judul laporan',
                hintText: 'Contoh: Banjir di permukiman',
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

            // JENIS BENCANA
            const Text(
              'Jenis Bencana',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            RadioGroup<String>(
              groupValue: _jenisBencana,
              onChanged: (value) {
                if (_sedangMengirim) return;

                setState(() {
                  _jenisBencana = value;
                });
              },
              child: const Column(
                children: [
                  RadioListTile<String>(
                    title: Text('Banjir'),
                    value: 'Banjir',
                  ),
                  RadioListTile<String>(
                    title: Text('Tanah Longsor'),
                    value: 'Tanah Longsor',
                  ),
                  RadioListTile<String>(
                    title: Text('Kebakaran'),
                    value: 'Kebakaran',
                  ),
                  RadioListTile<String>(
                    title: Text('Gempa Bumi'),
                    value: 'Gempa Bumi',
                  ),
                  RadioListTile<String>(
                    title: Text('Angin Kencang'),
                    value: 'Angin Kencang',
                  ),
                  RadioListTile<String>(
                    title: Text('Lainnya'),
                    value: 'Lainnya',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // DESKRIPSI KEJADIAN
            TextFormField(
              controller: _deskripsiController,
              enabled: !_sedangMengirim,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Deskripsi kejadian',
                hintText:
                    'Jelaskan kondisi dan dampak kejadian...',
                alignLabelWithHint: true,
                prefixIcon: Icon(
                  Icons.description_outlined,
                ),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Deskripsi wajib diisi.';
                }

                if (value.trim().length < 10) {
                  return 'Deskripsi minimal 10 karakter.';
                }

                return null;
              },
            ),

            const SizedBox(height: 24),

            // KOORDINAT LOKASI
            const Text(
              'Lokasi Kejadian',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Card(
              child: ListTile(
                leading: Icon(
                  _lokasiTerpilih == null
                      ? Icons.location_off_outlined
                      : Icons.location_on,
                  color: _lokasiTerpilih == null
                      ? null
                      : Colors.red,
                ),

                title: Text(
                  _lokasiTerpilih == null
                      ? 'Lokasi belum dipilih'
                      : 'Lokasi kejadian dipilih',
                ),

                subtitle: Text(
                  _lokasiTerpilih == null
                      ? 'Pilih titik kejadian pada peta.'
                      : 'Lat: ${_lokasiTerpilih!.latitude.toStringAsFixed(6)}\n'
                        'Lng: ${_lokasiTerpilih!.longitude.toStringAsFixed(6)}',
                ),

                isThreeLine: _lokasiTerpilih != null,

                trailing: _lokasiTerpilih != null
                    ? IconButton(
                        tooltip: 'Hapus lokasi',
                        icon: const Icon(Icons.close),
                        onPressed: _sedangMengirim
                            ? null
                            : () {
                                setState(() {
                                  _lokasiTerpilih = null;
                                });
                              },
                      )
                    : null,
              ),
            ),

            const SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: _sedangMengirim
                  ? null
                  : _pilihLokasi,
              icon: const Icon(Icons.map_outlined),
              label: const Text(
                'Pilih Lokasi pada Peta',
              ),
            ),

            const SizedBox(height: 16),

            // CHECKBOX
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity:
                  ListTileControlAffinity.leading,
              value: _konfirmasiKebenaran,
              title: const Text(
                'Saya menyatakan informasi yang '
                'dilaporkan sesuai kondisi yang diketahui.',
              ),
              onChanged: _sedangMengirim
                  ? null
                  : (value) {
                      setState(() {
                        _konfirmasiKebenaran =
                            value ?? false;
                      });
                    },
            ),

            const SizedBox(height: 24),

            // TOMBOL LOADING MENGGUNAKAN SETSTATE
            ElevatedButton.icon(
              onPressed: _sedangMengirim
                  ? null
                  : _kirimLaporan,

              icon: _sedangMengirim
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.send),

              label: Text(
                _sedangMengirim
                    ? 'Sedang Mengirim...'
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
