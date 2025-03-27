import 'package:get_it/get_it.dart';
import 'package:riwaa/core/utilities/firebaseService.dart';
import 'package:riwaa/features/auth/data/repository/authRepo.dart';
import 'package:riwaa/features/home/data/repositories/addPlantRepo/addPlantRepo.dart';
import 'package:riwaa/features/home/data/repositories/homeRepo/homeRepo.dart';
import 'package:riwaa/features/settings/data/repository/settings/settingsRepo.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  final firebaseService = FirebaseService.initialize();
  getIt.registerSingleton<FirebaseService>(
    firebaseService
  );
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
      getIt.get<FirebaseService>()
    )
  );
}