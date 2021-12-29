import 'package:flutter/foundation.dart';

@immutable
abstract class RegisterEvent {}

class StartEvent extends RegisterEvent {}

class RegisterDataEvent extends RegisterEvent {
  final String nama;
  final String email;
  final String password;

  RegisterDataEvent({this.nama, this.email, this.password});
}
