import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF087E8B),
                  Color(0xFF0A9BA5),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_city,
                  color: Colors.white,
                  size: 45,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Nusantara Cerdas Mobile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Satu aplikasi untuk memudahkan akses '
                  'layanan publik masyarakat.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF087E8B),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.layanan,
                    );
                  },
                  child: const Text('Jelajahi Layanan'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          Text(
            'Layanan Publik',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: 15),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.25,
            children: const [
              _KategoriCard(
                ikon: Icons.badge_outlined,
                judul: 'Perizinan',
                warna: Colors.blue,
              ),
              _KategoriCard(
                ikon: Icons.local_hospital_outlined,
                judul: 'Kesehatan',
                warna: Colors.green,
              ),
              _KategoriCard(
                ikon: Icons.directions_bus_outlined,
                judul: 'Transportasi',
                warna: Colors.orange,
              ),
              _KategoriCard(
                ikon: Icons.favorite_outline,
                judul: 'Favorit',
                warna: Colors.red,
              ),
            ],
          ),

          const SizedBox(height: 28),

          const Text(
            'Tentang Aplikasi',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Nusantara Cerdas Mobile merupakan aplikasi '
            'layanan publik digital yang membantu masyarakat '
            'mengakses informasi dan mengajukan layanan '
            'pemerintahan secara lebih mudah, cepat, dan terintegrasi.',
            style: TextStyle(height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _KategoriCard extends StatelessWidget {
  final IconData ikon;
  final String judul;
  final Color warna;

  const _KategoriCard({
    required this.ikon,
    required this.judul,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              ikon,
              size: 35,
              color: warna,
            ),
            const SizedBox(height: 10),
            Text(
              judul,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}