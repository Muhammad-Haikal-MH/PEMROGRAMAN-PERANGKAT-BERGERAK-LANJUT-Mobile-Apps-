import 'package:flutter/material.dart';

class HalamanCatatan extends StatelessWidget {
  const HalamanCatatan({super.key});

  void _tambahCatatan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tambah catatan baru'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan'),
      ),
      body: const Center(
        child: Text(
          'Daftar catatan kuliah',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _tambahCatatan(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              tooltip: 'Search',
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              tooltip: 'Filter',
              icon: const Icon(Icons.filter_list),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              tooltip: 'Sort',
              icon: const Icon(Icons.sort),
            ),
            IconButton(
              onPressed: () {},
              tooltip: 'More',
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}