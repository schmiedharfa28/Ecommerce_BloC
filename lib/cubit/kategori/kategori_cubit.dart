import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:training_magang/repository/repo_Kategori.dart';
import 'package:training_magang/res/res_get_kategori.dart';

part 'kategori_state.dart';

class KategoriCubit extends Cubit<KategoriState> {
  KategoriCubit() : super(KategoriInitial());

  RepoKategori repo = RepoKategori();
  ResGetKategori? resGetKategori;

  Future<void> getDataKategori() async {
    try {
      emit(KategoriLoading());
      ResGetKategori? res = await repo.getKategori();
      if (res != null) {
        resGetKategori = res;
        emit(KategoriSuccess(resGetKategori));
      } else {
        log('${res?.message}'); //memastikan data tampil apa tidak
        emit(KategoriError(res?.message));
      }
    } catch (e) {
      log('${e.toString()}');
      emit(KategoriError(e.toString()));
    }
  }
}
