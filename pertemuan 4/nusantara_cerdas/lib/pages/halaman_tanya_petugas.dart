import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/chat_model.dart';

class HalamanTanyaPetugas extends StatefulWidget {
  const HalamanTanyaPetugas({super.key});

  @override
  State<HalamanTanyaPetugas> createState() => _HalamanTanyaPetugasState();
}

class _HalamanTanyaPetugasState extends State<HalamanTanyaPetugas> {
  final _pesanController = TextEditingController();
  final _scrollController = ScrollController();

  bool _sedangMengirim = false;

  @override
  void dispose() {
    _pesanController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _kirimPesan() async {
    final teks = _pesanController.text.trim();

    if (teks.isEmpty || _sedangMengirim) {
      return;
    }

    _pesanController.clear();

    setState(() {
      _sedangMengirim = true;
    });

    try {
      await context.read<ChatModel>().kirimPesan(teks);

      if (!mounted) return;

      await _gulirKeBawah();
    } finally {
      if (mounted) {
        setState(() {
          _sedangMengirim = false;
        });
      }
    }
  }

  Future<void> _gulirKeBawah() async {
    await WidgetsBinding.instance.endOfFrame;

    if (!_scrollController.hasClients) return;

    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  String _formatWaktu(DateTime waktu) {
    final jam = waktu.hour.toString().padLeft(2, '0');
    final menit = waktu.minute.toString().padLeft(2, '0');

    return '$jam:$menit';
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChatModel>();
    final pesan = model.daftarPesan;

    return Column(
      children: [
        // INFORMASI LAYANAN CHAT
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: const Row(
            children: [
              CircleAvatar(child: Icon(Icons.support_agent)),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanya Petugas',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('Simulasi percakapan layanan warga'),
                  ],
                ),
              ),
            ],
          ),
        ),

        // DAFTAR PESAN
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: pesan.length,
            itemBuilder: (context, index) {
              final item = pesan[index];

              return _GelembungPesan(
                teks: item.teks,
                dariWarga: item.dariWarga,
                waktu: _formatWaktu(item.waktu),
              );
            },
          ),
        ),

        // INPUT PESAN DAN TOMBOL KIRIM
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _pesanController,
                    minLines: 1,
                    maxLines: 4,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      hintText: 'Tulis pesan...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _kirimPesan(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  tooltip: 'Kirim pesan',
                  onPressed: _sedangMengirim ? null : _kirimPesan,
                  icon: _sedangMengirim
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _GelembungPesan extends StatelessWidget {
  final String teks;
  final bool dariWarga;
  final String waktu;

  const _GelembungPesan({
    required this.teks,
    required this.dariWarga,
    required this.waktu,
  });

  @override
  Widget build(BuildContext context) {
    final warna = dariWarga
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.surfaceContainerHighest;

    final alignment = dariWarga ? Alignment.centerRight : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: warna,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dariWarga ? 'Anda' : 'Petugas',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(teks),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(waktu, style: Theme.of(context).textTheme.labelSmall),
            ),
          ],
        ),
      ),
    );
  }
}
