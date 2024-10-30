//import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegisterUser>(_onRegisterUser);
  }

  void _onRegisterUser(
      RegisterUser event, Emitter<RegistrationState> emit) async {
    emit(RegistrationLoading());

    await Future.delayed(const Duration(seconds: 2));

    if (event.password != event.confirmPassword) {
      emit(const RegistrationFailure(error: "Passwords do not match"));
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', event.name);
      await prefs.setString('email', event.email);
      await prefs.setString('password', event.password);

      emit(const RegistrationSuccess(message: "Registration successful"));
    } catch (error) {
      emit(const RegistrationFailure(error: "Failed to register user"));
    }
  }
}
