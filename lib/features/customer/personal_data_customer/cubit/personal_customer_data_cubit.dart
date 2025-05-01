import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/personal_data_customer/cubit/personal_customer_data_state.dart';
import 'package:ataaby/features/login/data/models/login_model.dart';
import 'package:ataaby/features/new_register/data/model/city_model.dart';
import 'package:ataaby/features/new_register/data/model/country_model.dart';
import '../data/repo/personal_customer_password.dart';

class PersonalCustomerDataCubit extends Cubit<PersonalCustomerDataState> {
  PersonalCustomerDataCubit(this.personalCustomerDataRepo)
      : super(PersonalCustomerDataInitial()) {
    // getCities();
    // getCountries();
  }
  PersonalCustomerDataRepo personalCustomerDataRepo;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();

  MainCountryModel? mainCountryModel;
  Country? selectedCountryController;
  LoginModel? loginModel;

  Future<void> getDataFromSharedPreferences(BuildContext context) async {
    loginModel = await Preferences.instance.getUserModel();
    fillCustomerInfo(context);
    emit(GetUserModelDataState());
  }

  void fillCustomerInfo(BuildContext context) {
    nameController.text = loginModel?.data?.name ?? '';
    emailController.text = loginModel?.data?.email ?? '';
    phoneController.text = loginModel?.data?.phone ?? '';
    nationalIdController.text = loginModel?.data?.nationalId ?? '';
    print("0000000000000000000${loginModel?.data?.nationalId}");
  }

  Future<void> getCountries() async {
    emit(LoadingGetCountriesState());
    final res = await personalCustomerDataRepo.getCountries();

    res.fold((l) {
      emit(LoadedGetCountriesState());
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
    final res = await personalCustomerDataRepo.getCities(
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

  Future<void> updateProfileLawyer(
    BuildContext context,
    File? image,
  ) async {
    emit(UpdateProfileStateLoading());
    final res = await personalCustomerDataRepo.updateProfileCustomer(
      name: nameController.text,
      image: image?.path,
      countryId: selectedCountryController?.id ?? 0,
      cityId: selectedCityController?.id ?? 0,
      phone: phoneController.text,
      nationalId: nationalIdController.text,
    );
    res.fold((l) {
      emit(UpdateProfileStateError());
    }, (r) async {
      if (r.status == 200) {
        loginModel = r;

        emit(UpdateProfileStateLoaded());
        successGetBar(r.msg ?? '');

        nameController.clear();
        phoneController.clear();
        emailController.clear();
        nationalIdController.clear();
        Navigator.pop(context);
        Preferences.instance.setUser(r);
        getDataFromSharedPreferences(context);
      } else {
        errorGetBar(r.msg ?? '');

        nameController.clear();
        phoneController.clear();
        emailController.clear();
        nationalIdController.clear();
        emit(UpdateProfileStateError());
      }
    });
  }
}
