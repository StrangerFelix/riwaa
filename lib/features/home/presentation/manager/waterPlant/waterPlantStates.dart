abstract class WaterPlantStates {}

class WaterPlantInitial extends WaterPlantStates {}

class WaterPlantLoading extends WaterPlantStates {}
class WaterPlantSuccess extends WaterPlantStates {}
class WaterPlantFailure extends WaterPlantStates {
  final String error;
  WaterPlantFailure({required this.error});
}