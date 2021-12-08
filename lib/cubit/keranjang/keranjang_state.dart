part of 'keranjang_cubit.dart';

@immutable
abstract class KeranjangState {}

class KeranjangInitial extends KeranjangState {}

class KeranjangLoading extends KeranjangState {}

class KeranjangSuccess extends KeranjangState {
  final ResKeranjang? resKeranjang;
  KeranjangSuccess(this.resKeranjang);
}

class KeranjangError extends KeranjangState {
  final String? message;
  KeranjangError(this.message);
}
