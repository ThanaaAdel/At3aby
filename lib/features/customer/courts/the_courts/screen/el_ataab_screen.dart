import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/features/customer/courts/the_courts/cubit/cubit.dart';
import 'package:ataaby/features/customer/courts/the_courts/cubit/state.dart';
import 'package:ataaby/features/lawyer/packages/screens/widget/custom_container_package.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

class ElAtaabScreen extends StatefulWidget {
  const ElAtaabScreen({ super.key, required this.id});
final String id;
  @override
  State<ElAtaabScreen> createState() => _ElAtaabScreenState();
}

class _ElAtaabScreenState extends State<ElAtaabScreen> {
  @override
  initState() {
    context.read<TheCourtsCustomerCubit>().getCourtCaseDuesData(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<TheCourtsCustomerCubit>();
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          AppbarContainImage(
            isLawyer: false,
            titleCenter: "Financial_fees_list".tr(),
          ),
          5.h.verticalSpace,
          BlocBuilder<TheCourtsCustomerCubit,TheCourtsCustomerState>(
            builder: (context,state) {
              return (state is LoadingCourtCaseDuesData)?
              Center(child: CustomLoadingIndicator(),):
              Flexible(
                  child: ListView.builder(
                      itemCount: cubit.getCourtCaseDuesModel?.data?.length,
                      itemBuilder: (context, index) {
                        return ContainerOfPackage(
                          height: 100.h,
                          widgetOne: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.getCourtCaseDuesModel?.data?[index].title ?? "",
                                  style: getRegularStyle(
                                    fontSize: 15.sp * textScaleFactor(context),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: AutoSizeText(
                                        cubit.getCourtCaseDuesModel?.data?[index].price.toString() ?? "",
                                        style: getRegularStyle(
                                            fontSize:
                                                20.sp * textScaleFactor(context),
                                            color: AppColors.greenLight),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      "egp".tr(),
                                      style: getRegularStyle(
                                          fontSize:
                                              18.sp * textScaleFactor(context),
                                          color: AppColors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          widgetTwo: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                cubit.getCourtCaseDuesModel?.data?[index].paidName != "Unpaid"
                                    ? Container(
                                        margin: EdgeInsets.all(8.w),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.w, horizontal: 16.w),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.primary, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: AppColors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            MySvgWidget(
                                                path: ImageAssets.walletIcon,
                                                imageColor: AppColors.primary,
                                                size: 25.w),
                                            Padding(
                                              padding: EdgeInsetsDirectional.only(
                                                  start: 3.0.w),
                                              child: Text(
                                                'pay_now'.tr(),
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.h, horizontal: 10.w),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: AppColors.greenLight
                                                .withOpacity(0.2)),
                                        child: Text(
                                          'paid'.tr(),
                                          style: TextStyle(
                                            color: AppColors.greenLight,
                                          ),
                                        )),
                              ],
                            ),
                          ),
                        );
                      }));
            }
          )
          //!
        ],
      ),
    ));
  }
}
