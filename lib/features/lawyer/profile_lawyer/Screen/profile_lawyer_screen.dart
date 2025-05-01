import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/lawyer/home_lawyer/screen/widgets/appbar_home_lawyer.dart';
import 'package:ataaby/features/lawyer/profile_lawyer/Screen/widgets/profile_widget.dart';
import 'package:ataaby/features/lawyer/profile_lawyer/cubit/profile_lawyer_cubit.dart';
import 'package:ataaby/features/lawyer/profile_lawyer/cubit/profile_lawyer_state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/utils/restart_app_class.dart';
import '../../../../core/widgets/switch_widget.dart';
import '../../../login/screens/login.dart';

class ProfileLawyerScreen extends StatefulWidget {
  const ProfileLawyerScreen({super.key});

  @override
  State<ProfileLawyerScreen> createState() => _ProfileLawyerScreenState();
}

class _ProfileLawyerScreenState extends State<ProfileLawyerScreen> {
  List<String> titles = [
    'personal_data'.tr(),
    'administrative_structure_of_the_office'.tr(),
    'working_hours'.tr(),
    'electronic_wallet'.tr(),
    'blog'.tr()
  ];

  List<String> helperTitles = [
    'change_password'.tr(),
    'change_langauge'.tr(),
    'about_app'.tr(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProfileLawyerCubit>().getDataFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileLawyerCubit, ProfileLawyerState>(
        builder: (context, state) {
          var cubit = context.read<ProfileLawyerCubit>();
          {
            return (state is GetDataStateLoading)
                ? Center(
                    child: CustomLoadingIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppbarHomeLawyer(
                        heightContainer: 70.h,
                        bottom: 30.h,
                        textCenter: Column(
                          children: [
                            Text(
                              "my_profile".tr(),
                              style: getBoldStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                        widget: Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 15.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 2.0.h,
                                            bottom: 0.h,
                                            right: 5.w,
                                            left: 5.w),
                                        child: CircleAvatar(
                                          backgroundColor: AppColors.white,
                                          backgroundImage: NetworkImage(cubit
                                                  .loginModelLawyer
                                                  ?.data
                                                  ?.image ??
                                              "https://static.vecteezy.com/system/resources/previews/013/215/160/non_2x/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector.jpg"),
                                        )),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 5.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            cubit.loginModelLawyer?.data
                                                    ?.name ??
                                                "name",
                                            style: getRegularStyle(
                                              color: AppColors.blackLight,
                                              fontSize: 12.sp *
                                                  textScaleFactor(context),
                                            ),
                                          ),
                                          AutoSizeText(
                                            cubit.loginModelLawyer?.data
                                                    ?.email ??
                                                "email@gmail.com",
                                            style: getRegularStyle(
                                              color: AppColors.gray,
                                              fontSize: 12.sp *
                                                  textScaleFactor(context),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 8.0),
                                child: Column(
                                  children: [
                                    StyledSwitch(
                                      status: cubit.loginModelLawyer?.data
                                                  ?.status ==
                                              'active'
                                          ? true
                                          : false,
                                      onToggled: (value) {
                                        cubit.changeStatusOfSwitch(value);
                                      },
                                    ),
                                    SizedBox(height: 2.h),
                                    AutoSizeText(
                                      cubit.loginModelLawyer?.data?.status ==
                                              'active'
                                          ? "online".tr()
                                          : "offline".tr(),
                                      // cubit.statusOfSwitch == true
                                      //     ? "online".tr()
                                      //     : "offline".tr(),
                                      style: getRegularStyle(
                                          color: AppColors.blackLight,
                                          fontSize: 12.sp),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            ProfileWidget(
                              title: 'personal_data'.tr(),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.personalInfoRoute,
                                    arguments: true);
                              },
                            ),
                            cubit.loginModelLawyer?.data?.type == 'office'
                                ? ProfileWidget(
                                    title:
                                        'administrative_structure_of_the_office'
                                            .tr(),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          Routes
                                              .administrativeStructureOfTheOfficeRoute);
                                    },
                                  )
                                : const SizedBox(),
                            ProfileWidget(
                              title: 'working_hours'.tr(),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.workingHoursRoute,
                                    arguments:
                                        cubit.loginModelLawyer?.data?.id);
                              },
                            ),
                            ProfileWidget(
                              title: 'electronic_wallet'.tr(),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.electronicWalletRoute,
                                    arguments: true);
                              },
                            ),
                            // ProfileWidget(title: 'blog'.tr()),
                            SizedBox(
                              height: 10.h,
                            ),
                            ProfileWidget(
                              title: 'courtcase_shared_send'.tr(),
                              onTap: () {
                                Navigator.pushNamed(context,
                                    Routes.courtcaseSharedAndSendScreenRoute);
                                //!
                              },
                            ),
                            ProfileWidget(
                              title: 'blog'.tr(),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.societyMainScreen,
                                    arguments: true);
                                //!
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            ProfileWidget(
                              title: 'packages'.tr(),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.packagesScreen,
                                    arguments: ChooseTypeRegisterArgs(
                                        indexPageClientOrLawyer: 1));
                                //!
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            ProfileWidget(
                              title: 'subscribtion'.tr(),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.subscribtionScreen,
                                    arguments: ChooseTypeRegisterArgs(
                                        indexPageClientOrLawyer: 1));
                                //!
                              },
                            ),
                            ProfileWidget(
                              title: 'orders'.tr(),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.ordersScreen,
                                    arguments: ChooseTypeRegisterArgs(
                                        indexPageClientOrLawyer: 1));
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Align(
                              alignment: EasyLocalization.of(context)!
                                          .locale
                                          .languageCode ==
                                      'en'
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 15.w, right: 15.w),
                                child: Text(
                                  "the_helper".tr(),
                                  style: getBoldStyle(
                                      color:
                                          AppColors.blackLight.withOpacity(0.7),
                                      fontSize: 16.sp),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            ProfileWidget(
                              title: 'change_langauge'.tr(),
                              centerText: EasyLocalization.of(context)!
                                          .locale
                                          .languageCode ==
                                      'ar'
                                  ? "English"
                                  : "العربية",
                              onTap: () {
                                if (EasyLocalization.of(context)!
                                        .locale
                                        .languageCode ==
                                    'ar') {
                                  EasyLocalization.of(context)!
                                      .setLocale(const Locale('en', ''));
                                  Preferences.instance.savedLang('en');
                                  Preferences.instance.getSavedLang();
                                  // HotRestartController.performHotRestart(context);
                                } else {
                                  EasyLocalization.of(context)!
                                      .setLocale(const Locale('ar', ''));
                                  Preferences.instance.savedLang('ar');
                                  Preferences.instance.getSavedLang();
                                }
                                HotRestartController.performHotRestart(context);
                              },
                            ),
                            ProfileWidget(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.changePasswordRoute,
                                    arguments: true);
                              },
                              title: 'change_password'.tr(),
                            ),
                            ProfileWidget(
                              title: 'about_app'.tr(),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.aboutAppRoute,
                                    arguments: true);
                              },
                            ),
                            ProfileWidget(
                              title: 'delete_account'.tr(),
                              onTap: () async {
                                final shouldLogout = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('delete_account'.tr()),
                                    content: Text(
                                      'are_you_sure_delete_account'.tr(),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: Text('cancel'.tr()),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: Text('confirm'.tr()),
                                      ),
                                    ],
                                  ),
                                );
                                if (shouldLogout == true) {
                                  Preferences.instance
                                      .clearUserAndlawyer()
                                      .then((e) {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        Routes.chooseTypeRegistrationRoute,
                                        (route) => false);
                                  });
                                }
                              },
                            ),
                            ProfileWidget(
                              onTap: () async {
                                final shouldLogout = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('logout'.tr()),
                                    content: Text('do_you_want_logout'.tr()),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: Text('cancel'.tr()),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: Text('yes_logout'.tr()),
                                      ),
                                    ],
                                  ),
                                );

                                if (shouldLogout == true) {
                                  Preferences.instance
                                      .clearUserAndlawyer()
                                      .then((e) {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      Routes.chooseTypeRegistrationRoute,
                                      (route) => false,
                                    );
                                  });
                                }
                              },
                              title: 'logout'.tr(),
                            ),

                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
          }
        },
      ),
    );
  }
}
