import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';

class HalamanRincianLayanan extends StatefulWidget {
  const HalamanRincianLayanan({super.key});

  @override
  State<HalamanRincianLayanan> createState() => _HalamanRincianLayananState();
}

class _HalamanRincianLayananState extends State<HalamanRincianLayanan> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _emailController = TextEditingController();

  String? _bidangLayanan;
  String? _sesiKunjungan;

  bool _persetujuanDataPribadi = false;
  bool _sedangMengirim = false;

  // Semua syarat harus terpenuhi agar tombol aktif.
  bool get _siapKirim {
    return _namaController.text.trim().isNotEmpty &&
        _emailController.text.trim().contains('@') &&
        _bidangLayanan != null &&
        _sesiKunjungan != null &&
        _persetujuanDataPribadi &&
        !_sedangMengirim;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _kirimPengajuan() async {
    // Validasi seluruh field Form sebelum menyimpan.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_siapKirim) {
      return;
    }

    setState(() {
      _sedangMengirim = true;
    });

    try {
      // Model melakukan simulasi pengiriman selama 2 detik,
      // kemudian menyimpan data dan memanggil notifyListeners().
      await context.read<PengajuanModel>().tambahPengajuan(
        namaLengkap: _namaController.text.trim(),
        email: _emailController.text.trim(),
        bidangLayanan: _bidangLayanan!,
        sesiKunjungan: _sesiKunjungan!,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pengajuan berhasil dikirim!')),
      );

      // Kembali ke halaman Warga setelah pengajuan tersimpan.
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Pengajuan gagal dikirim: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _sedangMengirim = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rincian Layanan')),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // HEADER FORM
            Text(
              'Formulir Pengajuan Layanan',
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'Lengkapi informasi berikut untuk mengajukan '
              'layanan kepada petugas.',
            ),

            const SizedBox(height: 24),

            // NAMA LENGKAP
            TextFormField(
              controller: _namaController,
              enabled: !_sedangMengirim,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nama lengkap',
                hintText: 'Masukkan nama lengkap Anda',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama lengkap wajib diisi.';
                }

                return null;
              },
              onChanged: (_) {
                setState(() {});
              },
            ),

            const SizedBox(height: 16),

            // EMAIL
            TextFormField(
              controller: _emailController,
              enabled: !_sedangMengirim,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Alamat email',
                hintText: 'nama@email.com',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Alamat email wajib diisi.';
                }

                if (!value.trim().contains('@')) {
                  return 'Email harus mengandung karakter @.';
                }

                return null;
              },
              onChanged: (_) {
                setState(() {});
              },
            ),

            const SizedBox(height: 24),

            // PILIHAN BIDANG LAYANAN
            Text(
              'Bidang layanan',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              initialValue: _bidangLayanan,
              decoration: const InputDecoration(
                labelText: 'Pilih bidang layanan',
                prefixIcon: Icon(Icons.miscellaneous_services),
                border: OutlineInputBorder(),
              ),
              items: PengajuanModel.bidangLayanan
                  .map(
                    (bidang) => DropdownMenuItem<String>(
                      value: bidang,
                      child: Text(bidang),
                    ),
                  )
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Pilih bidang layanan terlebih dahulu.';
                }

                return null;
              },
              onChanged: (value) {
                if (_sedangMengirim) return;
                setState(() {
                  _bidangLayanan = value;
                });
              },
            ),

            const SizedBox(height: 24),

            // PILIHAN SESI KUNJUNGAN
            Text(
              'Sesi kunjungan',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            RadioGroup<String>(
              groupValue: _sesiKunjungan,
              onChanged: (value) {
                if (_sedangMengirim) return;
                setState(() {
                  _sesiKunjungan = value;
                });
              },
              child: const Column(
                children: [
                  RadioListTile<String>(
                    value: 'Pagi',
                    title: Text('Pagi'),
                    subtitle: Text('08.00–11.00'),
                    secondary: Icon(Icons.wb_sunny_outlined),
                    contentPadding: EdgeInsets.zero,
                  ),
                  RadioListTile<String>(
                    value: 'Siang',
                    title: Text('Siang'),
                    subtitle: Text('11.00–14.00'),
                    secondary: Icon(Icons.light_mode_outlined),
                    contentPadding: EdgeInsets.zero,
                  ),
                  RadioListTile<String>(
                    value: 'Sore',
                    title: Text('Sore'),
                    subtitle: Text('14.00–16.00'),
                    secondary: Icon(Icons.wb_twilight),
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),

            if (_sesiKunjungan == null)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  'Pilih salah satu sesi kunjungan.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // PERSETUJUAN DATA PRIBADI
            Card(
              child: CheckboxListTile(
                value: _persetujuanDataPribadi,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                  'Persetujuan Data Pribadi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  'Saya menyetujui penggunaan data pribadi '
                  'untuk keperluan pemrosesan pengajuan layanan.',
                ),
                onChanged: _sedangMengirim
                    ? null
                    : (value) {
                        setState(() {
                          _persetujuanDataPribadi = value ?? false;
                        });
                      },
              ),
            ),

            const SizedBox(height: 24),

            // TOMBOL KIRIM DAN LOADING
            ElevatedButton.icon(
              onPressed: _siapKirim ? _kirimPengajuan : null,
              icon: _sedangMengirim
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              label: Text(
                _sedangMengirim
                    ? 'Sedang mengirim pengajuan...'
                    : 'Kirim Pengajuan',
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              _siapKirim
                  ? 'Formulir lengkap dan siap dikirim.'
                  : 'Lengkapi nama, email, bidang layanan, '
                        'sesi kunjungan, dan persetujuan agar '
                        'tombol aktif.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
