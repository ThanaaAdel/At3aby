import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/features/lawyer/order_this_product/cubit/order_this_product_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/order_this_product_state.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    context.read<OrderThisProductCubit>().getOrdersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<OrderThisProductCubit>();
    return Scaffold(
      body: Column(
        children: [
          AppbarContainImage(
            isLawyer: true,
            titleCenter: "orders".tr(),
          ),
          Flexible(
            child: BlocBuilder<OrderThisProductCubit, OrderThisProductState>(
                builder: (context, state) {
              return (state is OrdersDataLoading)
                  ? Center(
                      child: CustomLoadingIndicator(),
                    )
                  : cubit.ordersModel?.data?.length == 0
                      ? Center(
                          child: Text('no_orders'.tr()),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0.w, vertical: 20.h),
                          child: Container(
                              decoration: BoxDecoration(
                                boxShadow: customShadow,
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12.sp),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          cubit.ordersModel?.data?.length ?? 0,
                                      itemBuilder:
                                          (context, index) => Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                    color: AppColors.white),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r),
                                                      child: CachedNetworkImage(
                                                        imageUrl: cubit
                                                                .ordersModel
                                                                ?.data?[index]
                                                                .marketProduct
                                                                ?.image ??
                                                            '',
                                                        height: 90.h,
                                                        fit: BoxFit.cover,
                                                        width: getWidthSize(
                                                                context) /
                                                            4,
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .only(
                                                                start: 8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .date_range_outlined,
                                                                  color: AppColors
                                                                      .primary,
                                                                  size: 18.sp,
                                                                ),
                                                                10.w.horizontalSpace,
                                                                Flexible(
                                                                  fit: FlexFit
                                                                      .tight,
                                                                  child: Text(
                                                                    cubit
                                                                            .ordersModel
                                                                            ?.data?[index]
                                                                            .createdAt ??
                                                                        "",
                                                                    maxLines: 1,
                                                                    style: TextStyle(
                                                                        color: AppColors
                                                                            .gray2Lite,
                                                                        fontSize:
                                                                            15.sp),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          2.h,
                                                                      horizontal:
                                                                          5.w),
                                                                  decoration: BoxDecoration(
                                                                      color: AppColors
                                                                          .primary,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.r)),
                                                                  child: Text(
                                                                    cubit
                                                                            .ordersModel
                                                                            ?.data?[index]
                                                                            .status ??
                                                                        "",
                                                                    maxLines: 1,
                                                                    style: TextStyle(
                                                                        color: AppColors
                                                                            .white,
                                                                        fontSize:
                                                                            15.sp),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              cubit
                                                                      .ordersModel
                                                                      ?.data?[
                                                                          index]
                                                                      .marketProduct
                                                                      ?.title ??
                                                                  "",
                                                              maxLines: 1,
                                                              style: getRegularStyle(
                                                                  color: AppColors
                                                                      .secondPrimary),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Flexible(
                                                                  fit: FlexFit
                                                                      .tight,
                                                                  child: Text(
                                                                    '${'count'.tr()}: ${cubit.ordersModel?.data?[index].qty ?? 0}',
                                                                    maxLines: 1,
                                                                    style: getRegularStyle(
                                                                        color: AppColors
                                                                            .primary,
                                                                        fontSize:
                                                                            15.sp),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${cubit.ordersModel?.data?[index].totalPrice ?? 0} ${AppStrings.currency}',
                                                                  maxLines: 1,
                                                                  style: getRegularStyle(
                                                                      color: AppColors
                                                                          .primary,
                                                                      fontSize:
                                                                          15.sp),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )))),
                        );
            }),
          ),
        ],
      ),
    );
  }
}
