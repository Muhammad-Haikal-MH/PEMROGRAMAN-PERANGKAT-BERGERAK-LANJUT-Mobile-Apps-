import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pendaftar_model.dart';

class FormulirPage extends StatefulWidget {
  const FormulirPage({super.key});

  @override
  State<FormulirPage> createState() => _FormulirPageState();
}

class _FormulirPageState extends State<FormulirPage> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  bool setujuSyarat = false;
  String? sesiTerpilih;
  bool sedangMengirim = false;

  bool get formLengkap =>
      namaController.text.trim().isNotEmpty &&
      emailController.text.trim().contains('@') &&
      setujuSyarat &&
      sesiTerpilih != null;

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> kirimFormulir() async {
    if (!formLengkap || sedangMengirim) return;
    setState(() => sedangMengirim = true);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    context.read<PendaftarModel>().tambah(
      Pendaftar(
        nama: namaController.text.trim(),
        email: emailController.text.trim(),
        sesi: sesiTerpilih!,
      ),
    );
    setState(() {
      sedangMengirim = false;
      namaController.clear();
      emailController.clear();
      setujuSyarat = false;
      sesiTerpilih = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pendaftaran berhasil dikirim')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Pendaftaran')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            namaController.clear();
            emailController.clear();
            setujuSyarat = false;
            sesiTerpilih = null;
          });
        },
        tooltip: 'Bersihkan formulir',
        child: const Icon(Icons.refresh),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/detail-kegiatan'),
              onLongPress: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Kegiatan: Seminar Teknologi Mobile'),
                ),
              ),
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.event),
                  title: Text('Seminar Teknologi Mobile'),
                  subtitle: Text(
                    'Ketuk untuk detail, tahan untuk info singkat',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: namaController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            CheckboxListTile(
              value: setujuSyarat,
              title: const Text(
                'Saya menyetujui syarat dan ketentuan kegiatan',
              ),
              onChanged: (nilai) =>
                  setState(() => setujuSyarat = nilai ?? false),
            ),
            RadioGroup<String>(
              groupValue: sesiTerpilih,
              onChanged: (nilai) => setState(() => sesiTerpilih = nilai),
              child: Column(
                children: [
                  for (final sesi in ['Pagi', 'Siang', 'Sore'])
                    RadioListTile<String>(
                      title: Text('Sesi $sesi'),
                      value: sesi,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: formLengkap && !sedangMengirim ? kirimFormulir : null,
              child: sedangMengirim
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Kirim Pendaftaran'),
            ),
          ],
        ),
      ),
    );
  }
}
