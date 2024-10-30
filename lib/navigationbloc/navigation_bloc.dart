import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<NavigateToHome>((event, emit) {
      emit(const NavigationChanged(0));
    });
    on<NavigateToPopular>((event, emit) {
      emit(const NavigationChanged(1));
    });
    on<NavigateToSettings>((event, emit) {
      emit(const NavigationChanged(2));
    });
    on<NavigateToSearch>((event, emit) {
      emit(const NavigationChanged(3));
    });
  }
}
