import 'package:flutter/foundation.dart';

@immutable
abstract class RegisterBlocState {}

class RegisterBlocInitState extends RegisterBlocState {}

class RegisterBlocLoadingState extends RegisterBlocState {}

class RegisterBlocSuccessState extends RegisterBlocState {}

class RegisterBlocErrorState extends RegisterBlocState {
  final String message;
  RegisterBlocErrorState({this.message});
}
