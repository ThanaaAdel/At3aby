import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/core/widgets/date_widget.dart';
import 'package:ataaby/features/lawyer/add_new_update/cubit/add_new_update_cubit.dart';
import 'package:ataaby/features/lawyer/add_new_update/cubit/add_new_update_state.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/utils/custom_loading.dart';
import '../../details_issue/cubit/details_issue_cubit.dart';
import '../../details_issue/cubit/details_issue_state.dart';

class AddNewUpdateScreen extends StatelessWidget {
  const AddNewUpdateScreen({
    this.courtCaseId,
    this.isUpdate = false,
    this.updateId,
    super.key,
  });
  final String? courtCaseId;
  final String? updateId;
  final bool? isUpdate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddNewUpdateCubit, AddNewUpdateState>(
        builder: (context, state) {
          var cubit = context.read<AddNewUpdateCubit>();
          var cubit2 = context.read<DetailsIssueCubit>();

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Appbar with Image
                AppbarContainImage(
                  isLawyer: true,
                  titleCenter: "add_new_update".tr(),
                ),
                CustomTextField(
                  controller: cubit.initialRulingController,
                  titleFromTextFormField: "update_title".tr(),
                  hintText: "initial_ruling".tr(),
                ),
                DatePickerField(
                  title: "update_date".tr(),
                  onTab: () {
                    cubit.onSelectedDate(context);
                  },
                  selectedDate: cubit.selectedDate,
                ),
                CustomTextField(
                  controller: cubit.updateDetailsController,
                  isMessage: true,
                  titleFromTextFormField: "details_update".tr(),
                  hintText: "initial_ruling".tr(),
                ),
                if (!(isUpdate ?? true))
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0.w, vertical: 10.h),
                    child: Text(
                      "update_attachments".tr(),
                      style: getRegularStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                if (!(isUpdate ?? true))
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Wrap(
                        spacing: 10.w,
                        runSpacing: 10.h,
                        children: [
                          ...cubit.uploadedImage.map((file) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.file(
                                    file,
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
                                      cubit.removeImage(file);
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
                            );
                          }),
                          GestureDetector(
                            onTap: () {
                              cubit.pickImages(context);
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
                      )),
                SizedBox(height: 20.h),
                BlocBuilder<DetailsIssueCubit, DetailsIssueState>(
                  builder: (context, state2) {
                    return Padding(
                      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                      child: Align(
                        alignment: Alignment.center,
                        child: (state2 is LoadingUpdateNewUpdatesForCouse ||
                                state is LoadingAddNewUpdatesForCouse)
                            ? Center(
                                child: CustomLoadingIndicator(),
                              )
                            : SizedBox(
                                width: double.infinity,
                                child: CustomButton(
                                  widget: Center(
                                    child: Text(
                                      "send_update_to_customer".tr(),
                                      style: getRegularStyle(
                                        color: AppColors.white,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    (isUpdate == true)
                                        ? cubit2.updateCourtCaseUpdate(context,
                                            courtCaseId: courtCaseId ?? "",
                                            date: cubit.formattedDate,
                                            details: cubit
                                                .updateDetailsController.text,
                                            title: cubit
                                                .initialRulingController.text,
                                            updateId: updateId ?? '')
                                        : cubit.addNewUpdateLawyer(context,
                                            courtCaseId: courtCaseId ?? '');
                                  },
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
