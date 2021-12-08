import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:training_magang/repository/repo_auth.dart';
import 'package:training_magang/res/res_register.dart';
import 'package:training_magang/view/auth/login.dart';
import 'package:flutter/material.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  RepoAuth repo = RepoAuth();
  ResRegister? resRegister;

  Future<void> registerAccount(BuildContext context, String? fullname,
      String? telp, String? email, String? password) async {
    try {
      emit(RegisterLoading());
      ResRegister? res =
          await repo.registerAccount(fullname, telp, email, password);
      if (res != null) {
        resRegister = res;
        emit(RegisterSuccess(resRegister));

        if (res.status == 200) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
        } else if (res.status == 404) {
          emit(RegisterError(res.message));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${res.message}')));
        } else {
          // log('${res.message}');
          emit(RegisterError(res.message));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${res.message}')));
        }
      }
    } catch (e) {
      log('${e.toString()}');
      emit(RegisterError(e.toString()));
    }
  }
}
