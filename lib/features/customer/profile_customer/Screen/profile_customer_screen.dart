import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/personal_data_customer/cubit/personal_customer_data_cubit.dart';
import 'package:ataaby/features/lawyer/market_lawyer/screen/widgets/appbar_home_lawyer.dart';
import 'package:ataaby/features/customer/points/screens/points.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/utils/restart_app_class.dart';
import '../../../lawyer/courtcase_shared_send/screen/sharedandsend_client.dart';
import '../../../lawyer/profile_lawyer/Screen/widgets/profile_widget.dart';
import 'promo_code.dart';
import '../cubit/profile_customer_cubit.dart';
import '../cubit/profile_customer_state.dart';

class ProfileCustomerScreen extends StatefulWidget {
  const ProfileCustomerScreen({super.key});

  @override
  State<ProfileCustomerScreen> createState() => _ProfileCustomerScreenState();
}

class _ProfileCustomerScreenState extends State<ProfileCustomerScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCustomerCubit, ProfileCustomerState>(
        builder: (context, state) {
          var userModelCubit = context.read<PersonalCustomerDataCubit>();
          {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainAppBarHomeWidget(
                  isLawyer: false,
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
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor: AppColors.white,
                                    backgroundImage: NetworkImage(userModelCubit
                                            .loginModel?.data?.image ??
                                        ""),
                                  )),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context
                                              .read<PersonalCustomerDataCubit>()
                                              .loginModel
                                              ?.data
                                              ?.name ??
                                          "",
                                      style: getRegularStyle(
                                        color: AppColors.blackLight,
                                        fontSize:
                                            14.sp * textScaleFactor(context),
                                      ),
                                    ),
                                    Text(
                                      context
                                              .read<PersonalCustomerDataCubit>()
                                              .loginModel
                                              ?.data
                                              ?.email ??
                                          "",
                                      style: getRegularStyle(
                                        color: AppColors.gray,
                                        fontSize:
                                            14.sp * textScaleFactor(context),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //!
                Expanded(
                  child: ListView(
                    children: [
                      ProfileWidget(
                        title: 'personal_data'.tr(),
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.personalCustomerInfoRoute);
                        },
                      ),
                      ProfileWidget(
                        title: 'electronic_wallet'.tr(),
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.electronicWalletRoute,
                              arguments: false);
                        },
                      ),
                      // ProfileWidget(
                      //   title: 'free_legal_advice'.tr(),
                      //   onTap: () {},
                      // ),
                      ProfileWidget(
                        title: 'inheritance_and_zakat_calculation'.tr(),
                        onTap: () {
                          Navigator.pushNamed(context,
                              Routes.inheritanceAndZakatCalculatorRoute);
                        },
                      ),
                      ProfileWidget(
                        title: 'court_case_send'.tr(),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CourtcaseSharedAndSendClientScreen()));
                          //!
                        },
                      ),
                      ProfileWidget(
                        title: 'society'.tr(),
                        onTap: () {
                          Navigator.pushNamed(context, Routes.societyMainScreen,
                              arguments: false);
                          //!
                        },
                      ),
                      ProfileWidget(
                        title: 'offers'.tr(),
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.offersCustomerRoute);
                        },
                      ),
                      ProfileWidget(
                        title: 'community_services'.tr(),
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.communityServicesScreen,
                              arguments: false);

                          //! الخدمات المجتمعية
                        },
                      ),
                      ProfileWidget(
                        title: 'free_contracts_and_documents'.tr(),
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.contractAndDocumentScreen);
                        },
                      ),
                      ProfileWidget(
                        title: 'points'.tr(),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PointsScreen()));
                        },
                      ),
                      ProfileWidget(
                        title: 'promo_code'.tr(),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PromoCodeScreen()));
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment:
                            EasyLocalization.of(context)!.locale.languageCode ==
                                    'en'
                                ? Alignment.topLeft
                                : Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                          child: Text(
                            "the_helper".tr(),
                            style: getBoldStyle(
                                color: AppColors.blackLight.withOpacity(0.7),
                                fontSize: 16.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ProfileWidget(
                        title: 'change_langauge'.tr(),
                        centerText:
                            EasyLocalization.of(context)!.locale.languageCode ==
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
                              arguments: false);
                        },
                        title: 'change_password'.tr(),
                      ),
                      ProfileWidget(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.settingCustomerRoute);
                        },
                        title: 'setting'.tr(),
                      ),
                      ProfileWidget(
                        title: 'about_app'.tr(),
                        onTap: () {
                          Navigator.pushNamed(context, Routes.aboutAppRoute,
                              arguments: false);
                        },
                      ),
                      ProfileWidget(
                        title: 'delete_account'.tr(),
                        onTap: () async {
                          final shouldLogout = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('delete_account'.tr()),
                              content: Text('are you sure delete your account'),
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
                            Preferences.instance.clearUserAndlawyer().then((e) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.chooseTypeRegistrationRoute,
                                (route) => false,
                              );
                            });
                          }
                        },
                      ),
                      ProfileWidget(
                        onTap: () async {
                          final shouldLogout = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("confirm".tr()),
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
                            Preferences.instance.clearUserAndlawyer().then((e) {
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
