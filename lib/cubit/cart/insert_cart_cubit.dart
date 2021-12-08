import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:training_magang/repository/repo_Kategori.dart';
import 'package:training_magang/res/res_insert_keranjang.dart';

part 'insert_cart_state.dart';

class InsertCartCubit extends Cubit<InsertCartState> {
  InsertCartCubit() : super(InsertCartInitial());

  RepoKategori repo = RepoKategori();
  ResInsertKeranjang? resInsertKeranjang;

  Future<void> addItemKeranjang(BuildContext context, String? cartIdOrder,
      String? cartIdProduk, int? cartQty, int? cartHarga) async {
    try {
      emit(InsertCartLoading());
      ResInsertKeranjang? res = await repo.addKeranjang(
          cartIdOrder, cartIdProduk, cartQty, cartHarga);
      if (res != null) {
        resInsertKeranjang = res;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${res.message}')));
        emit(InsertCartSuccess(resInsertKeranjang));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${res?.message}')));
        emit(InsertCartError(res?.message));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${e.toString()}')));
        emit(InsertCartError(e.toString()));
    }
  }
}
