
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/laporan_model.dart';
import 'models/lokasi_model.dart';
import 'models/favorit_model.dart';
import 'navigation/app_routes.dart';

void main() {
  runApp(const AplikasiSiagaManado());
}

class AplikasiSiagaManado extends StatelessWidget {
  const AplikasiSiagaManado({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoritModel>(
          create: (_) => FavoritModel(),
        ),
        ChangeNotifierProvider<LaporanModel>(
          create: (_) => LaporanModel(),
        ),
        ChangeNotifierProvider<LokasiModel>(
          create: (_) => LokasiModel(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
