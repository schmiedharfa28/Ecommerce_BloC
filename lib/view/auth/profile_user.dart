import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training_magang/cubit/auth/profile/profile_cubit.dart';
import 'package:training_magang/cubit/auth/update_profile/updateprofile_cubit.dart';
import 'package:training_magang/network/api.dart';
import 'package:training_magang/res/res_get_profile.dart';
import 'package:training_magang/view/auth/update_profile.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  ProfileCubit? cubitProfile;
  Profile? dataProfile; //1

  @override
  void initState() {
    dataProfile = cubitProfile?.resGetProfile?.profile?[0];
    super.initState(); //2
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        BlocProvider<UpdateprofileCubit>(
            create: (context) => UpdateprofileCubit())
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Profile User',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            cubitProfile = context.read<ProfileCubit>();
            if (state is ProfileInitial) {
              cubitProfile?.getProfile(context);
            }
            if (state is ProfileLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileSuccess) {
              return ListView.builder(
                  itemCount: cubitProfile?.resGetProfile?.profile?.length,
                  itemBuilder: (context, index) {
                    Profile? data =
                        cubitProfile?.resGetProfile?.profile?[index];
                    return Container(
                      margin: EdgeInsets.all(12),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          data?.userImage != ""
                              ? Image.network(
                                  ImageUrl + '${data!.userImage}',
                                  width: 150,
                                  height: 150,
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 30,
                                  child: Icon(
                                    Icons.person,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${data?.userNama}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('${data?.userEmail}'),
                          SizedBox(
                            height: 10,
                          ),
                          Text('${data?.userHp}'),
                          SizedBox(
                            height: 35,
                          ),
                          BlocBuilder<UpdateprofileCubit, UpdateprofileState>(
                            builder: (context, state) {
                              UpdateprofileCubit cubit =
                                  context.read<UpdateprofileCubit>();
                              if (state is UpdateProfileLoading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.black),
                                );
                              }

                              if (state is UpdateProfileError) {
                                log('${state.message}');
                              }

                              return MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  minWidth: 200,
                                  color: Colors.black,
                                  height: 55,
                                  textColor: Colors.white,
                                  child: Text('Update Profile'),
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return UpdateProfile(
                                          telp: cubitProfile?.resGetProfile
                                              ?.profile?[0].userHp,
                                          nama: cubitProfile?.resGetProfile
                                              ?.profile?[0].userNama,
                                          email: cubitProfile?.resGetProfile
                                              ?.profile?[0].userEmail,
                                          image: XFile(cubitProfile
                                                  ?.resGetProfile
                                                  ?.profile?[0]
                                                  .userImage ??
                                              ""),
                                          onUpdate: (String? telp,
                                              String? nama,
                                              String? email,
                                              XFile? image) async {
                                            await cubit
                                                .updateProfileUser(context,
                                                    telp, nama, email, image)
                                                .then((value) => cubitProfile
                                                    ?.getProfile(context));
                                          },
                                        );
                                      },
                                    );
                                    await cubitProfile?.getProfile(context);
                                  });
                            },
                          ),
                        ],
                      ),
                    );
                  });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
