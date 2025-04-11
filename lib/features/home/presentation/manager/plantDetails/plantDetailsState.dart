import 'package:riwaa/features/home/data/models/homeModel.dart';

class PlantDetailsState {
  final PlantDetailsStatus status;
  final Plant? plant;
  final String? message;
  final String? error;
  final bool changed;

  const PlantDetailsState({
    this.status = PlantDetailsStatus.initial,
    this.plant,
    this.message,
    this.error,
    this.changed = false
  });

  PlantDetailsState copyWith({
    PlantDetailsStatus? status,
    Plant? plant,
    String? message,
    String? error,
    bool? changed
  }) {
    return PlantDetailsState(
      status: status ?? this.status,
      plant: plant ?? this.plant,
      message: message,
      error: error,
      changed: changed ?? this.changed
    );
  }

  @override
  String toString() {
    return 'PlantDetailsState: $status';
  }
}

enum PlantDetailsStatus {
  initial,
  loading,
  loaded,
  failure,
  deleting,
  deleteSuccess,
  deleteFailure,
  watering,
  wateringSuccess,
  wateringFailure
}

// abstract class PlantDetailsStates {}
// class PlantDetailsInitial extends PlantDetailsStates {}

// class GetPlantDetailsLoading extends PlantDetailsStates {}
// class GetPlantDetailsSuccess extends  PlantDetailsStates {
//   final Plant plant;
//   GetPlantDetailsSuccess(this.plant);
// }
// class GetPlantDetailsFailure extends PlantDetailsStates {
//   final String error;
//   GetPlantDetailsFailure(this.error);
// }

// class DeletePlantLoading extends PlantDetailsStates {}
// class DeletePlantSuccess extends PlantDetailsStates {
//   final String message;
//   DeletePlantSuccess(this.message);
// }
// class DeletePlantFailure extends PlantDetailsStates {
//   final String error;
//   DeletePlantFailure(this.error);
// }