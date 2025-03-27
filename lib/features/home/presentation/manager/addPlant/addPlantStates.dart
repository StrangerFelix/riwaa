abstract class AddPlantStates {}
class AddPlantInitial extends AddPlantStates {}

class AddPlantCheck extends AddPlantStates {
  final bool isPlantExisted;
  AddPlantCheck(this.isPlantExisted);
}

class AddPlantLoading extends AddPlantStates {}
class AddPlantSuccess extends AddPlantStates {
  final String message;
  AddPlantSuccess(this.message);
}
class AddPlantFailure extends AddPlantStates {
  final String message;
  AddPlantFailure(this.message);
}