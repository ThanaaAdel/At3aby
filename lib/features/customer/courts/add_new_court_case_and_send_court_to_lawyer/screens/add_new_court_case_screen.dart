import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/features/customer/courts/add_new_court_case_and_send_court_to_lawyer/cubit/add_new_court_case_and_send_court_to_lawyer_state.dart';
import 'package:ataaby/features/customer/courts/add_new_court_case_and_send_court_to_lawyer/screens/widgets/type_court.dart';
import 'package:ataaby/features/lawyer/home_lawyer/screen/filter_of_lawyer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/add_new_court_case_and_send_court_to_lawyer_cubit.dart';

class AddNewCourtCaseScreen extends StatefulWidget {
  const AddNewCourtCaseScreen({super.key});

  @override
  State<AddNewCourtCaseScreen> createState() => _AddNewCourtCaseScreenState();
}

class _AddNewCourtCaseScreenState extends State<AddNewCourtCaseScreen> {
  @override
  void initState() {
    context.read<AddNewCourtCaseAndSendCourtToLawyerCubit>().getFilterSpecialist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddNewCourtCaseAndSendCourtToLawyerCubit,
          AddNewCourtCaseAndSendCourtToLawyerState>(
        builder: (context, state) {
          var cubit = context.read<AddNewCourtCaseAndSendCourtToLawyerCubit>();

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Appbar with Image
              AppbarContainImage(
                isLawyer: false,
                titleCenter: "publish_new_issue".tr(),
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    CustomAddNewIssueData(cubit: cubit,isSendOrderToLawyer: false,),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            widget: Center(
                              child: (state is AddNewCourtCaseLoading)
                                  ? Center(
                                      child: CustomLoadingIndicator(
                                        color: AppColors.white,
                                      ),
                                    )
                                  : Text(
                                      "send_update_to_customer".tr(),
                                      style: getRegularStyle(
                                        color: AppColors.white,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                            ),
                            onTap: () async {
                              await cubit.addNewCourtCase(context);
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                )),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomAddNewIssueData extends StatefulWidget {
  CustomAddNewIssueData({super.key, required this.cubit,required this.isSendOrderToLawyer});
  AddNewCourtCaseAndSendCourtToLawyerCubit cubit;
  bool isSendOrderToLawyer;
  @override
  State<CustomAddNewIssueData> createState() => _CustomAddNewIssueDataState();
}

class _CustomAddNewIssueDataState extends State<CustomAddNewIssueData> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AddNewCourtCaseAndSendCourtToLawyerCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget.isSendOrderToLawyer ==  true?

        TypeCourtCaseRatioExample(
          onChanged: (value) {
            setState(() {
               cubit.typeSelectedValue = value;
            });
          },
          selectedValue: cubit.typeSelectedValue ?? TypeCourt.legal_advice,
          headerTitle: "order_type".tr(),
          titleFromRadioButtonFirst: "pleading".tr(),
          titleFromRadioButtonSecond: "consultation".tr(),
          isVertical: false,
        ):
            Container(),

        SizedBox(
          height: 10.h,
        ),
        CustomTextField(
          keyboardType: TextInputType.text,
          controller: widget.cubit.courtNumberController,
          titleFromTextFormField: "num_of_caseor_record".tr(),
          hintText: "num_of_caseor_record".tr(),
        ),
        CustomTextField(
          controller: widget.cubit.courtTitleController,
          titleFromTextFormField: "issue_address".tr(),
          hintText: "issue_address".tr(),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Text(
            "specialization".tr(),
            style: getRegularStyle(fontSize: 16.sp, color: AppColors.black),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        ExpandableSection(
            isExpanded: cubit.isExpandedSpecialization,
            title: "select_specialization".tr(),
            items: cubit.mainSpecialitiesModel?.data?.specialities ?? [],
            onItemSelected: (value) {
              cubit.onSelectItem(value);
            },
            selectedItem: cubit.selectedSpecialization,
            backgroundColor: AppColors.white),
        SizedBox(
          height: 10.h,
        ),
        CustomTextField(
          keyboardType: TextInputType.number,
          controller: widget.cubit.courtPriceController,
          titleFromTextFormField: "expected_case_price".tr(),
          hintText: "expected_case_price".tr(),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("egp".tr()),
          ),
        ),
        CustomTextField(
          controller: widget.cubit.courtDescriptionController,
          isMessage: true,
          titleFromTextFormField: "detailed_description_of_the_case".tr(),
          hintText: "detailed_description_of_the_case".tr(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
          child: Text(
            "update_attachments".tr(),
            style: getRegularStyle(
              color: AppColors.black,
              fontSize: 16.sp,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              ...widget.cubit.uploadedImages.map((file) {
                // تعديل هنا
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
                          widget.cubit.removeImage(file);
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
                  widget.cubit.pickImages(context);
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
        SizedBox(height: 20.h),
      ],
    );
  }
}
