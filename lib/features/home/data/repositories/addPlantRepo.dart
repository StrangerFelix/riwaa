import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:riwaa/core/errors/addPlantExceptions.dart';
import 'package:riwaa/core/utilities/firebaseService.dart';

class AddPlantRepository {
  final FirebaseService _firebaseService;
  AddPlantRepository(this._firebaseService);

  
  Future<bool> checkIfPlantExists(String uId) async {
    try {
      DocumentSnapshot doc = await _firebaseService.firestore.collection('devices').doc(uId).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  Future<Either<Exception,String>> addPlant({
    required String name,
    required String type,
    required String uId,
    required bool isPlantExisted,
  }) async {
    try {

      // DateTime iraqiTime = DateTime.now().toUtc().add(const Duration(hours: 3));
      String? userId = _firebaseService.firebaseAuth.currentUser?.uid;
      if (userId == null) {
        throw Exception('حدث خطأ ما!');
      }
      if (!isPlantExisted) {
        await _firebaseService.firestore.collection('devices').doc(uId).set({
          'name': name,
          'type': type,
          'first_owner' : userId,
          'time_added': FieldValue.serverTimestamp(),
          'uId': uId,
          'info': {
            'moisture': -1,
            'humidity': -1,
            'temperature': -49
          },
          'settings': {
            'moisture_min': 35,
            'moisture_max': 75,
          }
        });
        DatabaseReference dbRef = _firebaseService.firebaseDatabase.ref('/devices/$uId');
        await dbRef.update({
          'isAddedToFirestore': true  
        });
      }
      DocumentReference userDocRef = _firebaseService.firestore.collection('users').doc(userId);
      DocumentSnapshot userDoc = await userDocRef.get();
      // DocumentSnapshot devicesDoc = await _firebaseService.firestore.collection('users').doc(userId).get();

      List<dynamic> devices = userDoc['devices'] ?? [];
      if (devices.contains(uId)) {
        throw PlantAlreadyAddedException('هذه النبتة مضافة مسبقاً');
      } else {
        devices.add(uId);
        await userDocRef.update({
          'devices': devices
        });
      }

      return right('تمت الإضافة بنجاح');
    } on PlantAlreadyAddedException catch (e) {
      return left(e);
    } on Exception catch (e) {
      return left(e);
    } 
  }
}