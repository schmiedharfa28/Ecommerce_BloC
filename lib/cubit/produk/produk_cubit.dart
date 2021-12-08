import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:training_magang/repository/repo_Kategori.dart';
import 'package:training_magang/res/res_get_produk.dart';

part 'produk_state.dart';

class ProdukCubit extends Cubit<ProdukState> {
  ProdukCubit() : super(ProdukInitial());

  RepoKategori repo = RepoKategori();
  ResGetProduk? resGetProduk;

  Future<void> getDataProduk() async {
    try {
      emit(ProdukLoading()); // sama dengan notifylisteners
      ResGetProduk? res = await repo.getProduk();
      if (res != null) {
        resGetProduk = res;
        emit(ProdukSuccess(resGetProduk));
      } else {
        log('${res?.message}');
        emit(ProdukError(res?.message));
      }
    } catch (e) {
      log('${e.toString()}');
      emit(ProdukError(e.toString()));
    }
  }
}
