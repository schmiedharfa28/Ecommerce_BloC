import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:training_magang/cubit/cart/insert_cart_cubit.dart';
import 'package:training_magang/repository/repo_Kategori.dart';
import 'package:training_magang/res/res_keranjang.dart';

part 'keranjang_state.dart';

class KeranjangCubit extends Cubit<KeranjangState> {
  KeranjangCubit() : super(KeranjangInitial());

  RepoKategori repo = RepoKategori();
  ResKeranjang? resKeranjang;

  Future<void> getListKeranjang(BuildContext context) async {
    try {
      emit(KeranjangLoading());
      ResKeranjang? res = await repo.getKeranjang();
      if (res != null) {
        resKeranjang = res;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${res.message}')));
        emit(KeranjangSuccess(resKeranjang));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${res?.message}')));

        emit(KeranjangError(res?.message));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${e.toString()}')));

      emit(KeranjangError(e.toString()));
    }
  }
}
