import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:training_magang/network/api.dart';
import 'package:training_magang/res/res_get_meal.dart';

class RepoMeal {
  Future<ResGetMeal?> getMeal() async {
    try {
      Response res = await dio.get(apiMealdb);
      return ResGetMeal.fromJson(jsonDecode(res.data));
    } catch (e) {
      log('${e.toString()}');
    }
  }
}
