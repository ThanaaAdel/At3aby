import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/profile_lawyer/cubit/profile_lawyer_state.dart';
import 'package:ataaby/features/lawyer/profile_lawyer/data/repo/profile_lawyer.dart';
import 'package:ataaby/features/login/data/models/login_model_lawyer.dart';

class ProfileLawyerCubit extends Cubit<ProfileLawyerState> {
  ProfileLawyerCubit(this.profileLawyerRepo) : super(ProfileLawyerInitial()){
    getDataFromSharedPreferences();
  }
  ProfileLawyerRepo profileLawyerRepo;

  bool statusOfSwitch = false;
  void changeStatusOfSwitch(bool value) {
    statusOfSwitch = value;
    emit(ProfileLawyerSwitchState());
  }
  LoginModelLawyer? loginModelLawyer;
  Future<void> getDataFromSharedPreferences() async {
    emit(GetDataStateLoading());
    loginModelLawyer = await Preferences.instance.getLawyerModel();
    emit(GetDataStateLoaded());
  }


}
