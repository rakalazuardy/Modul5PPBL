import 'package:flutter/material.dart';

class Layanan {
  final String id;
  final String nama;
  final String bidang;
  final String deskripsi;
  final IconData ikon;

  const Layanan({
    required this.id,
    required this.nama,
    required this.bidang,
    required this.deskripsi,
    required this.ikon,
  });

  static const List<Layanan> daftarLayanan = [
    // Bidang Perizinan
    Layanan(
      id: 'izin_ktp',
      nama: 'Pembuatan KTP',
      bidang: 'Perizinan',
      deskripsi:
          'Layanan pengajuan pembuatan Kartu Tanda Penduduk bagi warga.',
      ikon: Icons.badge_outlined,
    ),
    Layanan(
      id: 'izin_kk',
      nama: 'Pembuatan Kartu Keluarga',
      bidang: 'Perizinan',
      deskripsi:
          'Layanan pengajuan pembuatan dan pembaruan Kartu Keluarga.',
      ikon: Icons.family_restroom,
    ),
    Layanan(
      id: 'izin_usaha',
      nama: 'Izin Usaha',
      bidang: 'Perizinan',
      deskripsi:
          'Layanan pengajuan perizinan untuk mendirikan usaha.',
      ikon: Icons.storefront_outlined,
    ),

    // Bidang Kesehatan
    Layanan(
      id: 'kesehatan_puskesmas',
      nama: 'Layanan Puskesmas',
      bidang: 'Kesehatan',
      deskripsi:
          'Layanan pendaftaran pemeriksaan kesehatan di Puskesmas.',
      ikon: Icons.local_hospital_outlined,
    ),
    Layanan(
      id: 'kesehatan_imunisasi',
      nama: 'Layanan Imunisasi',
      bidang: 'Kesehatan',
      deskripsi:
          'Layanan pendaftaran imunisasi untuk masyarakat.',
      ikon: Icons.vaccines_outlined,
    ),
    Layanan(
      id: 'kesehatan_ambulans',
      nama: 'Permohonan Ambulans',
      bidang: 'Kesehatan',
      deskripsi:
          'Layanan permohonan fasilitas ambulans bagi warga.',
      ikon: Icons.emergency_outlined,
    ),

    // Bidang Transportasi
    Layanan(
      id: 'transportasi_kartu',
      nama: 'Kartu Transportasi',
      bidang: 'Transportasi',
      deskripsi:
          'Layanan pengajuan kartu transportasi masyarakat.',
      ikon: Icons.credit_card_outlined,
    ),
    Layanan(
      id: 'transportasi_parkir',
      nama: 'Izin Parkir',
      bidang: 'Transportasi',
      deskripsi:
          'Layanan pengajuan izin penggunaan fasilitas parkir.',
      ikon: Icons.local_parking,
    ),
    Layanan(
      id: 'transportasi_pengaduan',
      nama: 'Pengaduan Transportasi',
      bidang: 'Transportasi',
      deskripsi:
          'Layanan penyampaian pengaduan terkait fasilitas transportasi.',
      ikon: Icons.directions_bus_outlined,
    ),
  ];
}