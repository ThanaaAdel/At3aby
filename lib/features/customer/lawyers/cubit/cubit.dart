import 'package:ataaby/features/customer/home_customer/cubit/cubit.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/exports.dart';
import '../../../splash/cubit/cubit.dart';
import '../data/lawyers_repo_implementation.dart';
import '../data/model/all_lawyers_model.dart';
import '../data/model/type_model.dart';
import 'state.dart';

class LaywersCubit extends Cubit<LaywersState> {
  LaywersCubit(this.api) : super(LaywersInitial());
  LawyersRepoImplementation api;

  MainCustomerLawyerModel? mainCustomerLawyerModel;
  TextEditingController searchController = TextEditingController();
  Future<void> getAllLawyers(BuildContext context) async {
    var cubit = context.read<SplashCubit>();
    var cubit2 = context.read<HomeCustomerCubit>();
    emit(LoadingGetAllLawyersState());
    final res = await api.getAllLawyers(
        lat: cubit.currentLocation?.latitude.toString(),
        search: searchController.text,
        lng: cubit.currentLocation?.longitude.toString(),
        levelId: cubit2.selectedLevelController?.id.toString(),
        specialityId: cubit2.selectedSpecialization?.id?.toString(),
        type: currentType?.key);
    res.fold((l) {
      emit(ErrorGetAllLawyersState());
    }, (r) {
      mainCustomerLawyerModel = r;
      emit(SuccessGetAllLawyersState());
    });
  }

  List<TypeModel> typeList = [
    TypeModel('top_rated_asc', 'top_rated_asc'.tr()),
    TypeModel('top_rated_desc', 'top_rated_desc'.tr()),
    TypeModel('near_asc', 'near_asc'.tr()),
    TypeModel('near_desc', 'near_desc'.tr()),
    TypeModel('price_asc', 'price_asc'.tr()),
    TypeModel('price_desc', 'price_desc'.tr()),
  ];
  TypeModel? currentType;
}
