import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/order_this_product/cubit/order_this_product_state.dart';
import 'package:ataaby/features/lawyer/order_this_product/data/models/orders_model.dart';
import 'package:ataaby/features/lawyer/order_this_product/data/repos/order_this_product_repo.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../profile_lawyer/cubit/profile_lawyer_cubit.dart';

class OrderThisProductCubit extends Cubit<OrderThisProductState> {
  OrderThisProductCubit(this.orderThisProductRepo)
      : super(OrderThisProductInitial());
  OrderThisProductRepo orderThisProductRepo;
  TextEditingController phoneController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void orderProduct(String marketProductId, BuildContext context) async {
    emit(OrderThisProductLoading());
    final response = await orderThisProductRepo.orderProduct(
        marketProductId: marketProductId,
        phone:  context.read<ProfileLawyerCubit>().loginModelLawyer?.data?.phone,
        qty: countController.text,
        address: addressController.text);

    response.fold((l) {
      emit(OrderThisProductFailed());
    }, (r) {
      AwesomeDialog(
        context: context,
        showCloseIcon: false,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        padding: EdgeInsets.all(10.w),
        title: "done_send_order".tr(),
        btnOkOnPress: () {
          Navigator.pushNamed(context, Routes.ordersScreen);
          phoneController.clear();
          countController.clear();
          addressController.clear();
        },
        btnOkText: "send_order".tr(),
      ).show();

      emit(OrderThisProductSuccess());
    });
  }

  OrdersModel? ordersModel;

  void getOrdersData() async {
    emit(OrdersDataLoading());
    final response = await orderThisProductRepo.getOrdersData();

    response.fold((l) {
      emit(OrdersDataFailed());
    }, (r) {
      ordersModel = r;
      emit(OrdersDataSuccess());
    });
  }
}
