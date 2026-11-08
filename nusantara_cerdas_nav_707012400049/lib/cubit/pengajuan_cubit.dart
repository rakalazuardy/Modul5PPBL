import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/layanan.dart';

class PengajuanCubit extends Cubit<List<Layanan>> {
  PengajuanCubit() : super([]);

  // Menghitung total layanan yang diajukan
  int get totalPengajuan => state.length;

  // Menambahkan layanan ke keranjang pengajuan
  void tambah(Layanan layanan) {
    // Mencegah layanan yang sama masuk dua kali
    final sudahAda = state.any(
      (item) => item.id == layanan.id,
    );

    if (sudahAda) return;

    final daftarBaru = List<Layanan>.from(state);

    daftarBaru.add(layanan);

    emit(daftarBaru);
  }

  // Menghapus layanan dari keranjang pengajuan
  void hapus(String idLayanan) {
    final daftarBaru = state
        .where((item) => item.id != idLayanan)
        .toList();

    emit(daftarBaru);
  }

  // Mengosongkan seluruh pengajuan
  void kosongkan() {
    emit([]);
  }
}