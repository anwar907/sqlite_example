import 'package:flutter/foundation.dart';
import 'package:majootestcase/models/movie_response.dart';

@immutable
abstract class HomeEvent {}

class HomeStartEvent extends HomeEvent {}

class HomeLoadingEvent extends HomeEvent {}

class HomeLoadedEvent extends HomeEvent {
  final MovieResponse data;
  HomeLoadedEvent({this.data});
}
