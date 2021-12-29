import 'package:flutter/foundation.dart';
import 'package:majootestcase/models/movie_response.dart';

@immutable
abstract class LoginBlocState {}

class LoginBlocInitialState extends LoginBlocState {}

class LoginBlocLoadingState extends LoginBlocState {}

class LoginBlocSuccessState extends LoginBlocState {
  final MovieResponse data;
  LoginBlocSuccessState({this.data});
}

class LoginBlocErrorState extends LoginBlocState {
  final String message;

  LoginBlocErrorState({this.message});
}
