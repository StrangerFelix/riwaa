import 'package:firebase_auth/firebase_auth.dart';

Exception getAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('لا يوجد مستخدم بهذا البريد الالكتروني');
      case 'wrong-password':
        return Exception('كلمة السر خطأ');
      case 'email-already-in-use':
        return Exception('هذا البريد الالكتروني مستخدم سابقا');
      case 'weak-password':
        return Exception('كلمة السر ضعيفة');
      case 'invalid-email':
        return Exception('هذا البريد الالكتروني غير صحيح');
      case 'operation-not-allowed':
        return Exception('Email/password accounts are not enabled.');
      case 'user-disabled':
        return Exception('This user has been disabled.');
      case 'too-many-requests':
        return Exception('حدث خطأ, الرجاء اعادة المحاولة');
      default:
        return Exception(e.message ?? 'حدث خطأ, الرجاء اعادة المحاولة');
    }
  }