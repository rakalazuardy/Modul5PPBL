import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../navigation/app_routes.dart';
import '../models/layanan.dart';

import 'halaman_beranda.dart';
import 'halaman_layanan.dart';
import 'halaman_warga.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() =>
      _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int indeksHalaman = 0;

  final List<Widget> halaman = const [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanWarga(),
  ];

  final List<String> judulHalaman = [
    'Beranda',
    'Layanan',
    'Warga',
  ];

  void pindahHalaman(int indeks) {
    setState(() {
      indeksHalaman = indeks;
    });

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lebarLayar = MediaQuery.of(context).size.width;
    final layarLebar = lebarLayar >= 700;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          judulHalaman[indeksHalaman],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF087E8B),
        foregroundColor: Colors.white,
      ),

      // Navigation Drawer
      drawer: NavigationDrawer(
        selectedIndex: indeksHalaman,
        onDestinationSelected: pindahHalaman,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 24, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFF087E8B),
                  child: Icon(
                    Icons.location_city,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Nusantara Cerdas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Layanan Publik Digital',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          const Divider(),

          const NavigationDrawerDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: Text('Beranda'),
          ),

          const NavigationDrawerDestination(
            icon: Icon(Icons.miscellaneous_services_outlined),
            selectedIcon: Icon(Icons.miscellaneous_services),
            label: Text('Layanan'),
          ),

          const NavigationDrawerDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: Text('Warga'),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(28, 20, 16, 10),
            child: Text(
              'MENU LAINNYA',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Pengaturan'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                AppRoutes.pengaturan,
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Tentang Aplikasi'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                AppRoutes.tentang,
              );
            },
          ),
        ],
      ),

      body: Row(
        children: [
          // NavigationRail untuk layar lebar
          if (layarLebar)
            NavigationRail(
              selectedIndex: indeksHalaman,
              onDestinationSelected: pindahHalaman,
              labelType: NavigationRailLabelType.all,
              backgroundColor: Colors.white,
              destinations: [
                const NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Beranda'),
                ),
                const NavigationRailDestination(
                  icon: Icon(Icons.miscellaneous_services_outlined),
                  selectedIcon: Icon(Icons.miscellaneous_services),
                  label: Text('Layanan'),
                ),
                NavigationRailDestination(
                  icon: const _BadgeIcon(
                    icon: Icons.people_outline,
                  ),
                  selectedIcon: const _BadgeIcon(
                    icon: Icons.people,
                  ),
                  label: const Text('Warga'),
                ),
              ],
            ),

          if (layarLebar)
            const VerticalDivider(
              width: 1,
              thickness: 1,
            ),

          // Isi halaman
          Expanded(
            child: IndexedStack(
              index: indeksHalaman,
              children: halaman,
            ),
          ),
        ],
      ),

      // NavigationBar untuk layar sempit
      bottomNavigationBar: layarLebar
          ? null
          : NavigationBar(
              selectedIndex: indeksHalaman,
              onDestinationSelected: pindahHalaman,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.miscellaneous_services_outlined),
                  selectedIcon: Icon(Icons.miscellaneous_services),
                  label: 'Layanan',
                ),
                NavigationDestination(
                  icon: const _BadgeIcon(
                    icon: Icons.people_outline,
                  ),
                  selectedIcon: const _BadgeIcon(
                    icon: Icons.people,
                  ),
                  label: 'Warga',
                ),
              ],
            ),
    );
  }
}

// Widget khusus badge jumlah pengajuan
class _BadgeIcon extends StatelessWidget {
  final IconData icon;

  const _BadgeIcon({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PengajuanCubit, List<Layanan>, int>(
      selector: (pengajuan) => pengajuan.length,
      builder: (context, total) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon),

            if (total > 0)
              Positioned(
                right: -10,
                top: -7,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$total',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}