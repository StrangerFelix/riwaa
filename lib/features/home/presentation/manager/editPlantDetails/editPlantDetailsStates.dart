abstract class EditPlantDetailsStates {}
class EditPlantDetailsInitial extends EditPlantDetailsStates {}

class EditPlantDetailsLoading extends EditPlantDetailsStates {}
class EditPlantDetailsSuccess extends EditPlantDetailsStates {
  final String message;
  EditPlantDetailsSuccess(this.message);
}
class EditPlantDetailsFailure extends EditPlantDetailsStates {
  final String error;
  EditPlantDetailsFailure(this.error);
}