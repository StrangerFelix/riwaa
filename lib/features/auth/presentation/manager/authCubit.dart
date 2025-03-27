import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/features/auth/data/repository/authRepo.dart';
import 'package:riwaa/features/auth/presentation/manager/authStates.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit (this._authRepository) : super (AuthInitial());
  final AuthRepository _authRepository;

   Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(RegisterLoading());
    
    try {
      // First create the user in Firebase Auth
      await _authRepository.signUp(
        email: email,
        name: name,
        password: password,
      );
      emit(RegisterSuccess());
    } catch (e) {
      final error = e.toString().replaceFirst("Exception: ", "");
      emit(RegisterFailure(error));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      await _authRepository.signIn(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } catch (e) {
      final error = e.toString().replaceFirst("Exception: ", "");
      emit(LoginFailure(error));
    }
  }
}