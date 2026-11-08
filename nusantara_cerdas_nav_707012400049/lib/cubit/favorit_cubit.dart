import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super({});

  // Menambahkan layanan ke daftar favorit
  void tandai(String namaLayanan) {
    final favoritBaru = Set<String>.from(state);

    favoritBaru.add(namaLayanan);

    emit(favoritBaru);
  }

  // Menghapus layanan dari daftar favorit
  void batalTandai(String namaLayanan) {
    final favoritBaru = Set<String>.from(state);

    favoritBaru.remove(namaLayanan);

    emit(favoritBaru);
  }

  // Memeriksa apakah layanan sudah menjadi favorit
  bool isFavorit(String namaLayanan) {
    return state.contains(namaLayanan);
  }
}