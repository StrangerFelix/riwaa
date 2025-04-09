import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/features/home/data/repositories/plantDetailsRepo.dart';
import 'package:riwaa/features/home/presentation/manager/waterPlant/waterPlantStates.dart';

class WaterPlantCubit extends Cubit<WaterPlantStates> {
  final PlantDetailsRepository _plantDetailsRepository;
  WaterPlantCubit(this._plantDetailsRepository) : super(WaterPlantInitial());

  void waterPlant(String deviceId) async{
    emit(WaterPlantLoading());
    var response = await _plantDetailsRepository.waterPlant(deviceId: deviceId);
    response.fold(
      (exception) => emit(WaterPlantFailure(error: exception.toString())),
      (message) => emit(WaterPlantSuccess())
    );
  }
}
