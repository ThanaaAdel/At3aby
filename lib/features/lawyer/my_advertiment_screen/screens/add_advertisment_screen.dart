import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/lawyer/my_advertiment_screen/cubit/cubit.dart';
import 'package:ataaby/features/lawyer/my_advertiment_screen/cubit/state.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/widgets/custom_appbar_title_and_back.dart';
import '../../../../core/widgets/date_widget.dart';

class AddAdvertismentScreen extends StatelessWidget {
  const AddAdvertismentScreen({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MyAdvertismentCubit>();
    return Scaffold(
      body: BlocBuilder<MyAdvertismentCubit, MyAdvertismentState>(
          builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarTitleAndbackButton(
                title: 'add_advertisment'.tr(), isLawyer: true),
            DatePickerField(
              title: "start_date".tr(),
              onTab: () {
                cubit.onSelectedDate(context, isFromDate: true);
              },
              selectedDate: cubit.fromData,
            ),
            DatePickerField(
              title: "end_date".tr(),
              onTab: () {
                cubit.onSelectedDate(context, isFromDate: false);
              },
              selectedDate: cubit.toDate,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
              child: Text(
                "advertisment_image".tr(),
                style: getRegularStyle(
                  color: AppColors.black,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is FilePickedSuccessfully) // استخدم الحالة
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            cubit.uploadedImage ?? File(''),
                            width: 70.w,
                            height: 70.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 5.h,
                          right: 5.w,
                          child: GestureDetector(
                            onTap: () {
                              cubit.clearImage();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 12.r,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 14.sp * textScaleFactor(context),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    GestureDetector(
                      onTap: () {
                        cubit.pickImage(context, true);
                      },
                      child: DottedBorder(
                        color: Colors.black.withOpacity(0.2),
                        strokeWidth: 1,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(8),
                        dashPattern: const [12, 4],
                        child: SizedBox(
                          height: 70.h,
                          width: 70.w,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 20.sp * textScaleFactor(context),
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, right: 10.w, bottom: 10.h, left: 10.w),
              child: state is LoadingAddAdsToLawyerPackageState
                  ? Center(
                      child: CustomLoadingIndicator(),
                    )
                  : CustomButton(
                      onTap: () {
                        cubit.addAdsToLawyerPackage(context, id: id.toString());
                      },
                      widget: Center(
                        child: Text(
                          "send".tr(),
                          style: getRegularStyle(
                              color: AppColors.white,
                              fontSize: 16.sp * textScaleFactor(context)),
                        ),
                      )),
            )
          ],
        );
      }),
    );
  }
}
