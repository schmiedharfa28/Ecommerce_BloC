import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:training_magang/data_global.dart';
import 'package:training_magang/data_global/preference_data.dart';
import 'package:training_magang/main.dart';
import 'package:training_magang/repository/repo_auth.dart';
import 'package:training_magang/res/res_login.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  RepoLogin repo = RepoLogin();
  ResGetLogin? resGetLogin;

  Future<void> loginAccount(
      BuildContext context, String? email, String? password) async {
    try {
      emit(LoginLoading());
      ResGetLogin? res = await repo.loginAccount(email, password);
      if (res != null) {
        resGetLogin = res;
        dataGlobal.user = resGetLogin?.user;
        await SavePreference().saveUser();
        emit(LoginSuccess(resGetLogin));
      }
      if (res.status == 200) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      } else if (res.status == 404) {
        emit(LoginError(res.message));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${res.message}')));
      } else {
        emit(LoginError(res.message));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${res.message}')));
      }
    } catch (e) {
      //
      // log('${e.toString()}');
      // emit(LoginError(e.toString()));
      emit(LoginError(e.toString()));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${e.toString()}')));
    }
  }
}
