import 'package:dartz/dartz.dart';
import 'package:riwaa/core/utilities/firebaseService.dart';
import 'package:riwaa/features/settings/data/models/userModel.dart';

class SettingsRepository {
  SettingsRepository (this._firebaseService);
  final FirebaseService _firebaseService;

  Future signOut() async{
    await _firebaseService.firebaseAuth.signOut();
  }

  Future <Either<Exception,UserModel>> getUserData (String uId) async{
    try {
      UserModel? userModel;
      var data = await _firebaseService.firestore.collection('users').doc(uId).get();
      if (data.data() != null) {
        userModel = UserModel.fromJson(data.data()!);
      } else {
        throw Exception('حدث خطأ ما');
      }
      return right(userModel);
    } on Exception catch (e) {
      return left(e);
    }
  }
}