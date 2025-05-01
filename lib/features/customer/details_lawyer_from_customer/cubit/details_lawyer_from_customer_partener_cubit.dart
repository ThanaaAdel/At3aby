import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/details_lawyer_from_customer/cubit/details_lawyer_from_customer_partener_state.dart';
import 'package:ataaby/features/customer/details_lawyer_from_customer/data/repo/details_lawyer_from_customer_part_repo.dart';

import '../data/model/details_data_lawyer_model.dart';

class DetailsLawyerFromCustomerPartCubit
    extends Cubit<DetailsLawyerFromCustomerPartState> {
  DetailsLawyerFromCustomerPartCubit(this.detailsLawyerFromCustomerPartRepo)
      : super(DetailsLawyerFromCustomerPartInitial());
  DetailsLawyerFromCustomerPartRepo detailsLawyerFromCustomerPartRepo;
  TextEditingController reportLaywerController = TextEditingController();
  DetailsDataLawyerModel? detailsDataLawyerModel;
  getDetailsDataCustomer({required int lawyerId}) async {
    emit(LoadingGetDetailsDataCustomer());
    final res = await detailsLawyerFromCustomerPartRepo.getDetailsDataCustomer(lawyerId: lawyerId);
    res.fold((l) {
      emit(ErrorGetDetailsDataCustomer());
    }, (r) {
      detailsDataLawyerModel = r;
      emit(LoadedGetDetailsDataCustomer());
    });
  }
}
