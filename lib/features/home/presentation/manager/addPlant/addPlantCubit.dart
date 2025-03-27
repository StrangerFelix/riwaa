import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/features/home/data/repositories/addPlantRepo/addPlantRepo.dart';
import 'package:riwaa/features/home/presentation/manager/addPlant/addPlantStates.dart';

class AddPlantCubit extends Cubit<AddPlantStates> {
  final AddPlantRepository _addPlantRepository;
  AddPlantCubit(this._addPlantRepository) : super(AddPlantInitial());

  void checkIfPlantExists(String uId) async {
    emit(AddPlantLoading());
    bool isPlantExisted = await _addPlantRepository.checkIfPlantExists(uId);
    emit(AddPlantCheck(isPlantExisted));
  }
  Future addPlant({
    required String name,
    required String type,
    required String uId,
    required bool isPlantExisted
  }) async{
    emit(AddPlantLoading());
    var data = await _addPlantRepository.addPlant(
      name: name, 
      type: type, 
      uId: uId, 
      isPlantExisted: isPlantExisted
    );
    data.fold(
      (error) => emit(AddPlantFailure(error.toString())), 
      (success) => emit(AddPlantSuccess(success))
    );
  }
   
}