import 'package:riwaa/features/home/data/models/homeModel.dart';

abstract class PlantDetailsStates {}
class PlantDetailsInitial extends PlantDetailsStates {}

class GetPlantDetailsLoading extends PlantDetailsStates {}
class GetPlantDetailsSuccess extends  PlantDetailsStates {
  final Plant plant;
  GetPlantDetailsSuccess(this.plant);
}
class GetPlantDetailsFailure extends PlantDetailsStates {
  final String error;
  GetPlantDetailsFailure(this.error);
}