import 'package:ataaby/core/preferences/preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/choose_type_register.dart';
import 'state.dart';

class ChooseTypeRegisterCubit extends Cubit<ChooseTypeRegisterState> {
  ChooseTypeRegisterCubit(this.api) : super(ChooseTypeRegisterStateInitial());
  ChooseTypeRegisterRepo api;

  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    if (index == 0) {
      prefs.setString('user_type', 'customer');
    } else if (index == 1) {
      prefs.setString('user_type', 'lawyer');
    } else {
      prefs.setString('user_type', '');
    }
    emit(ChangeColorState());
  }
}
