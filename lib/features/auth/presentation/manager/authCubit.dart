import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/features/auth/data/models/userAuthModel.dart';
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
      
      // Then add additional data to Firestore
      final user = _authRepository.currentUser;
      if (user != null) {
        final userModel = UserAuthModel(
          uId: user.uid,
          email: email,
          name: name,
        );
        
        await _authRepository.
            firebaseService.firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toJson());
      }
      
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(e.toString()));
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
      emit(LoginFailure(e.toString()));
    }
  }
}