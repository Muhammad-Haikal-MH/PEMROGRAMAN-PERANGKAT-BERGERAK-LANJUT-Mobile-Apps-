import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/pengajuan_model.dart';
import 'model/chat_model.dart';
import 'navigation/app_routes.dart';

void main() {
  runApp(const NusantaraCerdasMobile());
}

class NusantaraCerdasMobile extends StatelessWidget {
  const NusantaraCerdasMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PengajuanModel>(create: (_) => PengajuanModel()),
        ChangeNotifierProvider<ChatModel>(create: (_) => ChatModel()),
      ],
      child: MaterialApp(
        title: 'Nusantara Cerdas Mobile',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(centerTitle: true),
        ),

        initialRoute: AppRoutes.warga,

        routes: AppRoutes.daftarRoute(),

        onGenerateRoute: AppRoutes.bentukRoute,

        onUnknownRoute: AppRoutes.routeTidakDikenal,
      ),
    );
  }
}
