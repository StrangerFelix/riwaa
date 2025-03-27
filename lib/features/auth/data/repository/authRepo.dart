import 'package:firebase_auth/firebase_auth.dart';
import 'package:riwaa/core/errors/authExceptions.dart';
import 'package:riwaa/core/utilities/firebaseService.dart';

class AuthRepository {
  final FirebaseService firebaseService;

  AuthRepository(this.firebaseService);

  User? get currentUser => firebaseService.firebaseAuth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => firebaseService.firebaseAuth.authStateChanges();

  Future<void> signUp({
    required String email, 
    required String password,
    required String name,
  }) async {
    try {
      // Create user in Firebase Auth
      UserCredential userCredential = await firebaseService.firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Add user data to Firestore
      // await firebaseService.firestore.collection('users').doc(userCredential.user!.uid).delete();
      await firebaseService.firestore.collection('users').doc(userCredential.user!.uid).set({
        'uId': userCredential.user!.uid,
        'email': email,
        'name': name,
        'devices': []
      },);
    } on FirebaseAuthException catch (e) {
      throw getAuthException(e);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await firebaseService.firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw getAuthException(e);
    }
  }

  Future<void> signOut() async {
    await firebaseService.firebaseAuth.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await firebaseService.firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw getAuthException(e);
    }
  }
}