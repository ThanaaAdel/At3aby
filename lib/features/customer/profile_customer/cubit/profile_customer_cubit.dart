import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/profile_customer/cubit/profile_customer_state.dart';
import 'package:ataaby/features/customer/profile_customer/data/models/promo_code_model.dart';
import 'package:ataaby/features/customer/profile_customer/data/repo/profile_customer_repo.dart';

class ProfileCustomerCubit extends Cubit<ProfileCustomerState> {
  ProfileCustomerCubit(this.profileCustomerRepo) : super(ProfileCustomerInitial());
  ProfileCustomerRepo profileCustomerRepo;

  bool statusOfSwitch = false;
  void changeStatusOfSwitch(bool value) {
    statusOfSwitch = value;
    emit(ProfileCustomerSwitchState());
  }


  PromoCodeModel? promoCodeModel;
  Future<void> getPromoCode() async {
    emit(LoadingGetPromoCodeDataState());
    final res = await profileCustomerRepo.getPromoCode(

    );
    res.fold((l) {
      emit(ErrorGetPromoCodeDataState());
    }, (r) {
      promoCodeModel = r;
      emit(SuccessGetPromoCodeDataState());
    });
  }
}
