import 'package:flutter/material.dart';
import 'navigation/app_routes.dart';

void main() {
  runApp(const AplikasiSiagaManado());
}

class AplikasiSiagaManado extends StatelessWidget {
  const AplikasiSiagaManado({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siaga Manado Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.red,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.beranda,
      routes: AppRoutes.daftarRoute(),
      onGenerateRoute: AppRoutes.bentukRoute,
      onUnknownRoute: AppRoutes.routeTidakDikenal,
    );
  }
}