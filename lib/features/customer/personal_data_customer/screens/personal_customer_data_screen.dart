
import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/core/widgets/dropdown_button_form_field.dart';
import 'package:ataaby/core/widgets/radio_button.dart';
import 'package:ataaby/features/customer/personal_data_customer/cubit/personal_customer_data_cubit.dart';
import 'package:ataaby/features/customer/personal_data_customer/cubit/personal_customer_data_state.dart';
import 'package:ataaby/features/new_register/data/model/country_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';

import '../../../login/screens/login.dart';
File? imageFile;
class PersonalCustomerDataScreen extends StatelessWidget {
  const PersonalCustomerDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PersonalCustomerDataCubit, PersonalCustomerDataState>(
          builder: (context, state) {
        var cubit = context.read<PersonalCustomerDataCubit>();
        return SingleChildScrollView(
          child: Column(children: [
            AppbarContainImage(
              onTap: (){
                Navigator.pushReplacementNamed(context, Routes.mainCustomerRoute,arguments: ChooseTypeRegisterArgs(indexPageClientOrLawyer: 0));
              },
              isLawyer: false,
              titleCenter: "personal_data".tr(),
            ),
            SizedBox(
              height: 10.h,
            ),
            const BasicInformation(),
          ]),
        );
      }),
    );
  }
}

class BasicInformation extends StatefulWidget {
  const BasicInformation({super.key});

  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  @override
  initState() {
    super.initState();
    context.read<PersonalCustomerDataCubit>().getCountries();
    context.read<PersonalCustomerDataCubit>().getCities();
    context.read<PersonalCustomerDataCubit>().getDataFromSharedPreferences(context);
  }
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
    await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var cubit =  context.read<PersonalCustomerDataCubit>();
    return BlocBuilder<PersonalCustomerDataCubit, PersonalCustomerDataState>(
        builder: (context,state) {
          return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 30.sp * textScaleFactor(context),
                    backgroundImage: imageFile != null
                        ? FileImage(imageFile!) as ImageProvider
                        :  NetworkImage(cubit.loginModel?.data?.image ?? ""),
                  ),
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: Text(
                    "change_photo".tr(),
                    style: getUnderLine(color: AppColors.primary),
                  ),
                ),
              ],
            ),
            CustomTextField(
              controller: cubit.nameController,
              titleFromTextFormField: "full_name".tr(),
              hintText: cubit.loginModel?.data?.name ?? "",

            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.changeEmailRoute,
                    arguments: false);
              },
              child: CustomTextField(
                enabled: false,
                controller: cubit.emailController,
                titleFromTextFormField: "email".tr(),
                hintText: cubit.loginModel?.data?.email ?? "",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "change".tr(),
                    style: getUnderLine(color: AppColors.primary),
                  ),
                ),
              ),
            ),
            CustomTextField(
              controller: cubit.phoneController,
              titleFromTextFormField: "phone".tr(),
              // hintText: cubit.loginModel?.data?.phone ?? "",
              enabled: false,
            ),
            CustomTextField(
              // hintText: cubit.loginModel?.data?.nationalId ?? "",
              controller: cubit.nationalIdController,
              titleFromTextFormField: "nationality_id".tr(),
              enabled: false,
            ),
            10.h.verticalSpace,

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: CustomDropdownButtonFormField<Country>(
                items: cubit.mainCountryModel?.data?.countries ??
                    [],
                value:  cubit.selectedCountryController,
                onChanged: (newValue) {
                  setState(() {
                    cubit.selectedCountryController = newValue;
                    cubit.getCities();
                  });
                },
                itemBuilder: (item) {
                  return item.title ?? '';
                },
              ),
            ),
            (state  is UpdateProfileStateLoading )?
            Center(child: CustomLoadingIndicator()) :

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                    onTap: () {
                     cubit.updateProfileLawyer(context,imageFile);
                    },
                    widget: Center(
                        child: Text(
                      "save_information".tr(),
                      style: getRegularStyle(color: AppColors.white),
                    ))),
              ),
            )
          ],
        );
      }
    );
  }
}

class LawyerInformation extends StatelessWidget {
  const LawyerInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        CustomTextField(
          titleFromTextFormField: "lawyer_membership_number".tr(),
          hintText: "lawyer_membership_number".tr(),
          suffixIcon: Padding(
            padding: EdgeInsets.all(12.0.sp),
            child: SvgPicture.asset(ImageAssets.idendificationNumberIcon),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        RadioExample(
          onChanged: (value) {
            // setState(() {
            //   cubit.typeSelectedValue = value;
            // });
          },
          selectedValue: SingingCharacter.individual,
          headerTitle: "حجم الملف الشخصي",
          titleFromRadioButtonFirst: "محامي اعمل لحسابي",
          titleFromRadioButtonSecond: "مكتب محاماه",
          descriptionSecond:
              "هذا الاختيار يمكنك من تسجيل اكتر من عضو تحت مكتبك",
        ),
        RadioExample(
          onChanged: (value) {
            // setState(() {
            //   cubit.typeSelectedValue = value;
            // });
          },
          selectedValue: SingingCharacter.individual,
          headerTitle: "هل تود المشاركة في العمل العام",
          titleFromRadioButtonFirst: "نعم",
          titleFromRadioButtonSecond: "ليس الان",
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                widget: Center(
                    child: Text(
                  "save_information".tr(),
                  style: getRegularStyle(color: AppColors.white),
                ))),
          ),
        )
      ],
    );
  }
}
