import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../models/layanan.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // BAGIAN LAYANAN FAVORIT

        const Text(
          'Layanan Favorit',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, favorit) {
            final daftarFavorit = Layanan.daftarLayanan
                .where((layanan) => favorit.contains(layanan.id))
                .toList();

            if (daftarFavorit.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        Icons.star_border,
                        size: 45,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text('Belum ada layanan favorit.'),
                      Text(
                        'Tandai layanan dengan ikon bintang '
                        'untuk menyimpannya.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: daftarFavorit.map((layanan) {
                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    title: Text(layanan.nama),
                    subtitle: Text(layanan.bidang),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        context
                            .read<FavoritCubit>()
                            .batalTandai(layanan.id);
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),

        const SizedBox(height: 30),

        // BAGIAN PENGAJUAN

        const Text(
          'Keranjang Pengajuan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        BlocBuilder<PengajuanCubit, List<Layanan>>(
          builder: (context, pengajuan) {
            if (pengajuan.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 45,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text('Belum ada pengajuan layanan.'),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: [
                ...pengajuan.map((layanan) {
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        layanan.ikon,
                        color: const Color(0xFF087E8B),
                      ),
                      title: Text(layanan.nama),
                      subtitle: Text(layanan.bidang),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          context
                              .read<PengajuanCubit>()
                              .hapus(layanan.id);
                        },
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: const Text('Kirim Pengajuan'),
                            content: Text(
                              'Apakah Anda yakin ingin mengirim '
                              '${pengajuan.length} layanan sekaligus?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                },
                                child: const Text('Batal'),
                              ),
                              FilledButton(
                                onPressed: () {
                                  context
                                      .read<PengajuanCubit>()
                                      .kosongkan();

                                  Navigator.pop(dialogContext);

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Pengajuan berhasil dikirim!',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Kirim'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.send),
                    label: const Text('Kirim Semua Pengajuan'),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}