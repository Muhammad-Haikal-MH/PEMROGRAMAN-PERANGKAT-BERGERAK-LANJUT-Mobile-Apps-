import 'package:flutter_test/flutter_test.dart';
import 'package:form_pendaftaran_707012400003/main.dart';

void main() {
  testWidgets('halaman formulir pendaftaran tampil', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Seminar Teknologi Mobile'), findsOneWidget);
    expect(find.text('Nama Lengkap'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Kirim Pendaftaran'), findsOneWidget);
  });
}
