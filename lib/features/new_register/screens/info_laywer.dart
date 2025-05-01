import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/login/screens/login.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import 'widget/complete_profile_info.dart';
import 'widget/lawyer_data.dart';

class InfoLawyerScreen extends StatefulWidget {
  const InfoLawyerScreen({super.key, required this.args});
  final ChooseTypeRegisterArgs args;

  @override
  State<InfoLawyerScreen> createState() => _InfoLawyerScreenState();
}

class _InfoLawyerScreenState extends State<InfoLawyerScreen> {
  @override
  void initState() {
    context.read<NewRegisterCubit>().getCountries();
    if (widget.args.indexPageClientOrLawyer == 1) {
      context.read<NewRegisterCubit>().getLevels();
    }
    super.initState();
  }

  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewRegisterCubit, NewRegisterState>(
        builder: (context, state) {
          var cubit = context.read<NewRegisterCubit>();
          return Stack(
            children: [
              // خلفية أو صورة SVG في الأعلى
              Positioned(
                top: 0,
                right: 0,
                child: widget.args.indexPageClientOrLawyer == 0
                    ? SvgPicture.asset(ImageAssets.headerLoginIcon,
                        width: 300.w, height: 462.h)
                    : SvgPicture.asset(ImageAssets.headerDarkBlueIcon,
                        width: 300.w, height: 462.h),
              ),
              // إضافة SplashFrameOne في الأسفل
              Positioned(
                bottom: -60,
                child: Image.asset(
                  color: AppColors.black,
                  ImageAssets.frameOneFooter,
                  width: getWidthSize(context),
                  height: getWidthSize(context),
                ),
              ),
              // إضافة العناصر الأساسية
              (state is LoadingGetCountriesState ||
                      state is LoadingGetLevelsState ||
                      state is LoadingGetCitiesState)
                  ? Center(child: CustomLoadingIndicator())
                  : Form(
                      key: key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40.h),
                          const CustomAppbar(),
                          SizedBox(height: getHeightSize(context) / 6),
                          widget.args.indexPageClientOrLawyer == 0
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 8.0.h),
                                    child: Image.asset(
                                      ImageAssets.coloredLogoImage,
                                      height: 90.h,
                                      width: 100.w,
                                    ),
                                  ))
                              : Container(),
                          Expanded(
                            child: Column(
                              children: [
                                widget.args.indexPageClientOrLawyer == 0
                                    ? CompleteYourProfileData(
                                        cubit: cubit, isLawyer: false)
                                    : Expanded(
                                        child: Theme(
                                          data: ThemeData(
                                                      canvasColor: Colors.transparent,
                                          ),
                                          child: Container(
                                            width: 350.w,
                                            alignment: Alignment.center,
                                            child: Stepper(
                                              elevation: 0,
                                              stepIconMargin:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 8.w),
                                              stepIconWidth: 40.w,
                                              stepIconHeight: 40.w,

                                              connectorColor:
                                                  WidgetStatePropertyAll(
                                                      AppColors.primary),
                                              margin: EdgeInsets.all(20.w),
                                              type: StepperType
                                                  .horizontal, // Set the stepper type to horizontal
                                              currentStep: cubit.currentStep,
                                              onStepTapped: (step) {
                                                debugPrint('step::$step');
                                                // setState(() {
                                                // cubit.currentStep = step;
                                                // });
                                              },
                                              onStepContinue:
                                                  cubit.currentStep < 1
                                                      ? () => setState(() {
                                                            cubit.currentStep +=
                                                                1;
                                                          })
                                                      : null,
                                              onStepCancel:
                                                  cubit.currentStep > 0
                                                      ? () => setState(() {
                                                            cubit.currentStep -=
                                                                1;
                                                          })
                                                      : null,
                                              controlsBuilder:
                                                  (context, details) {
                                                return Container();
                                              },

                                              steps: [
                                                Step(
                                                    title: const Text(''),
                                                    content:
                                                        CompleteYourProfileData(
                                                            cubit: cubit,
                                                            isLawyer: true),
                                                    isActive:
                                                        cubit.currentStep ==
                                                            0,
                                                    stepStyle: StepStyle(
                                                        connectorColor: cubit
                                                                    .currentStep ==
                                                                1
                                                            ? AppColors
                                                                .primary // Active step background
                                                            : AppColors
                                                                .grayLite3Color,
                                                        indexStyle: TextStyle(
                                                            fontSize: 18.sp *
                                                                textScaleFactor(
                                                                    context),
                                                            color: AppColors
                                                                .white))),
                                                Step(
                                                  title: const Text(''),
                                                  content: LawyerData(
                                                      args: widget.args),
                                                  isActive:
                                                      cubit.currentStep == 1,
                                                  stepStyle: StepStyle(
                                                    color: cubit.currentStep ==
                                                            1
                                                        ? AppColors
                                                            .primary // Active step background
                                                        : AppColors.white,
                                                    border: Border.all(
                                                      color: cubit.currentStep ==
                                                              1
                                                          ? AppColors
                                                              .primary // Active step background
                                                          : AppColors
                                                              .grayLite3Color,
                                                    ),
                                                    indexStyle: TextStyle(
                                                        fontSize: 18.sp *
                                                            textScaleFactor(
                                                                context),
                                                        color:
                                                            cubit.currentStep ==
                                                                    0
                                                                ? AppColors
                                                                    .black
                                                                : AppColors
                                                                    .white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                widget.args.indexPageClientOrLawyer == 0
                                    ? (state is LoadingClientRegisterState)
                                        ? Center(
                                            child: CustomLoadingIndicator())
                                        : Padding(
                                            padding: EdgeInsets.all(20.0.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    //! here apply api of register

                                                    cubit.mainRegister(
                                                        context, widget.args);
                                                  },
                                                  child: Text(
                                                    "skip".tr(),
                                                    style: getRegularStyle(
                                                        color: AppColors
                                                            .grayLiteColor),
                                                  ),
                                                ),
                                                CustomButton(
                                                  widget: Row(
                                                    children: [
                                                      Text(
                                                        "next".tr(),
                                                        style: getRegularStyle(
                                                            color: AppColors
                                                                .white),
                                                      ),
                                                      SizedBox(width: 10.w),
                                                      Icon(
                                                          Icons.arrow_forward,
                                                          color: AppColors
                                                              .white),
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    if (key.currentState!
                                                        .validate()) {
                                                      cubit.mainRegister(
                                                          context,
                                                          widget.args);
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                    : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
