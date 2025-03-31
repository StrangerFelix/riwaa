import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/features/home/data/repositories/homeRepo.dart';
import 'package:riwaa/features/home/presentation/manager/home/homeStates.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeRepository _homeRepository;
  HomeCubit(this._homeRepository) : super(HomeInitial());

  void getHomeData() async {
    emit (HomeLoading());
    var data = await _homeRepository.getHomeData();
    data.fold(
      (error) => emit(
        HomeFailure(
          error.toString(),
          isWeatherException: error.toString() == "Exception: Error getting location: Exception: Location permissions are permanently denied" ? true : false
        )
      ),
      (homeModel) => emit(HomeLoaded(homeModel)),
    );
  }
}