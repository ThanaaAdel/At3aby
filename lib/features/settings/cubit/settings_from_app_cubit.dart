import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/settings/cubit/setting_from_app_state.dart';
import 'package:ataaby/features/settings/data/models/settings_from_app_model.dart';
import 'package:ataaby/features/settings/data/repos/settings_from_app.dart';

class GetSettingsFromAppCubit extends Cubit<GetSettingsFromAppState> {
  GetSettingsFromAppCubit(this.getSettingsFromAppRepo)
      : super(GetSettingsFromAppState()) {
    getSettingFromApp();
  }
  GetSettingsFromAppRepo getSettingsFromAppRepo;
  GetSettingsFromAppModel? getSettingsFromAppModel;
  Future<void> getSettingFromApp() async {
    emit(LoadingGetSettingFromAppState());
    final res = await getSettingsFromAppRepo.getSettingsFromApp();

    res.fold((l) {
      emit(ErrorGetSettingFromAppState());
    }, (r) {
      getSettingsFromAppModel = r;
      //! 
      emit(LoadedGetSettingFromAppState());
    });
  }
}
