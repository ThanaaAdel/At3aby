import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/home_customer/cubit/state.dart';
import 'package:ataaby/features/customer/home_customer/data/models/home_data_lawyer_model.dart';
import 'package:ataaby/features/customer/home_customer/data/repo/home_customer.dart';
import '../../../lawyer/home_lawyer/data/model/specialist_model.dart';
import '../../../new_register/data/model/levels_model.dart';
import '../../../new_register/data/model/specialities_model.dart';
import '../../../splash/cubit/cubit.dart';
import '../../lawyers/cubit/cubit.dart';

class HomeCustomerCubit extends Cubit<HomeCustomerState> {
  HomeCustomerCubit(this.api) : super(HomeCustomerStateInitial());
  HomeCustomerRepo api;
  HomeDataCustomer? homeDataCustomer;
  getHomeDataCustomer(BuildContext context) async {
    var cubit3 = context.read<SplashCubit>();
    emit(LoadingGetDataCustomer());
    final res = await api.getHomeDataCustomer(
      lat: cubit3.currentLocation?.latitude?.toString(),
      lng: cubit3.currentLocation?.longitude?.toString(),
    );
    res.fold((l) {
      emit(ErrorGetDataCustomer());
    }, (r) {
      homeDataCustomer = r;
      print(
          "model ................... ${r.data?.nearLawyers?.length ?? "0000"}");
      print(
          "model ................... ${r.data?.nearLawyers?.length ?? "0000"}");
      emit(LoadedGetDataCustomer());
    });
  }

  TextEditingController searchController = TextEditingController();
  bool isExpandedDegree = false;
  bool isExpandedSpecialization = false;

  onSelectLevelItem(Level item) async {
    selectedLevelController = item;
    await getFilterSpecialist(item.id.toString());
    emit(OnChangeFilterItemState());
  }

  onSelectSpecialityItem(Speciality item) {
    selectedSpecialization = item;
    emit(OnChangeFilterItemState());
  }

  onCancelFilter(BuildContext context, {bool isCurrentcases = false}) {
    selectedLevelController = null;
    selectedSpecialization = null;
    Navigator.pop(context);
    // if (isCurrentcases) {
    //   //! DONE
    context.read<LaywersCubit>().getAllLawyers(context);
    // } else {
    //   homeLawyerNewCourt(context);
    // }

    emit(OnClearFilterItemState());
  }

  Speciality? selectedSpecialization; // !you will

  MainSpecialitiesModel? mainSpecialitiesModel;
  getFilterSpecialist(String id) async {
    emit(LoadingGetFilterSpecialist());
    final res = await api.getSpecialities(id);
    res.fold((l) {
      emit(ErrorGetFilterSpecialist());
    }, (r) {
      mainSpecialitiesModel = r;
      if (r.data!.specialities!.isNotEmpty) {
        selectedSpecialization = r.data?.specialities?.first;
      }
      emit(LoadedGetFilterSpecialist());
    });
  }

  Level? selectedLevelController;
  MainLevelsModel? mainLevelsModel;
  Future<void> getFilterLevels() async {
    emit(LoadingGetLevelsState());
    final res = await api.getLevels();

    res.fold((l) {
      emit(ErrorGetLevelsState());
    }, (r) {
      mainLevelsModel = r;
      if (r.data!.levels!.isNotEmpty) {
        selectedLevelController = r.data?.levels?.first;
        getFilterSpecialist(selectedLevelController?.id.toString() ?? '1');
      }
      emit(LoadedGetLevelsState());
    });
  }
}
