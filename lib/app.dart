import 'package:ataaby/core/notification_services/notification_service.dart';
import 'package:ataaby/features/about_app/cubit/about_app_cubit.dart';
import 'package:ataaby/features/change_password/cubit/change_password_cubit.dart';
import 'package:ataaby/features/chat/cubit/chat_cubit.dart';
import 'package:ataaby/features/custom_upload_image/cubit/upload_image_cubit.dart';
import 'package:ataaby/features/customer/courts/add_new_court_case_and_send_court_to_lawyer/cubit/add_new_court_case_and_send_court_to_lawyer_cubit.dart';
import 'package:ataaby/features/customer/courts/the_courts/cubit/cubit.dart';
import 'package:ataaby/features/customer/details_lawyer_from_customer/cubit/details_lawyer_from_customer_partener_cubit.dart';
import 'package:ataaby/features/customer/home_customer/cubit/cubit.dart';
import 'package:ataaby/features/customer/main_customer/cubit/cubit.dart';
import 'package:ataaby/features/customer/personal_data_customer/cubit/personal_customer_data_cubit.dart';
import 'package:ataaby/features/customer/points/cubit/points_cubit.dart';
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/cubit/Sos_lawyers_cubit.dart';
import 'package:ataaby/features/lawyer/add_new_update/cubit/add_new_update_cubit.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/cubit/administrative_structure_of_the_office_cubit.dart';
import 'package:ataaby/features/lawyer/details_issue/cubit/details_issue_cubit.dart';
import 'package:ataaby/features/electronic_wallet/cubit/electronic_wallet_cubit.dart';
import 'package:ataaby/features/lawyer/issues_status/cubit/issue_status_cubit.dart';
import 'package:ataaby/features/lawyer/main_lawyer/cubit/cubit.dart';
import 'package:ataaby/features/lawyer/market_lawyer/cubit/cubit.dart';
import 'package:ataaby/features/lawyer/order_this_product/cubit/order_this_product_cubit.dart';
import 'package:ataaby/features/lawyer/personal_data/cubit/personal_data_cubit.dart';
import 'package:ataaby/features/lawyer/profile_lawyer/cubit/profile_lawyer_cubit.dart';
import 'package:ataaby/features/lawyer/working_hours/cubit/working_hours_cubit.dart';
import 'package:ataaby/features/login/cubit/cubit.dart';
import 'package:ataaby/features/new_register/cubit/cubit.dart';
import 'package:ataaby/features/notifications/cubit/notifications_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'config/themes/app_theme.dart';
import 'core/exports.dart';
import 'package:ataaby/injector.dart' as injector;
import 'features/choose_type_registeration/cubit/cubit.dart';
import 'features/customer/community_services/cubit/cubit.dart';
import 'features/customer/contract_and_doc/cubit/contract_and_doc_cubit.dart';
import 'features/customer/inheritance_and_zakat_cal/cubit/inheritance_and_zakat_calculator_cubit.dart';
import 'features/customer/lawyers/cubit/cubit.dart';
import 'features/customer/offers_customer/cubit/offers_customer_cubit.dart';
import 'features/customer/profile_customer/cubit/profile_customer_cubit.dart';
import 'features/customer/setting_customer/cubit/setting_customer_cubit.dart';
import 'features/lawyer/courtcase_shared_send/cubit/cubit.dart';
import 'features/lawyer/current_issues/cubit/cubit.dart';
import 'features/lawyer/home_lawyer/cubit/cubit.dart';
import 'features/lawyer/my_advertiment_screen/cubit/cubit.dart';
import 'features/lawyer/packages/cubit/cubit.dart';
import 'features/settings/cubit/settings_from_app_cubit.dart';
import 'features/society/cubit/cubit.dart';
import 'features/splash/cubit/cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(text);
    NotificationService notificationService = NotificationService();
    return MultiBlocProvider(
        providers: [
          // ========================== splash ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<SplashCubit>(),
          ),
          // ========================== ChooseTypeRegister ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<ChooseTypeRegisterCubit>(),
          ),
          // ========================== Main lawyer ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<MainLawyerCubit>(),
          ),
          // ========================== Main customer ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<MainCustomerCubit>(),
          ),
          // ========================== Login ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<LoginCubit>(),
          ),
          // ========================== NewRegister ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<NewRegisterCubit>(),
          ),

          // ========================== Home Customer  ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<HomeLawyerCubit>(),
          ),
          // ========================== home customer ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<HomeCustomerCubit>(),
          ),

          // ========================== Details Issue  ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<DetailsIssueCubit>(),
          ),

          // ========================== current issues ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<CurrentIssuesCubit>(),
          ),
          // ========================== issue status ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<IssueStatusCubit>(),
          ),
          // ========================== profile lawyer ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<ProfileLawyerCubit>(),
          ),
          // ========================== personal data ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<PersonalDataCubit>(),
          ),
          // ========================== add new update ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<AddNewUpdateCubit>(),
          ),
          // ========================== image ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<UploadImageCubit>(),
          ),
          // ========================== change password  ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<ChangePasswordCubit>(),
          ),
          // ========================== market   ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<MarketLawyerCubit>(),
          ),

          // ========================== order product  ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<OrderThisProductCubit>(),
          ),
          // ========================== electronic product  ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<ElectronicWalletCubit>(),
          ),
          // ========================== Administrative Structure Of The Office  ========================== //
          BlocProvider(
            create: (_) => injector
                .serviceLocator<AdministrativeStructureOfTheOfficeCubit>(),
          ),

          // ========================== Working Hours   ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<WorkingHoursCubit>(),
          ),
          // ========================== Details Lawyer From Customer Part  ========================== //
          BlocProvider(
            create: (_) =>
                injector.serviceLocator<DetailsLawyerFromCustomerPartCubit>(),
          ),

          // ========================== Notification Repo ========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<NotificationsCubit>(),
          ),
          // ========================== about app========================== //
          BlocProvider(
            create: (_) => injector.serviceLocator<AboutAppCubit>(),
          ),

          // ========================== LawyerToSendDistressRequestCubit ========================= //
          BlocProvider(
            create: (_) => injector.serviceLocator<SosLawyersCubit>(),
          ),
          // ========================== issues customer ========================= //
          BlocProvider(
            create: (_) => injector.serviceLocator<TheCourtsCustomerCubit>(),
          ),
          // ========================== PublishNewIssueRepo ========================= //
          BlocProvider(
            create: (_) => injector
                .serviceLocator<AddNewCourtCaseAndSendCourtToLawyerCubit>(),
          ),
          // ========================== ProfileCustomerCubit ========================= //
          BlocProvider(
            create: (_) => injector.serviceLocator<ProfileCustomerCubit>(),
          ),
          // ========================== PersonalCustomerDataCubit ========================= //
          BlocProvider(
            create: (_) => injector.serviceLocator<PersonalCustomerDataCubit>(),
          ),

          // ========================== OffersCustomerCubit ========================= //
          BlocProvider(
            create: (_) => injector.serviceLocator<OffersCustomerCubit>(),
          ),
          // ========================== SettingCustomerCubit ========================= //
          BlocProvider(
            create: (_) => injector.serviceLocator<SettingCustomerCubit>(),
          ),
          // ========================== InheritanceAndZakatCalculatorRepo ========================= //
          BlocProvider(
            create: (_) =>
                injector.serviceLocator<InheritanceAndZakatCalculatorCubit>(),
          ),
          // ========================== InheritanceAndZakatCalculatorRepo ========================= //
          BlocProvider(
            create: (_) => injector.serviceLocator<ChatCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<ContractAndDocumentCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<SocietyCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<CommunityServicesCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<LaywersCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<PackagesCubit>(),
          ),

          BlocProvider(
            create: (_) => injector.serviceLocator<MyAdvertismentCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<GetSettingsFromAppCubit>(),
          ),
          BlocProvider(
            create: (_) => injector.serviceLocator<PointsCubit>(),
          ),
          BlocProvider(
            create: (_) =>
                injector.serviceLocator<CourtcaseSharedandSendCubit>(),
          ),
        ],
        child: GetMaterialApp(
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: appTheme(),
          navigatorKey: notificationService.navigatorKey,
          themeMode: ThemeMode.light,
          darkTheme: ThemeData.light(),
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ));
  }
}
