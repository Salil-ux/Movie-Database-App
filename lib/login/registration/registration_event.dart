import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends RegistrationEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterUser({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

}
