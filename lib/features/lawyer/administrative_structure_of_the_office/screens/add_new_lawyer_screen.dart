import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/cubit/administrative_structure_of_the_office_cubit.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/cubit/administrative_structure_of_the_office_state.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/screens/widgets/lawyer_information_widget.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';


class AddNewLawyerScreen extends StatefulWidget {
  const AddNewLawyerScreen({super.key});

  @override
  State<AddNewLawyerScreen> createState() => _AddNewLawyerScreenState();
}

class _AddNewLawyerScreenState extends State<AddNewLawyerScreen> {
  @override
  void dispose() {
    EasyDebounce.cancel('add-new-lawyer-debouncer');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AdministrativeStructureOfTheOfficeCubit>();
    return Scaffold(
      body: BlocBuilder<AdministrativeStructureOfTheOfficeCubit, AdministrativeStructureOfTheOfficeState>(
        builder: (context, state) {
          return Column(
            children: [
              AppbarContainImage(
                isLawyer: true,
                titleCenter: "new_lawyer".tr(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        onChanged: (p0) async {
                          if (p0.isNotEmpty) {
                            print("id >>>>>>>>>>>>>>>>>>>> $p0");
                            EasyDebounce.debounce(
                              'add-new-lawyer-debouncer',
                              const Duration(seconds: 1),
                                  () async => await cubit.searchLawyerData(lawyerId: int.parse(p0.trim())),
                            );
                          }
                        },
                        controller: cubit.searchController,
                        hintText: "lawyer_membership_number".tr(),
                        suffixIcon: IconButton(
                          icon: SvgPicture.asset(ImageAssets.idendificationNumberIcon),
                          onPressed: () async {
                            if (cubit.searchController.text.isNotEmpty) {
                              await cubit.searchLawyerData(lawyerId: int.parse(cubit.searchController.text.trim()));
                            }
                          },
                        ),
                        titleFromTextFormField: "lawyer_membership_number".tr(),
                      ),


                      (state is LoadingSearchLawyerDataState)?
                        Center(child: CustomLoadingIndicator())
                      : (cubit.searchLawyerModel?.data == null)
                     ?   Center(child: Text("لا يوجد محامين".tr()))
                      :
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
                          child: LawyerInformationWidget(
                            id: 0,
                            cubit: cubit,
                            searchLawyerModelData: cubit.searchLawyerModel!.data!,
                            type: "add",
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
