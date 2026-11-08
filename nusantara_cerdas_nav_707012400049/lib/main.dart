import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/favorit_cubit.dart';
import 'cubit/pengajuan_cubit.dart';

import 'models/layanan.dart';

import 'navigation/app_routes.dart';

import 'pages/kerangka_navigasi.dart';
import 'pages/halaman_layanan.dart';
import 'pages/halaman_warga.dart';
import 'pages/halaman_detail_layanan.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FavoritCubit>(
          create: (context) => FavoritCubit(),
        ),

        BlocProvider<PengajuanCubit>(
          create: (context) => PengajuanCubit(),
        ),
      ],
      child: const AplikasiNusantara(),
    ),
  );
}

class AplikasiNusantara extends StatelessWidget {
  const AplikasiNusantara({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Nusantara Cerdas Mobile',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF087E8B),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      home: const KerangkaNavigasi(),

      routes: {
        AppRoutes.layanan: (context) =>
            const Scaffold(
              appBar: null,
              body: SafeArea(
                child: HalamanLayanan(),
              ),
            ),

        AppRoutes.warga: (context) =>
            const Scaffold(
              body: SafeArea(
                child: HalamanWarga(),
              ),
            ),

        AppRoutes.pengaturan: (context) =>
            const HalamanInformasi(
              judul: 'Pengaturan',
              deskripsi:
                  'Halaman pengaturan aplikasi Nusantara Cerdas Mobile.',
              ikon: Icons.settings,
            ),

        AppRoutes.tentang: (context) =>
            const HalamanInformasi(
              judul: 'Tentang Aplikasi',
              deskripsi:
                  'Nusantara Cerdas Mobile merupakan aplikasi '
                  'layanan publik digital untuk memudahkan '
                  'masyarakat mengakses layanan pemerintahan.',
              ikon: Icons.info_outline,
            ),
      },

      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.detailLayanan) {
          final layanan = settings.arguments as Layanan;

          return MaterialPageRoute(
            builder: (context) {
              return HalamanDetailLayanan(
                layanan: layanan,
              );
            },
            settings: settings,
          );
        }

        return null;
      },
    );
  }
}

// Halaman informasi pendukung
class HalamanInformasi extends StatelessWidget {
  final String judul;
  final String deskripsi;
  final IconData ikon;

  const HalamanInformasi({
    super.key,
    required this.judul,
    required this.deskripsi,
    required this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                ikon,
                size: 65,
                color: const Color(0xFF087E8B),
              ),
              const SizedBox(height: 20),
              Text(
                judul,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                deskripsi,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
