import 'package:bloc/bloc.dart';
import 'package:chat_app/data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
   final AuthService authService;
  AuthCubit(this.authService) : super(AuthInitial());

  Future<void> loginUser({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await authService.login(email: email,password: password);
      emit(LoginSuccess(email));
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(AuthFailure('User not found'));
      } else if (ex.code == 'wrong-password') {
        emit(AuthFailure('Wrong password'));
      } else {
        emit(AuthFailure('Firebase error: ${ex.message}'));
      }
    } catch (e) {
      emit(AuthFailure('Unexpected error occurred'));
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      await authService.register(email: email, password: password);
      emit(RegisterSuccess());
    } catch (e) {
      emit(AuthFailure("Register failed: ${e.toString()}"));
    }
  }

  void logout() {
    authService.logout();
    emit(AuthLoggedOut());
  }


}
