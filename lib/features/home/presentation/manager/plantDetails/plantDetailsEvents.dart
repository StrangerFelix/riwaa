abstract class PlantDetailsEvents {}

class GetPlantDetailsEvent extends PlantDetailsEvents {
  final String plantId;
  final bool? changed;
  GetPlantDetailsEvent({required this.plantId,this.changed});
}

class DeletePlantEvent extends PlantDetailsEvents {
  final String plantId;
  final String userId;
  DeletePlantEvent({required this.plantId,required this.userId});
}

class WaterPlantEvent extends PlantDetailsEvents {
  final String plantId;
  WaterPlantEvent(this.plantId);
}

class ResetPlantDetailsEvent extends PlantDetailsEvents {}