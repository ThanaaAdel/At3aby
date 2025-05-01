import 'dart:async';
import 'dart:developer';
import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/login/screens/login.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/widgets/radio_button.dart';
import '../../lawyer/home_lawyer/data/model/specialist_model.dart';
import '../data/model/city_model.dart';
import '../data/model/country_model.dart';
import '../data/model/levels_model.dart';
import '../data/model/specialities_model.dart';
import '../data/repo/new_register.dart';
import 'state.dart';

class NewRegisterCubit extends Cubit<NewRegisterState> {
  NewRegisterCubit(this.api) : super(NewRegisterStateInitial());
  NewRegisterRepo api;
  TextEditingController verifyController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nationalityNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController lawyerIdController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? selectedDegreeController;
  String? selectedSpecializationController;
  MainCountryModel? mainCountryModel;
  Country? selectedCountryController;
  SingingCharacter? typeSelectedValue;

  int currentStep = 0;
  void goToNextStep() {
    currentStep++;
    emit(IncreaseStepState());
  }

  void goToBackStep() {
    currentStep = 0;
    emit(DecreaseStepState());
  }

  Future<void> getCountries() async {
    emit(LoadingGetCountriesState());
    final res = await api.getCountries();

    res.fold((l) {
      emit(ErrorGetCountriesState());
    }, (r) {
      mainCountryModel = r;
      selectedCountryController = r.data?.countries?.first;
      getCities();
      emit(LoadedGetCountriesState());
    });
  }

  City? selectedCityController;
  MainCityModel? mainCityModel;
  Future<void> getCities() async {
    emit(LoadingGetCitiesState());
    final res = await api.getCities(
      selectedCountryController!.id.toString(),
    );

    res.fold((l) {
      emit(ErrorGetCitiesState());
    }, (r) {
      mainCityModel = r;
      if (r.data!.cities!.isNotEmpty) {
        selectedCityController = r.data?.cities?.first;
      }
      emit(LoadedGetCitiesState());
    });
  }

  Level? selectedLevelController;
  MainLevelsModel? mainLevelsModel;
  Future<void> getLevels() async {
    emit(LoadingGetLevelsState());
    final res = await api.getLevels();

    res.fold((l) {
      emit(ErrorGetLevelsState());
    }, (r) {
      mainLevelsModel = r;
      if (r.data!.levels!.isNotEmpty) {
        selectedLevelController = r.data?.levels?.first;
        selectedSpecialityList.clear();

        getSpecialities();
      }
      emit(LoadedGetLevelsState());
    });
  }

  Speciality? selectedSpecialitController;
  MainSpecialitiesModel? mainSpecialitiesModel;
  List<Speciality> selectedSpecialityList = [];

  addOrRemoveUser(Speciality item) {
    selectedSpecialityList.contains(item)
        ? selectedSpecialityList.remove(item)
        : selectedSpecialityList.add(item);
    emit(ChangeSpecialityListStatee());
  }

  Future<void> getSpecialities() async {
    emit(LoadingGetSpecialityState());
    final res = await api.getSpecialities(
      selectedLevelController!.id.toString(),
    );

    res.fold((l) {
      emit(ErrorGetSpecialityState());
    }, (r) {
      mainSpecialitiesModel = r;
      selectedSpecialityList.clear();
      if (r.data!.specialities!.isNotEmpty) {
        selectedSpecialitController = r.data?.specialities?.first;
      }
      emit(LoadedGetSpecialityState());
    });
  }

  /*
     Navigator.pushNamed(
                                      context, Routes.activateAccountRoute,
                                      arguments: ChooseTypeRegisterArgs(
                                          indexPageClientOrLawyer: widget
                                              .args.indexPageClientOrLawyer,
                                          typeOfVerification: 'register'));
   */

  Future<void> registerAsClient(
      BuildContext context, ChooseTypeRegisterArgs args) async {
    emit(LoadingClientRegisterState());
    final res = await api.registerAsClient(
      name: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
      phone: phoneNumberController.text,
      nationalId: nationalityNumberController.text,
      countryId: selectedCountryController?.id?.toString(),
      cityId: selectedCityController?.id?.toString(),
    );
    res.fold((l) {
      emit(ErrorClientRegisterState());
    }, (r) async {
      if (r.status == 200) {
        await Preferences.instance.setUser(r);
        getDialog(context, args);
        emit(SuccessClientRegisterState());
      } else {
        errorGetBar(r.msg ?? '');
        emit(ErrorClientRegisterState());
      }
    });
  }

