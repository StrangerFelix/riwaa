import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riwaa/core/errors/apiExceptions.dart';
import 'package:riwaa/core/utilities/apiService.dart';
import 'package:riwaa/core/utilities/firebaseService.dart';
import 'package:riwaa/features/home/data/models/homeModel.dart';
import 'package:riwaa/features/home/data/models/weatherModel.dart';

class HomeRepository {
  final FirebaseService _firebaseService;
  final ApiService _apiService;
  HomeRepository(this._firebaseService,this._apiService);

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

        for (DocumentSnapshot plant in plantsSnapshots) {
          if (plant.data() != null) {
            plants.add(plant.data());
          }
        }
      }
      
      HomeModel homeModel;
      WeatherModel? weatherModel;
      
      await requestLocationAndExecute( (pos) async{
        var weatherData = await getWeatherApiData(lat: "${pos.latitude}",lon: "${pos.longitude}");
        weatherData.fold(
          (exception) => throw exception, 
          (model) => weatherModel = model 
        );
      });
      homeModel = HomeModel.fromJson(userData.data(),plants,weatherModel);
      return right(homeModel);
    } on Exception catch (e) {
      return left(e);
    }
  }
  

  Future<void> requestLocationAndExecute(Future<void> Function(Position) onSuccess) async {
    // Check permission status
    LocationPermission permission = await Geolocator.checkPermission();
    
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );

    // Request permission if not granted
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    // Execute function if permission granted
    if (permission == LocationPermission.whileInUse || 
        permission == LocationPermission.always) {
        
      final position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
      await onSuccess(position);
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


  Future <Either<ApiExceptions,WeatherModel>> getWeatherApiData ({required String lat,required String lon}) async {
    try {
      var data = await _apiService.get(
        endpoint: 'forecast.json?key=${_apiService.apiKey}&q=$lat,$lon&days=1&hour=now'
      );
      WeatherModel? model = WeatherModel.fromJson(data);
      return right(model);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerExceptins.fromDioException(e));
      } else {
        return left(ServerExceptins(e.toString()));
      }
    }
  }
}