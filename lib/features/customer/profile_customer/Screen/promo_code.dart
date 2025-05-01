import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../core/exports.dart';
import '../cubit/profile_customer_cubit.dart';
import '../cubit/profile_customer_state.dart';

class PromoCodeScreen extends StatefulWidget {
  const PromoCodeScreen({super.key});


  @override
  State<PromoCodeScreen> createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {
  @override

  void initState() {
    context.read<ProfileCustomerCubit>().getPromoCode();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit =   context.read<ProfileCustomerCubit>();

    String sharedLink =
        '${"download_app".tr()}${AppStrings.inviteLink}${"use_code".tr()}${  context.read<ProfileCustomerCubit>().promoCodeModel?.data ?? ''}${"for_get_points".tr()}';

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: getWidthSize(context),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.pointsBackground),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Column(children: [
                12.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: AppColors.white.withOpacity(0.2)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_back,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "promo_code".tr(),
                          style: getSemiBoldStyle(
                              color: AppColors.white, fontSize: 16.sp),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                      ]),
                ),
                20.verticalSpace,
                Image.asset(
                  ImageAssets.promoCode,
                  height: getHeightSize(context) * 0.3,
                ),
                20.verticalSpace,
              ]),
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text("promoCodeDesc".tr(),
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                        fontSize: 14.sp * textScaleFactor(context),
                      )),
                  20.h.verticalSpace,
                  Text("promo_code".tr(),
                      style: getRegularStyle(
                          color: AppColors.primary, fontSize: 16.sp)),
                  20.h.verticalSpace,
                  BlocBuilder<ProfileCustomerCubit,ProfileCustomerState>(
                    builder: (context,state) {
                      return (state is LoadingGetPromoCodeDataState)?
                      Center(child: CustomLoadingIndicator(),):
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.textGreyColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Center(
                          child: Text(
                           cubit.promoCodeModel?.data ?? "",
                            style: getRegularStyle(
                                color: AppColors.primary, fontSize: 25.sp),
                          ),
                        ),
                      );
                    }
                  ),
                  30.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: CustomButton(
                          paddingButton: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          shadow: customShadow,
                          widget: Center(
                            child: Text('copy_code'.tr(),
                                style: getRegularStyle(color: AppColors.white)),
                          ),
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: sharedLink));
                            Fluttertoast.showToast(msg: "copied".tr());
                          },
                        ),
                      ),
                      20.w.horizontalSpace,
                      Expanded(
                        child: CustomButton(
                          paddingButton: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          shadow: customShadow,
                          color: AppColors.greenLight,
                          onTap: () async {
                            String url = sharedLink;
                            await Share.share(url);
                          },
                          widget: Center(
                            child: Text('share'.tr(),
                                style: getRegularStyle(color: AppColors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  20.h.verticalSpace,
                ],
              ),
            )))
          ],
        ),
      ),
    );
  }
}
