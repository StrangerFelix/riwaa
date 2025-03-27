import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:riwaa/core/utilities/firebaseService.dart';
import 'package:riwaa/features/home/data/models/homeModel.dart';

class HomeRepository {
  final FirebaseService _firebaseService;
  HomeRepository(this._firebaseService);

  Future<Either<Exception,HomeModel>> getHomeData() async {
    try {
      var userData = await _firebaseService
        .firestore
        .collection('users')
        .doc(
          _firebaseService.firebaseAuth.currentUser!.uid
        ).get();
      List? devices = userData.data()?['devices'];
      List? plants = [];
      // print('Devices: $devices');
      if (devices != null && devices.isNotEmpty) {
        List plantsSnapshots = await getPlants(devices, _firebaseService.firestore);
        // print('Plants:');
        // print(plants[0].data());
        // print(plants[1].data());
        for (DocumentSnapshot plant in plantsSnapshots) {
          if (plant.data() != null) {
            plants.add(plant.data());
          }
        }
      }
      HomeModel homeModel;
      homeModel = HomeModel.fromJson(userData.data(),plants);
      return right(homeModel);
    } on Exception catch (e) {
      return left(e);
    }
  }

  Future<List<DocumentSnapshot>> getPlants(List devicesIds,FirebaseFirestore firestore) async {
    final List<DocumentSnapshot> plants = [];
    
    // Process in batches of 10 (Firestore's limitation for whereIn)
    for (int i = 0; i < devicesIds.length; i += 10) {
      final List batch = devicesIds.sublist(
        i,
        i + 10 > devicesIds.length ? devicesIds.length : i + 10
      );
      
      final QuerySnapshot querySnapshot = await firestore
          .collection('devices')
          .where(FieldPath.documentId, whereIn: batch)
          .get();
      
      plants.addAll(querySnapshot.docs);
    } 
  
    return plants;
  }

}