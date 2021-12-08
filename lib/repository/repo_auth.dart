import 'dart:convert';
import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:training_magang/data_global.dart';
import 'package:training_magang/network/api.dart';
import 'package:training_magang/res/res_get_profile.dart';
import 'package:training_magang/res/res_login.dart';
import 'package:training_magang/res/res_register.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:training_magang/res/res_update_profile.dart';

//register
class RepoAuth {
  Future<ResRegister?> registerAccount(
      String? fullname, String? email, String? telp, String? password) async {
    Response res = await dio.post(apiRegister,
        data: FormData.fromMap({
          'nama': '$fullname',
          'email': '$email',
          'hp': '$telp',
          'password': '$password'
        }));
    return ResRegister.fromJson(jsonDecode(res.data));
  }
}

//login
class RepoLogin {
  Future<ResGetLogin> loginAccount(String? email, String? password) async {
    Response res = await dio.post(apiLogin,
        data: FormData.fromMap({'email': '$email', 'password': '$password'}));
    return ResGetLogin.fromJson(jsonDecode(res.data));
  }
}

//menampilkan profile
class RepoProfile {
  Future<ResGetProfile?> getProfile() async {
    try {
      Response res = await dio.post(apiProfile,
          data: FormData.fromMap({'iduser': '${dataGlobal.user?.userId}'}));
      return ResGetProfile.fromJson(jsonDecode(res.data));
    } catch (e) {
      log('${e.toString()}');
    }
  }
}

class RepoUpdateProfile {
  Future<ResUpdateProfile?> updateProfile(
      String? telp, String? nama, String? email, XFile? image) async {
    try {
      Response res = await dio.post(apiUpdateProfile,
          data: FormData.fromMap({
            'idUser': '${dataGlobal.user?.userId}',
            'userTelp': '$telp',
            'userNama': '$nama',
            'userEmail': '$email',
            'image': await MultipartFile.fromFile(image!.path,
                filename: basename(image.path))
          }));
      return ResUpdateProfile.fromJson(jsonDecode(res.data));
    } catch (e) {
      log('${e.toString()}');
    }
  }
}
