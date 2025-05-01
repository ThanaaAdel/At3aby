import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/order_this_product/cubit/order_this_product_cubit.dart';
import 'package:ataaby/features/lawyer/order_this_product/cubit/order_this_product_state.dart';
import 'package:ataaby/features/lawyer/profile_lawyer/cubit/profile_lawyer_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/utils/custom_loading.dart';
import '../../../../core/widgets/appbar_with_image.dart';
import '../../market_lawyer/data/model/all_products_model.dart';

class OrderThisProductScreen extends StatelessWidget {
  OrderThisProductScreen({this.product, super.key});
  MarketProduct? product;

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<FormState>();
    var cubit = context.read<OrderThisProductCubit>();
    return SafeArea(child: Scaffold(
      body: BlocBuilder<OrderThisProductCubit, OrderThisProductState>(
          builder: (context, state) {
        return Form(
          key: key,
          child: Column(
            children: [
              AppbarContainImage(
                isLawyer: true,
                titleCenter: "order_product".tr(),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
                      child: Container(
                          decoration: BoxDecoration(
                            boxShadow: customShadow,
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.sp),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.network(
                                  product?.image ?? '',
                                  width: 80.w,
                                  height: 60.h,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product?.title ?? '',
                                      style: getRegularStyle(
                                          color: AppColors.secondPrimary),
                                    ),
                                    Text(
                                      '${product?.price.toString() ?? ''} ${AppStrings.currency}',
                                      style: getRegularStyle(color: AppColors.green),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ),
                    CustomTextField(
                      controller: cubit.phoneController,
                      enabled: false,
                      titleFromTextFormField: "phone".tr(),
                      hintText:  context.read<ProfileLawyerCubit>().loginModelLawyer?.data?.phone ?? '',
                      keyboardType: TextInputType.phone,

                    ),
                    CustomTextField(
                        controller: cubit.countController,
                        titleFromTextFormField: "count".tr(),
                        keyboardType: TextInputType.number,
                        hintText: "1",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "enter_valid_count".tr();
                          } else {
                            return null;
                          }
                        }),
                    CustomTextField(
                      isMessage: true,
                      controller: cubit.addressController,
                      titleFromTextFormField: "address_in_detail".tr(),
                      hintText:  "address_in_detail".tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "enter_valid_address".tr();
                        } else {
                          return null;
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: state is OrderThisProductLoading
                          ? Center(child: CustomLoadingIndicator())
                          : CustomButton(
                              onTap: () {
                                if (key.currentState!.validate()) {
                                  cubit.orderProduct(product!.id.toString(), context);
                                }
                              },
                              widget: Center(
                                  child: Text(
                                "order_product".tr(),
                                style: getRegularStyle(color: AppColors.white),
                              ))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    ));
  }
}
