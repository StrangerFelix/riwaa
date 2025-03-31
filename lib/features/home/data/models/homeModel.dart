import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riwaa/features/home/data/models/weatherModel.dart';

class HomeModel {
  String? username;
  List? devices;
  List<Plant>? plants;
  WeatherModel? weather;

  HomeModel({ 
    this.username,
    this.devices,
    this.plants,
    this.weather,
  });

  HomeModel.fromJson(Map<String, dynamic>? userData,List plantsData,WeatherModel? weatherdata) {
    username = userData?['name'] ?? "";
    devices = userData?['devices'] ?? [];
    weather = weatherdata;
    plants = [];
    for (var plant in plantsData) {
      if (plant != null) {
        plants?.add(Plant.fromJson(plant));
      }
    }
  }
  void userDataFromJson(Map<String, dynamic> json) {
    username = json['first_owner'];
    devices = json['devices'].cast<String>();
  }
  void plantsDataFromJson(Map<String, dynamic> json) {
    if (json['plants'] != null) {
      plants = <Plant>[];
      json['plants'].forEach((v) {
        plants!.add(Plant.fromJson(v));
      });
    } else {
      plants = [];
    }
  }

}

class Plant {
  String? firstOwner;
  Timestamp? timeAdded;
  String? type;
  String? uId;
  String? name;
  Info? info;
  Settings? settings;

  Plant(
      {this.firstOwner,
      this.timeAdded,
      this.type,
      this.uId,
      this.name,
      this.info,
      this.settings});

  Plant.fromJson(Map<String, dynamic> json) {
    firstOwner = json['first_owner'];
    timeAdded = json['time_added'];
    type = json['type'];
    uId = json['uId'];
    name = json['name'];
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    settings = json['settings'] != null
        ? Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_owner'] = firstOwner;
    data['time_added'] = timeAdded;
    data['type'] = type;
    data['uId'] = uId;
    data['name'] = name;
    if (info != null) {
      data['info'] = info!.toJson();
    }
    if (settings != null) {
      data['settings'] = settings!.toJson();
    }
    return data;
  }
}

class Info {
num? moisture;
  num? temperature;
  num? humidity;

  Info({this.moisture, this.temperature, this.humidity});

  Info.fromJson(Map<String, dynamic> json) {
    moisture = json['moisture'];
    temperature = json['temperature'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['moisture'] = moisture;
    data['temperature'] = temperature;
    data['humidity'] = humidity;
    return data;
  }
}

class Settings {
  int? moistureMin;
  int? moistureMax;

  Settings({this.moistureMin, this.moistureMax});

  Settings.fromJson(Map<String, dynamic> json) {
    moistureMin = json['moisture_min'];
    moistureMax = json['moisture_max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['moisture_min'] = moistureMin;
    data['moisture_max'] = moistureMax;
    return data;
  }
}
