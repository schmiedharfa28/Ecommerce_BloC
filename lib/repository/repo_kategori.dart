import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_magang/data_global.dart';
import 'package:training_magang/network/api.dart';
import 'package:training_magang/res/res_get_kategori.dart';
import 'package:training_magang/res/res_get_produk.dart';
import 'package:training_magang/res/res_insert_keranjang.dart';
import 'package:training_magang/res/res_keranjang.dart';

//kategori
class RepoKategori {
  Future<ResGetKategori?> getKategori() async {
    try {
      Response res = await dio.get(apiKategori);
      return ResGetKategori.fromJson(jsonDecode(res.data));
    } catch (e) {
      log('${e.toString()}');
    }
  }

//produk
  Future<ResGetProduk?> getProduk() async {
    try {
      Response res = await dio.get(apiProduk);
      return ResGetProduk.fromJson(jsonDecode(res.data));
    } catch (e) {
      log('${e.toString()}');
    }
  }

//insert keranjang
  Future<ResInsertKeranjang?> addKeranjang(
    String? cartIdOrder,
    String? cartIdProduk,
    int? cartQty,
    int? cartHarga,
  ) async {
    Response res = await dio.post(apiKeranjang,
        data: FormData.fromMap({
          'idorder': '$cartIdOrder',
          'idproduk': '$cartIdProduk',
          'qty': '$cartQty', //jika masih error hilangkan dolar
          'harga': '$cartHarga',
          'iduser': '${dataGlobal.user?.userId}'
        }));
    return ResInsertKeranjang.fromJson(jsonDecode(res.data));
  }

  //isi keranjang
  Future<ResKeranjang?> getKeranjang() async {
    try {
      Response res = await dio.post(apiListKeranjang,
          data: FormData.fromMap({'iduser': '${dataGlobal.user?.userId}'}));
      return ResKeranjang.fromJson(jsonDecode(res.data));
    } catch (e) {
      log('${e.toString()}');
    }
  }
}
