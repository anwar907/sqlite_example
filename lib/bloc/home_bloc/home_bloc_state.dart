import 'package:flutter/foundation.dart';
import 'package:majootestcase/models/movie_response.dart';

@immutable
abstract class HomeBlocState {}

class HomeBlocInitialState extends HomeBlocState {}

class HomeBlocLoadingState extends HomeBlocState {}

class HomeBlocLoadedState extends HomeBlocState {
  final MovieResponse data;
  HomeBlocLoadedState(this.data);
}

class HomeBlocErrorState extends HomeBlocState {
  final String message;

  HomeBlocErrorState({this.message});
}
