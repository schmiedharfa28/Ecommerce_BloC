part of 'updateprofile_cubit.dart';

@immutable
abstract class UpdateprofileState {}

class UpdateprofileInitial extends UpdateprofileState {}

class UpdateProfileLoading extends UpdateprofileState {}

class UpdateProfieSuccess extends UpdateprofileState {
  final ResUpdateProfile? resUpdateProfile;
  UpdateProfieSuccess(this.resUpdateProfile);
}

class UpdateProfileError extends UpdateprofileState {
  final String? message;
  UpdateProfileError(this.message);
}
