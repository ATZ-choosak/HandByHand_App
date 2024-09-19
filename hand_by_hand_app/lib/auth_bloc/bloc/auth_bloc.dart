import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hand_by_hand_app/api/auth/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService auth;

  AuthBloc({required this.auth}) : super(AuthInitial()) {
    on<LoginEvent>(_handleLoginEvent);
    on<RegisterEvent>(_handleRegisterEvent);
  }

  Future<void> _handleLoginEvent(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await auth.login(event);
    if (result.status) {
      emit(AuthSuccess(result.message));
    } else {
      emit(AuthFailure(result.message));
    }
  }

  Future<void> _handleRegisterEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await auth.register(event);
    if (result.status) {
      emit(AuthSuccess(result.message));
    } else {
      emit(AuthFailure(result.message));
    }
  }
}