  Future<void> registerAsLawyer(
      BuildContext context, ChooseTypeRegisterArgs args) async {
    emit(LoadingLawyerRegisterState());
    final res = await api.registerAsLawyer(
        name: fullNameController.text,
        email: emailController.text,
        selectedSpecialityList: selectedSpecialityList,
        password: passwordController.text,
        phone: phoneNumberController.text,
        nationalId: nationalityNumberController.text,
        countryId: selectedCountryController?.id?.toString() ?? '1',
        cityId: selectedCityController?.id?.toString() ?? '1',
        type: typeSelectedValue == SingingCharacter.individual
            ? 'individual'
            : 'office',
        levelId: selectedLevelController?.id?.toString(),
        //! level id and speciality_ids
        lawyerId: lawyerIdController.text);
    res.fold((l) {
      emit(ErrorLawyerRegisterState());
    }, (r) async {
      if (r.status == 200) {
        await Preferences.instance.setLawyer(r);

        getDialog(context, args);
        emit(SuccessLawyerRegisterState());
      } else {
        errorGetBar(r.msg ?? '');
        emit(ErrorLawyerRegisterState());
      }
    });
  }

  mainRegister(BuildContext context, ChooseTypeRegisterArgs args) async {
    if (args.indexPageClientOrLawyer == 0) {
      registerAsClient(context, args);
    } else {
      registerAsLawyer(context, args);
    }
  }

  getDialog(BuildContext context, ChooseTypeRegisterArgs args) {
    return AwesomeDialog(
      context: context,
      showCloseIcon: false,
      dialogType: DialogType.success,
      dismissOnBackKeyPress: true,
      dismissOnTouchOutside: false,
      animType: AnimType.rightSlide,
      padding: EdgeInsets.all(10.w),
      title: "account_created".tr(),
      btnOkOnPress: () {
        Navigator.pop(context);
        print('5555555555');
        args.indexPageClientOrLawyer == 0
            ? Navigator.pushNamedAndRemoveUntil(
                context, Routes.mainCustomerRoute, (route) => false,
                arguments: ChooseTypeRegisterArgs(indexPageClientOrLawyer: 0))
            : Navigator.pushNamedAndRemoveUntil(
                context, Routes.mainLawyerRoute, (route) => false,
                arguments: ChooseTypeRegisterArgs(indexPageClientOrLawyer: 1));

        verifyController.clear();
        fullNameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        nationalityNumberController.clear();
        phoneNumberController.clear();
        lawyerIdController.clear();
        selectedSpecialityList.clear();
        selectedCityController = null;
      },
      btnOkText: "done".tr(),
    ).show();
  }

  sendClientOtp(
    BuildContext context,
    ChooseTypeRegisterArgs args, {
    bool isResetpassword = false,
    bool sendOtp = false,
  }) async {
    emit(LoadingOtpState());
    final res = await api.sendOtpClient(email: emailController.text);
    res.fold((l) {
      emit(ErrorOtpState());
    }, (r) async {
      if (r.status == 200 || r.status == 201) {
        successGetBar(r.msg);
        if (sendOtp == false) {
          if (isResetpassword) {
            Navigator.pushNamed(context, Routes.verifyEmailRoute,
                arguments: args);
          } else if (args.typeOfVerification == 'change_email') {
            log(args.typeOfVerification.toString());
            Navigator.pushNamed(context, Routes.verifyEmailRoute,
                arguments: args);
          } else {
            Navigator.pushNamed(context, Routes.activateAccountRoute,
                arguments: ChooseTypeRegisterArgs(
                    indexPageClientOrLawyer: args.indexPageClientOrLawyer,
                    typeOfVerification: 'register'));
          }
        } //
        emit(LoadedOtpState());
      } else {
        errorGetBar(r.msg ?? '');
        emit(ErrorOtpState());
      }
      minutes = 5;
      startTimer(context);

      emit(LoadedOtpState());
    });
  }

  sendlawyerOtp(
    BuildContext context,
    ChooseTypeRegisterArgs args, {
    bool isResetpassword = false,
    bool sendOtp = false,
  }) async {
    emit(LoadingOtpState());
    final res = await api.sendOtpLawyer(email: emailController.text);
    res.fold((l) {
      emit(ErrorOtpState());
    }, (r) async {
      if (r.status == 200 || r.status == 201) {
        successGetBar(r.msg);
        if (sendOtp == false) {
          if (isResetpassword) {
            Navigator.pushNamed(context, Routes.verifyEmailRoute,
                arguments: args);
          } else if (args.typeOfVerification == 'change_email') {
            Navigator.pushNamed(context, Routes.verifyEmailRoute,
                arguments: args);
          } else {
            Navigator.pushNamed(context, Routes.activateAccountRoute,
                arguments: ChooseTypeRegisterArgs(
                    indexPageClientOrLawyer: args.indexPageClientOrLawyer,
                    typeOfVerification: 'register')); //
          }
        }

        minutes = 5;
        startTimer(context);
        emit(LoadedOtpState());
      } else {
        errorGetBar(r.msg ?? '');
        emit(ErrorOtpState());
      }
    });
  }

  sendOtp(
    BuildContext context,
    ChooseTypeRegisterArgs args, {
    bool isResetpassword = false,
    bool sendOtp = false,
  }) {
    verifyController.clear();
    if (args.indexPageClientOrLawyer == 0) {
      sendClientOtp(context, args,
          isResetpassword: isResetpassword, sendOtp: sendOtp);
    } else {
      sendlawyerOtp(context, args,
          isResetpassword: isResetpassword, sendOtp: sendOtp);
    }
  }

