import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../models/layanan.dart';
import '../navigation/app_routes.dart';

class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  static const List<String> bidang = [
    'Perizinan',
    'Kesehatan',
    'Transportasi',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: bidang.length,
      child: Column(
        children: [
          const Material(
            color: Colors.white,
            child: TabBar(
              isScrollable: false,
              labelColor: Color(0xFF087E8B),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF087E8B),
              tabs: [
                Tab(text: 'Perizinan'),
                Tab(text: 'Kesehatan'),
                Tab(text: 'Transportasi'),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              children: bidang.map((namaBidang) {
                return _DaftarLayanan(
                  bidang: namaBidang,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DaftarLayanan extends StatelessWidget {
  final String bidang;

  const _DaftarLayanan({
    required this.bidang,
  });

  @override
  Widget build(BuildContext context) {
    final daftar = Layanan.daftarLayanan
        .where((layanan) => layanan.bidang == bidang)
        .toList();

    return BlocBuilder<FavoritCubit, Set<String>>(
      builder: (context, favorit) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: daftar.length,
          itemBuilder: (context, index) {
            final layanan = daftar[index];

            final isFavorit = favorit.contains(layanan.id);

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),

                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFE0F2F1),
                  child: Icon(
                    layanan.ikon,
                    color: const Color(0xFF087E8B),
                  ),
                ),

                title: Text(
                  layanan.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(layanan.bidang),

                trailing: IconButton(
                  tooltip: isFavorit
                      ? 'Hapus dari favorit'
                      : 'Tambahkan ke favorit',
                  icon: Icon(
                    isFavorit
                        ? Icons.star
                        : Icons.star_border,
                    color: isFavorit
                        ? Colors.amber
                        : Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {
                    if (isFavorit) {
                      context
                          .read<FavoritCubit>()
                          .batalTandai(layanan.id);
                    } else {
                      context
                          .read<FavoritCubit>()
                          .tandai(layanan.id);
                    }
                  },
                ),

                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.detailLayanan,
                    arguments: layanan,
                  ).then((hasil) {
                    if (hasil == true && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${layanan.nama} berhasil ditambahkan ke pengajuan.',
                          ),
                        ),
                      );
                    }
                  });
                },
              ),
            );
          },
        );
      },
    );
  }
}