import 'package:riwaa/core/utilities/firebaseService.dart';

class SettingsRepository {
  SettingsRepository (this.firebase);
  final FirebaseService firebase;

  Future signOut() async{
    await firebase.firebaseAuth.signOut();
  }
}