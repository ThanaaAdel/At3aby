import 'package:ataaby/core/exports.dart';

import 'package:easy_localization/easy_localization.dart';

import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../data/model/all_products_model.dart';

class DetailsProductScreen extends StatelessWidget {
  DetailsProductScreen({this.product, super.key});
  MarketProduct? product;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MarketLawyerCubit, MarketLawyerState>(
            builder: (context, state) {
          var cubit = context.read<MarketLawyerCubit>();
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    product?.image ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300.h,
                  ),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.arrow_back_outlined,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () async {
                          //     //! Share

                          //     await Share.share(AppStrings.productShareLink +
                          //         product!.id.toString());
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.all(5.w),
                          //     decoration: BoxDecoration(
                          //       color: AppColors.white,
                          //       borderRadius: BorderRadius.circular(8.r),
                          //     ),
                          //     child: Icon(
                          //       Icons.share,
                          //       color: AppColors.black,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      product?.title ?? '',
                      style: getRegularStyle(color: AppColors.black),
                    ),
                    Text(
                      '${product?.price.toString() ?? ''} ${AppStrings.currency}',
                      style: getRegularStyle(color: AppColors.green),
                    ),
                    Text(
                      product?.location ?? '',
                      style: getRegularStyle(color: AppColors.gray),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "product_details".tr(),
                      style: getRegularStyle(color: AppColors.black),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      product?.description ?? '',
                      style: getRegularStyle(
                        color: AppColors.gray,
                        fontSize: 14.sp * textScaleFactor(context),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp * textScaleFactor(context),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.orderThisProductRoute,
                                arguments: product);
                          },
                          widget: Center(
                              child: Text(
                            "order_this_product".tr(),
                            style: getRegularStyle(color: AppColors.white),
                          ))),
                    )
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
