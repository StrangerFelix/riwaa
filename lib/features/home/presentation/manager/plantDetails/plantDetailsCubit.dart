import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/features/home/data/repositories/plantDetailsRepo.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsStates.dart';

class PlantDetailsCubit extends Cubit<PlantDetailsStates> {
  final PlantDetailsRepository _plantDetailsRepository;
  PlantDetailsCubit (this._plantDetailsRepository) : super(PlantDetailsInitial());

  void getPlant (String uId) async{
    emit(GetPlantDetailsLoading());
    var data = await _plantDetailsRepository.getPlant(uId);
    data.fold(
      (exception) => emit(GetPlantDetailsFailure(exception.toString())), 
      (plant) => emit(GetPlantDetailsSuccess(plant))
    );
  }
  
  
}