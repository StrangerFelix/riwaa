import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/features/home/data/repositories/plantDetailsRepo.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsEvents.dart';
import 'package:riwaa/features/home/presentation/manager/plantDetails/plantDetailsState.dart';

class PlantDetailsBloc extends Bloc<PlantDetailsEvents, PlantDetailsState> {
  final PlantDetailsRepository _plantDetailsRepository;
  PlantDetailsBloc(this._plantDetailsRepository) : super(const PlantDetailsState()) {
    on<PlantDetailsEvents>((event,emit) async{
      if (event is GetPlantDetailsEvent) {
        emit(state.copyWith(status: PlantDetailsStatus.loading));
        var data = await _plantDetailsRepository.getPlant(event.plantId);
        data.fold(
          (exception) => emit(state.copyWith(status: PlantDetailsStatus.failure, error: exception.toString())), 
          (plant) => emit(state.copyWith(status: PlantDetailsStatus.loaded, plant: plant,changed: event.changed))
        );
      } else if (event is DeletePlantEvent) {
        emit(state.copyWith(status: PlantDetailsStatus.deleting));
        var data = await _plantDetailsRepository.deletePlant(userId: event.userId, deviceId: event.plantId);
        data.fold(
          (exception) => emit(state.copyWith(status: PlantDetailsStatus.deleteFailure, error: exception.toString())), 
          (message) => emit(state.copyWith(status: PlantDetailsStatus.deleteSuccess, message: message))
        );
      } else if (event is WaterPlantEvent) {
        emit(state.copyWith(status: PlantDetailsStatus.watering));
        var response = await _plantDetailsRepository.waterPlant(deviceId: event.plantId);
        response.fold(
          (exception) => emit(state.copyWith(status: PlantDetailsStatus.wateringFailure, error: exception.toString())),
          (message) => emit(state.copyWith(status: PlantDetailsStatus.wateringSuccess, message: message))
        );
      } else if (event is ResetPlantDetailsEvent) {
        emit(state.copyWith(changed: false));
      }
    });
  }
}

// class PlantDetailsCubit extends Cubit<PlantDetailsState> {
//   final PlantDetailsRepository _plantDetailsRepository;
//   PlantDetailsCubit(this._plantDetailsRepository) : super(const PlantDetailsState());

//   void getPlant(String uId,{bool? changed}) async {
//     emit(state.copyWith(status: PlantDetailsStatus.loading));
//     var data = await _plantDetailsRepository.getPlant(uId);
//     data.fold(
//       (exception) => emit(state.copyWith(status: PlantDetailsStatus.failure, error: exception.toString())), 
//       (plant) => emit(state.copyWith(status: PlantDetailsStatus.loaded, plant: plant,changed: changed))
//     );
//   }

//   // void resetCubit() {
//   //   emit(const PlantDetailsState());
//   // }
  
//   void deletePlant({required String userId, required String deviceId}) async {
//     emit(state.copyWith(status: PlantDetailsStatus.deleting));
//     var data = await _plantDetailsRepository.deletePlant(userId: userId, deviceId: deviceId);
//     data.fold(
//       (exception) => emit(state.copyWith(status: PlantDetailsStatus.deleteFailure, error: exception.toString())), 
//       (message) => emit(state.copyWith(status: PlantDetailsStatus.deleteSuccess, message: message))
//     );
//   }

//   void waterPlant(String deviceId) async{
//     emit(state.copyWith(status: PlantDetailsStatus.watering));
//     var response = await _plantDetailsRepository.waterPlant(deviceId: deviceId);
//     response.fold(
//       (exception) => emit(state.copyWith(status: PlantDetailsStatus.wateringFailure, error: exception.toString())),
//       (message) => emit(state.copyWith(status: PlantDetailsStatus.wateringSuccess, message: message))
//     );
//   }
// }

// class PlantDetailsCubit extends Cubit<PlantDetailsStates> {
//   final PlantDetailsRepository _plantDetailsRepository;
//   PlantDetailsCubit (this._plantDetailsRepository) : super(PlantDetailsInitial());

//   void getPlant (String uId) async{
//     emit(GetPlantDetailsLoading());
//     var data = await _plantDetailsRepository.getPlant(uId);
//     data.fold(
//       (exception) => emit(GetPlantDetailsFailure(exception.toString())), 
//       (plant) => emit(GetPlantDetailsSuccess(plant))
//     );
//   }
//   void resetCubit () {
//     emit(PlantDetailsInitial());
//   }
  
//   void deletePlant ({required String userId,required String deviceId}) async {
//     emit(DeletePlantLoading());
//     var data = await _plantDetailsRepository.deletePlant(userId: userId, deviceId: deviceId);
//     data.fold(
//       (exception) => emit(DeletePlantFailure(exception.toString())), 
//       (message) => emit(DeletePlantSuccess(message))
//     );
//   }

  
// }