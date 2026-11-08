import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../models/layanan.dart';

class HalamanDetailLayanan extends StatefulWidget {
  final Layanan layanan;

  const HalamanDetailLayanan({
    super.key,
    required this.layanan,
  });

  @override
  State<HalamanDetailLayanan> createState() =>
      _HalamanDetailLayananState();
}

class _HalamanDetailLayananState
    extends State<HalamanDetailLayanan> {
  bool sedangMengirim = false;

  Future<void> ajukanPermohonan() async {
    if (sedangMengirim) return;

    setState(() {
      sedangMengirim = true;
    });

    // Simulasi proses pengiriman permohonan
    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    // Memasukkan layanan ke PengajuanCubit
    context.read<PengajuanCubit>().tambah(
          widget.layanan,
        );

    // Mengembalikan nilai ke halaman sebelumnya
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final layanan = widget.layanan;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Layanan'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 45,
                backgroundColor: const Color(0xFFE0F2F1),
                child: Icon(
                  layanan.ikon,
                  size: 45,
                  color: const Color(0xFF087E8B),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              layanan.nama,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Chip(
              label: Text(layanan.bidang),
              backgroundColor: const Color(0xFFE0F2F1),
            ),

            const SizedBox(height: 20),

            const Text(
              'Deskripsi Layanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              layanan.deskripsi,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: sedangMengirim
                    ? null
                    : ajukanPermohonan,
                child: sedangMengirim
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('Mengirim Permohonan...'),
                        ],
                      )
                    : const Text('Ajukan Permohonan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}