import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/cubit/administrative_structure_of_the_office_cubit.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/cubit/administrative_structure_of_the_office_state.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/screens/widgets/lawyer_information_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class AdministrativeStructureOfTheOfficeScreen extends StatefulWidget {
  const AdministrativeStructureOfTheOfficeScreen({super.key});

  @override
  State<AdministrativeStructureOfTheOfficeScreen> createState() =>
      _AdministrativeStructureOfTheOfficeScreenState();
}

class _AdministrativeStructureOfTheOfficeScreenState
    extends State<AdministrativeStructureOfTheOfficeScreen> {
  @override
  void initState() {
    context.read<AdministrativeStructureOfTheOfficeCubit>().getOfficeTeamData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AdministrativeStructureOfTheOfficeCubit>();
    return  Scaffold(
      body: Column(
        children: [
          AppbarContainImage(
            isLawyer: true,
            titleCenter: "administrative_structure_of_the_office".tr(),
          ),
          Expanded(
            child: BlocBuilder<AdministrativeStructureOfTheOfficeCubit, AdministrativeStructureOfTheOfficeState>(
              builder: (context, state) {
                if (state is LoadingOfficeTeamDataState) {
                  return  CustomLoadingIndicator();
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        ( cubit.getOfficeTeamModel?.data?.team?.length == 0)?
                            Expanded(child: Center(child: Text("no_lawyers_from_office".tr()),)):
                         Expanded(
                          child: ListView.builder(
                            itemCount: cubit.getOfficeTeamModel?.data?.team?.length ?? 0,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) => LawyerInformationWidget(
                              id:  cubit.getOfficeTeamModel!.data!.team![index].id!,
                              cubit: cubit,
                              searchLawyerModelData: cubit.getOfficeTeamModel!.data!.team![index],
                              type: "delete",
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomButton(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, Routes.addNewLawyerRoute);
                          },
                          widget: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: AppColors.white,
                                size: 14.sp * textScaleFactor(context),
                              ),
                              Text(
                                "add_new_lawyer".tr(),
                                style: getRegularStyle(
                                  color: AppColors.white,
                                  fontSize: 14.sp * textScaleFactor(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );

  }
}
