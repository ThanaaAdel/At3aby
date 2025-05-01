import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/cubit/administrative_structure_of_the_office_cubit.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/cubit/administrative_structure_of_the_office_state.dart';
import 'package:easy_localization/easy_localization.dart';

class LawyerDetailsInformationScreen extends StatefulWidget {
   LawyerDetailsInformationScreen({super.key, required this.lawyerId});
   int? lawyerId;
  @override
  State<LawyerDetailsInformationScreen> createState() =>
      _LawyerDetailsInformationScreenState();
}

class _LawyerDetailsInformationScreenState
    extends State<LawyerDetailsInformationScreen> {
  @override
  void initState() {
    context
        .read<AdministrativeStructureOfTheOfficeCubit>()
        .searchLawyerData(lawyerId: int.parse(widget.lawyerId.toString()));
print("the date : ${context
    .read<AdministrativeStructureOfTheOfficeCubit>().searchLawyerModel?.data?.name.toString() ?? ""}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AdministrativeStructureOfTheOfficeCubit>();
    return Scaffold(
      body: BlocBuilder<AdministrativeStructureOfTheOfficeCubit,
          AdministrativeStructureOfTheOfficeState>(builder: (context, state) {
        return Column(
          children: [
            AppbarContainImage(
              isLawyer: true,
              titleCenter: "details".tr(),
            ),(state is LoadingSearchLawyerDataState )?
             Center(child: CustomLoadingIndicator(),):
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.white,
                              backgroundImage: NetworkImage(cubit.searchLawyerModel?.data?.image ?? "https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg"),
                              radius: 40.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomTextField(
                        enabled: false,
                        controller: cubit.lawyerMembershipNumberController,
                        hintText: cubit.searchLawyerModel?.data?.lawyerId ?? "",
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: SvgPicture.asset(
                              ImageAssets.idendificationNumberIcon),
                        ),
                        titleFromTextFormField:
                            "lawyer_membership_number".tr()),
                    CustomTextField(
                        enabled: false,
                        controller: cubit.fullNameController,
                        hintText: cubit.searchLawyerModel?.data?.name ?? "",
                        titleFromTextFormField: "full_name".tr()),
                    CustomTextField(
                        enabled: false,
                        controller: cubit.emailController,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "enter_valid_email".tr();
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(p0)) {
                            return "enter_valid_email".tr();
                          } else {
                            return null;
                          }
                        },
                        hintText: cubit.searchLawyerModel?.data?.email ?? "",
                        titleFromTextFormField: "email".tr()),
                    CustomTextField(
                        enabled: false,
                        controller: cubit.phoneController,
                        hintText: cubit.searchLawyerModel?.data?.phone ?? "",
                        titleFromTextFormField: "phone".tr()),
                    CustomTextField(
                        enabled: false,
                        controller: cubit.identificationNumberController,
                        hintText:
                            cubit.searchLawyerModel?.data?.nationalId ?? "",
                        titleFromTextFormField: "nationality_id".tr()),
                    CustomTextField(
                        enabled: false,
                        controller: cubit.cityController,
                        hintText:
                            cubit.searchLawyerModel?.data?.city?.title ?? "",
                        titleFromTextFormField: "city".tr()),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
