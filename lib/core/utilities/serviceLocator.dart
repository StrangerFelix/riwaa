import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:riwaa/core/utilities/apiService.dart';
import 'package:riwaa/core/utilities/firebaseService.dart';
import 'package:riwaa/features/auth/data/repository/authRepo.dart';
import 'package:riwaa/features/home/data/repositories/addPlantRepo.dart';
import 'package:riwaa/features/home/data/repositories/homeRepo.dart';
import 'package:riwaa/features/home/data/repositories/plantDetailsRepo.dart';
import 'package:riwaa/features/settings/data/repository/settingsRepo.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  final firebaseService = FirebaseService.initialize();
  getIt.registerSingleton<FirebaseService>(
    firebaseService
  );
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      getIt.get<FirebaseService>()
    )
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepository(
      getIt.get<FirebaseService>()
    )
  );
  getIt.registerLazySingleton<AddPlantRepository>(
    () => AddPlantRepository(
      getIt.get<FirebaseService>()
    )
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepository(
      getIt.get<FirebaseService>(),
      getIt.get<ApiService>()
    )
  );
  getIt.registerLazySingleton<PlantDetailsRepository>(
    () => PlantDetailsRepository(
      getIt.get<FirebaseService>()
    )
  );
}