import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/offers_customer/cubit/offers_customer_state.dart';
import 'package:ataaby/features/customer/offers_customer/data/models/offers_model.dart';
import 'package:ataaby/features/customer/offers_customer/data/repos/offers_customer_repo.dart';

class OffersCustomerCubit extends Cubit<OffersCustomerState> {
  OffersCustomerCubit(this.offersCustomerRepo) : super(OffersCustomerInitial());
  OffersCustomerRepo offersCustomerRepo;
  OffersModel? offersModel;
  getOffersData() async {
    emit(LoadingGetOffers());
    final res = await offersCustomerRepo.getOffersData();
    res.fold((l) {
      debugPrint("Error fetching offers: $l");
      emit(ErrorGetOffers());
    }, (r) {
      offersModel = r;
      debugPrint(
          "Offers Data: ${offersModel?.data?.lawyerOffers?.length} items loaded");
      emit(LoadedGetOffers());
    });
  }
}