  verifyClientOtp(BuildContext context, ChooseTypeRegisterArgs args) async {
    emit(LoadingVOtpState());
    final res = await api.verifyOtpClient(
        email: emailController.text, otp: verifyController.text);
    res.fold((l) {
      emit(ErrorVOtpState());
    }, (r) async {
      log('============= ${args.typeOfVerification} =============');
      log('============= ${args.indexPageClientOrLawyer} =============');
      if (r.status == 200 || r.status == 201) {
        successGetBar(r.msg);
        if (args.typeOfVerification == 'register') {
          Navigator.pushNamed(context, Routes.infoLawyerScreen,
              arguments: args);
        } else if (args.typeOfVerification == 'change_email') {
          changeEmail(context, args);
        } else {
          Navigator.pushNamed(context, Routes.createNewPasswordRoute,
              arguments: args);
        }
        emit(LoadedVOtpState());
      } else {
        errorGetBar(r.msg ?? '');
        emit(ErrorVOtpState());
      }
    });
  }

  verifylawyerOtp(BuildContext context, ChooseTypeRegisterArgs args) async {
    emit(LoadingVOtpState());
    final res = await api.verifyOtpLawyer(
        email: emailController.text, otp: verifyController.text);
    res.fold((l) {
      emit(ErrorVOtpState());
    }, (r) async {
      if (r.status == 200 || r.status == 201) {
        successGetBar(r.msg);
        if (args.typeOfVerification == 'register') {
          Navigator.pushNamed(context, Routes.infoLawyerScreen,
              arguments: args);
        } else if (args.typeOfVerification == 'change_email') {
          changeEmail(context, args);

          //! apply change email api
        } else {
          Navigator.pushNamed(context, Routes.createNewPasswordRoute,
              arguments: args);
        }
        emit(LoadedVOtpState());
      } else {
        errorGetBar(r.msg ?? '');
        emit(ErrorVOtpState());
      }
    });
  }

  verifyOtp(BuildContext context, ChooseTypeRegisterArgs args) {
    if (args.indexPageClientOrLawyer == 0) {
      verifyClientOtp(context, args);
    } else {
      verifylawyerOtp(context, args);
    }
  }

  Future<void> resetPassword(
      BuildContext context, ChooseTypeRegisterArgs args) async {
    emit(LoadingResetPassword());
    final res = args.indexPageClientOrLawyer == 0
        ? await api.clientResetPassword(
            email: emailController.text, password: passwordController.text)
        : await api.lawyerResetPassword(
            email: emailController.text, password: passwordController.text);

    res.fold((l) {
      emit(ErrorResetPassword());
    }, (r) {
      if (r.status == 200 || r.status == 201) {
        successGetBar(r.msg);
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.loginRoute, (route) => false,
            arguments: args);
      } else {
        errorGetBar(r.msg ?? '');
        emit(ErrorResetPassword());
      }
      emit(LoadedResetPassword());
    });
  }

  Future<void> changeEmail(
      BuildContext context, ChooseTypeRegisterArgs args) async {
    emit(LoadingChangeEmailState());

    if (args.indexPageClientOrLawyer == 0) {
      final res = await api.clientUpdateEmail(email: emailController.text);
      res.fold((l) {
        emit(ErrorChangeEmailState());
      }, (r) async {
        if (r.status == 200 || r.status == 201) {
          successGetBar(r.msg);
          await Preferences.instance.setUser(r);
          await Preferences.instance.getUserModel();
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.mainCustomerRoute, (route) => false,
              arguments: args);
        } else {
          errorGetBar(r.msg ?? '');
          emit(ErrorChangeEmailState());
        }
        emit(LoadedChangeEmailState());
      });
    } else {
      final res = await api.lawyerUpdateEmail(email: emailController.text);
      res.fold((l) {
        emit(ErrorChangeEmailState());
      }, (r) async {
        if (r.status == 200 || r.status == 201) {
          successGetBar(r.msg);
          await Preferences.instance.setLawyer(r);
          await Preferences.instance.getLawyerModel();
          emailController.clear();
          passwordController.clear();
          verifyController.clear();

          Navigator.pushNamedAndRemoveUntil(
              context, Routes.mainLawyerRoute, (route) => false,
              arguments: args);
        } else {
          errorGetBar(r.msg ?? '');
          emit(ErrorChangeEmailState());
        }
        emit(LoadedChangeEmailState());
      });
    }
  }

  //! Timer
  int minutes = 5; // Set the starting minutes here
  int seconds = 0;
  Timer? timer;

  void startTimer(BuildContext context) {
    int totalSeconds = minutes * 60 + seconds;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (totalSeconds > 0) {
        totalSeconds--;
        minutes = totalSeconds ~/ 60;
        seconds = totalSeconds % 60;
        emit(ChangeTimerState());
      } else {
        timer.cancel();
        // Optionally show a message when the timer finishes
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("resend".tr()),
        ));
      }
    });
  }
}
