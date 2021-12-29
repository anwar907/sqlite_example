import 'package:flutter/foundation.dart';
import 'package:majootestcase/models/user.dart';

@immutable
abstract class LoginEvent {}

class StartEvent extends LoginEvent {}

class LoginSignEvent extends LoginEvent {
  final User user;
  
  LoginSignEvent({this.user});
}
