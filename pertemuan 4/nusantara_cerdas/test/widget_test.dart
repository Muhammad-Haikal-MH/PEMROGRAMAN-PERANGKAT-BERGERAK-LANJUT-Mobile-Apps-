import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:nusantara_cerdas/model/pengajuan_model.dart';
import 'package:nusantara_cerdas/pages/halaman_warga.dart';

void main() {
  testWidgets('halaman warga menampilkan sambutan dan status pengajuan', (
    tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => PengajuanModel(),
        child: const MaterialApp(home: Scaffold(body: HalamanWarga())),
      ),
    );

    expect(find.text('Selamat Datang!'), findsOneWidget);
    expect(find.text('Belum ada pengajuan'), findsOneWidget);
  });
}
