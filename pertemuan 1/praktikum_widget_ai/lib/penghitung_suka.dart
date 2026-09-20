import 'package:flutter/material.dart';

class PenghitungSuka extends StatefulWidget {
  const PenghitungSuka({super.key});

  @override
  State<PenghitungSuka> createState() => _PenghitungSukaState();
}

class _PenghitungSukaState extends State<PenghitungSuka> {
  int _jumlahSuka = 0;
  bool _disukai = false;

  void _suka() {
    setState(() {
      _jumlahSuka++;
      _disukai = true;
    });
  }

  void _reset() {
    setState(() {
      _jumlahSuka = 0;
      _disukai = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  _disukai ? Icons.favorite : Icons.favorite_border,
                  color: _disukai ? Colors.red : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  '$_jumlahSuka Suka',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _suka,
                  icon: const Icon(Icons.favorite),
                  label: const Text('Suka'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: _reset,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}