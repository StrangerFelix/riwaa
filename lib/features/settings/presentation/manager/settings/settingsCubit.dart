import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riwaa/features/settings/data/repository/settings/settingsRepo.dart';
import 'package:riwaa/features/settings/presentation/manager/settings/settingsStates.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit(this._settingsRepository) : super (SettingsInitial());
  final SettingsRepository _settingsRepository;

  void signOut () async{
    try {
      emit(SignOutLoading());
      await Future.delayed(const Duration(milliseconds: 1000));
      await _settingsRepository.signOut();
      emit(SignOutSuccess());
    } catch (e){
      emit(SignOutFailure(e.toString()));
    }
  }
}