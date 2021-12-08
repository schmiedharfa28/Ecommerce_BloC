import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:training_magang/repository/repo_auth.dart';
import 'package:training_magang/res/res_update_profile.dart';

part 'updateprofile_state.dart';

class UpdateprofileCubit extends Cubit<UpdateprofileState> {
  UpdateprofileCubit() : super(UpdateprofileInitial());

  RepoUpdateProfile repo = RepoUpdateProfile();
  ResUpdateProfile? resUpdateProfile;

  Future<void> updateProfileUser(BuildContext context, String? telp,
      String? nama, String? email, XFile? image) async {
    try {
      emit(UpdateProfileLoading());
      ResUpdateProfile? res =
          await repo.updateProfile(telp, nama, email, image);
      if (res != null) {
        resUpdateProfile = res;
        emit(UpdateProfieSuccess(resUpdateProfile));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${res?.message}')));
        emit(UpdateProfileError(res?.message));
      }
    } catch (e) {
       ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${e.toString()}')));
        emit(UpdateProfileError(e.toString()));

    }
  }
}
