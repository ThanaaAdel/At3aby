import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/widgets/radio_button.dart';
import 'package:ataaby/features/lawyer/personal_data/cubit/personal_data_state.dart';
import 'package:ataaby/features/lawyer/personal_data/data/repo/personal_password.dart';
import 'package:ataaby/features/lawyer/personal_data/screens/widget/public_work_radio_button.dart';
import 'package:ataaby/features/lawyer/profile_lawyer/cubit/profile_lawyer_cubit.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../login/data/models/login_model_lawyer.dart';
import '../../../new_register/data/model/city_model.dart';
import '../../../new_register/data/model/country_model.dart';

class PersonalDataCubit extends Cubit<PersonalDataState> {
  PersonalDataCubit(this.personalDataRepo) : super(PersonalDataInitial());
  PersonalDataRepo personalDataRepo;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController numberRmembershipController = TextEditingController();
  Country? selectedCountryController;
  TextEditingController failureIssueController = TextEditingController();

  TextEditingController successIssueController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  TextEditingController consultationPriceController = TextEditingController();
  TextEditingController priceInTheCaseController = TextEditingController();
  SingingCharacter? typeSelectedValue;
  PublicWorkCharacter? publicWorkTypeSelectedValue;
  int currentIndex = 0;
  MainCountryModel? mainCountryModel;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }

  void fillLawyerInfo(BuildContext context) {
    var lawyerData = context.read<ProfileLawyerCubit>().loginModelLawyer?.data;
    nameController.text = lawyerData?.name ?? '';
    emailController.text = lawyerData?.email ?? '';
    phoneController.text = lawyerData?.phone ?? '';
    nationalIdController.text = lawyerData?.nationalId ?? '';
    numberRmembershipController.text = lawyerData?.lawyerId ?? '';
    priceInTheCaseController.text = lawyerData?.attorneyFee.toString() ?? '';
    consultationPriceController.text =
        lawyerData?.consultationFee.toString() ?? '';
    publicWorkTypeSelectedValue = lawyerData?.publicWork == 'active'
        ? PublicWorkCharacter.active
        : PublicWorkCharacter.inactive;

    ;
    typeSelectedValue = lawyerData?.type == 'individual'
        ? SingingCharacter.individual
        : SingingCharacter.office;
    // selectedCountryController = lawyerData?.country ?? "";
    aboutMeController.text = lawyerData?.about ?? '';
    failureIssueController.text = lawyerData?.failedCase.toString() ?? '0';
    successIssueController.text = lawyerData?.successCase.toString() ?? '0';
  }

  LoginModelLawyer? updateProfileLawyerModel;
  Future<void> updateProfileLawyer(BuildContext context,
      {required int cityId,
      required int countryId,
      String? image,
      required String numberOfSuccessCases,
      required String? name,
      required String? phone}) async {
    emit(UpdateProfileStateLoading());
    final res = await personalDataRepo.updateProfileLawyer(
      aboutMe: aboutMeController.text,
      numberOfFailedCases: int.parse(failureIssueController.text),
      attorneyFee: priceInTheCaseController.text,
      consultationFee: consultationPriceController.text,
      publicWorkController: publicWorkTypeSelectedValue?.name ?? 'active',
      type: typeSelectedValue?.name ?? '',
      name: name,
      image: image,
      cityId: cityId,
      countryId: countryId,
      numberOfSuccessCases: int.parse(numberOfSuccessCases),
      phone: phone,
    );
    res.fold((l) {
      emit(UpdateProfileStateError());
    }, (r) async {
      if (r.status == 200) {
        updateProfileLawyerModel = r;
        Preferences.instance.setLawyer(r);
        await context.read<ProfileLawyerCubit>().getDataFromSharedPreferences();

        emit(UpdateProfileStateLoaded());
        successGetBar(r.msg ?? '');
      } else {
        errorGetBar(r.msg ?? '');

        emit(UpdateProfileStateError());
      }
    });
  }

  Future<void> getCountries() async {
    emit(LoadingGetCountriesState());
    final res = await personalDataRepo.getCountries();

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
    final res = await personalDataRepo.getCities(
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
}
