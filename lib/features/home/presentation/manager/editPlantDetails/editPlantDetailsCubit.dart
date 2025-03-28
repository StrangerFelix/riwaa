import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/features/home/data/repositories/plantDetailsRepo.dart';
import 'package:riwaa/features/home/presentation/manager/editPlantDetails/editPlantDetailsStates.dart';

class EditPlantDetailsCubit extends Cubit<EditPlantDetailsStates> {
  final PlantDetailsRepository _plantDetailsRepository;
  EditPlantDetailsCubit(this._plantDetailsRepository): super (EditPlantDetailsInitial());

  void editPlant ({
    required String name,
    required String type,
    required double minMoisture,
    required double maxMoisture,
    required String? uId
  }) async{
    emit(EditPlantDetailsLoading());
    var data = await _plantDetailsRepository.editPlant(
      name: name, 
      type: type, 
      minMoisture: minMoisture, 
      maxMoisture: maxMoisture, 
      uId: uId
    );
    data.fold(
      (exception) => emit(EditPlantDetailsFailure(exception.toString())), 
      (message) => emit(EditPlantDetailsSuccess(message))
    );
  }

}