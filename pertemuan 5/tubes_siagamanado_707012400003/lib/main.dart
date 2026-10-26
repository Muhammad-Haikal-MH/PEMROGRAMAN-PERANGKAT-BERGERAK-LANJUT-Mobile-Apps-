
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/favorit_cubit.dart';
import 'cubit/laporan_cubit.dart';
import 'navigation/app_routes.dart';

void main() {
  runApp(const AplikasiSiagaManado());
}

class AplikasiSiagaManado extends StatelessWidget {
  const AplikasiSiagaManado({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoritCubit>(
          create: (_) => FavoritCubit(),
        ),

        BlocProvider<LaporanCubit>(
          create: (_) => LaporanCubit(),
        ),
      ],

      child: MaterialApp(
        title: 'Siaga Manado Mobile',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
          ),
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
