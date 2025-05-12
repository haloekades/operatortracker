part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String nik;
  LoginSubmitted(this.nik);
}