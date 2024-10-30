import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUser>(_onLoginUser);
  }

  void _onLoginUser(LoginUser event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final storedEmail = prefs.getString('email');
      final storedPassword = prefs.getString('password');

      if (storedEmail == null || storedPassword == null) {
        emit(LoginFailure('No user found. Please register first.'));
        return;
      }

      if (storedEmail == event.email && storedPassword == event.password) {
        emit(LoginSuccess('Login Successful'));
      } else {
        emit(LoginFailure('Invalid email or password.'));
      }
    } catch (e) {
      emit(LoginFailure('Login failed. Please try again.'));
    }
  }
}
