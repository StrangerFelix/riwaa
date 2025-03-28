import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:riwaa/core/utilities/firebaseService.dart';
import 'package:riwaa/features/home/data/models/homeModel.dart';

class PlantDetailsRepository {
  final FirebaseService _firebaseService;
  PlantDetailsRepository(this._firebaseService);

  Future<Either<Exception,String>> editPlant ({
    required String name,
    required String type,
    required double minMoisture,
    required double maxMoisture,
    required String? uId
  }) async{
    try {
      if (uId == null) {
        throw Exception('حدث خطأ ما');
      }
      Map <String,dynamic> data = {
        'name': name,
        'type': type,
        'settings': {
          'moisture_max': maxMoisture.toInt(),
          'moisture_min': minMoisture.toInt()
        },
      };
      await _firebaseService.firestore.collection('devices').doc(uId).update(data);
      return right('تم التعديل بنجاح');
    } on Exception catch (e) {
      return left(e);
    }
  }
  Future<Either<Exception,Plant>> getPlant(String uId) async{
    try {
      Plant plant;
      var data = await _firebaseService.firestore.collection('devices').doc(uId).get();
      if (data.data() != null) {
        plant = Plant.fromJson(data.data()!);
      } else {
        throw Exception('حدث خطأ ما');
      }
      return right(plant);
    } on Exception catch (e) {
      return left(e);
    }
  }

  Future<Either<Exception,String>> deletePlant({required String userId, required String deviceId}) async{
    try {
      await _firebaseService.firestore.collection('users').doc(userId).update({
        'devices': FieldValue.arrayRemove([deviceId]),  // Removing item from array
      });
      return right('تم حذف النبات بنجاح');
    } on Exception catch (e) {
      return left(e);
    }
  }

}