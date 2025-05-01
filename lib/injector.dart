import 'package:ataaby/features/about_app/cubit/about_app_cubit.dart';
import 'package:ataaby/features/about_app/data/repos/about_app_repo.dart';
import 'package:ataaby/features/change_password/cubit/change_password_cubit.dart';
import 'package:ataaby/features/change_password/data/repos/change_password_repo.dart';
import 'package:ataaby/features/chat/data/repos/chat_repo.dart';
import 'package:ataaby/features/choose_type_registeration/cubit/cubit.dart';
import 'package:ataaby/features/choose_type_registeration/data/repo/choose_type_register.dart';
import 'package:ataaby/features/custom_upload_image/cubit/upload_image_cubit.dart';
import 'package:ataaby/features/customer/contract_and_doc/data/repo_implementaion/repo_impl_contractanddoc.dart';
import 'package:ataaby/features/customer/courts/the_courts/cubit/cubit.dart';
import 'package:ataaby/features/customer/courts/the_courts/data/repo/issues_customer_repo.dart';
import 'package:ataaby/features/customer/details_lawyer_from_customer/cubit/details_lawyer_from_customer_partener_cubit.dart';
import 'package:ataaby/features/customer/home_customer/data/repo/home_customer.dart';
import 'package:ataaby/features/customer/main_customer/data/repo/main_customer_repo.dart';
import 'package:ataaby/features/customer/personal_data_customer/data/repo/personal_customer_password.dart';
import 'package:ataaby/features/customer/points/cubit/points_cubit.dart';
import 'package:ataaby/features/customer/points/data/repos/points_repo.dart';
import 'package:ataaby/features/customer/profile_customer/cubit/profile_customer_cubit.dart';
import 'package:ataaby/features/customer/setting_customer/cubit/setting_customer_cubit.dart';
import 'package:ataaby/features/customer/setting_customer/data/repos/setting_customer_repo.dart';
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/cubit/Sos_lawyers_cubit.dart';
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/data/repos/sos_lawyers_repo.dart';
import 'package:ataaby/features/lawyer/add_new_update/cubit/add_new_update_cubit.dart';
import 'package:ataaby/features/lawyer/add_new_update/data/repo/add_new_update_repo.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/cubit/administrative_structure_of_the_office_cubit.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/data/repo/administrative_structure_of_the_office_repo.dart';
import 'package:ataaby/features/lawyer/current_issues/cubit/cubit.dart';
import 'package:ataaby/features/lawyer/current_issues/data/repo/current_issues_repo.dart';

import 'package:ataaby/features/lawyer/details_issue/cubit/details_issue_cubit.dart';
import 'package:ataaby/features/lawyer/details_issue/data/repo/details_issue_repo.dart';
import 'package:ataaby/features/electronic_wallet/cubit/electronic_wallet_cubit.dart';
import 'package:ataaby/features/lawyer/home_lawyer/data/repo/home_lawyer.dart';
import 'package:ataaby/features/lawyer/issues_status/cubit/issue_status_cubit.dart';
import 'package:ataaby/features/lawyer/issues_status/data/repo/issue_status.dart';
import 'package:ataaby/features/lawyer/main_lawyer/cubit/cubit.dart';
import 'package:ataaby/features/lawyer/main_lawyer/data/repo/main_lawyer_repo.dart';
import 'package:ataaby/features/lawyer/market_lawyer/cubit/cubit.dart';
import 'package:ataaby/features/lawyer/market_lawyer/data/repo/market_repo.dart';
import 'package:ataaby/features/lawyer/order_this_product/cubit/order_this_product_cubit.dart';
import 'package:ataaby/features/lawyer/order_this_product/data/repos/order_this_product_repo.dart';
import 'package:ataaby/features/lawyer/packages/data/repo/packages_repo.dart';
import 'package:ataaby/features/lawyer/personal_data/cubit/personal_data_cubit.dart';
import 'package:ataaby/features/lawyer/personal_data/data/repo/personal_password.dart';
import 'package:ataaby/features/lawyer/profile_lawyer/cubit/profile_lawyer_cubit.dart';
import 'package:ataaby/features/lawyer/profile_lawyer/data/repo/profile_lawyer.dart';
import 'package:ataaby/features/lawyer/working_hours/cubit/working_hours_cubit.dart';
import 'package:ataaby/features/lawyer/working_hours/data/repos/working_hours_repo.dart';
import 'package:ataaby/features/login/data/repo/login.dart';
import 'package:ataaby/features/new_register/cubit/cubit.dart';
import 'package:ataaby/features/new_register/data/repo/new_register.dart';
import 'package:ataaby/features/notifications/cubit/notifications_cubit.dart';
import 'package:ataaby/features/notifications/data/repos/notifications_repo.dart';
import 'package:ataaby/features/settings/data/repos/settings_from_app.dart';
import 'package:dio/dio.dart';
import 'package:ataaby/features/splash/cubit/cubit.dart';
import 'package:get_it/get_it.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'features/chat/cubit/chat_cubit.dart';
import 'features/customer/community_services/cubit/cubit.dart';
import 'features/customer/community_services/data/repos/repo_implementation.dart';
import 'features/customer/contract_and_doc/cubit/contract_and_doc_cubit.dart';
import 'features/customer/courts/add_new_court_case_and_send_court_to_lawyer/cubit/add_new_court_case_and_send_court_to_lawyer_cubit.dart';
import 'features/customer/courts/add_new_court_case_and_send_court_to_lawyer/data/repo/add_new_court_case_and_send_court_to_lawyer_repo.dart';
import 'features/customer/details_lawyer_from_customer/data/repo/details_lawyer_from_customer_part_repo.dart';
import 'features/customer/home_customer/cubit/cubit.dart';
import 'features/customer/inheritance_and_zakat_cal/cubit/inheritance_and_zakat_calculator_cubit.dart';
import 'features/customer/inheritance_and_zakat_cal/data/repos/inheritance_and_zakat_calculator_customer_repo.dart';
import 'features/customer/lawyers/cubit/cubit.dart';
import 'features/customer/lawyers/data/lawyers_repo_implementation.dart';
import 'features/customer/main_customer/cubit/cubit.dart';
import 'features/customer/offers_customer/cubit/offers_customer_cubit.dart';
import 'features/customer/offers_customer/data/repos/offers_customer_repo.dart';
import 'features/customer/personal_data_customer/cubit/personal_customer_data_cubit.dart';
import 'features/customer/profile_customer/data/repo/profile_customer_repo.dart';
import 'features/electronic_wallet/data/repos/electronic_wallet_repo.dart';
import 'features/lawyer/courtcase_shared_send/cubit/cubit.dart';
import 'features/lawyer/courtcase_shared_send/data/repo_impl.dart';
import 'features/lawyer/home_lawyer/cubit/cubit.dart';
import 'features/lawyer/my_advertiment_screen/cubit/cubit.dart';
import 'features/lawyer/my_advertiment_screen/data/repos/my_advertisment_repo.dart';
import 'features/lawyer/packages/cubit/cubit.dart';
import 'features/login/cubit/cubit.dart';
import 'features/settings/cubit/settings_from_app_cubit.dart';
import 'features/society/cubit/cubit.dart';
import 'features/society/data/repos/repo_implementation.dart';

final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //!-------------------------Declare Cubit-------------------------
  serviceLocator.registerFactory(() => SplashCubit());
  serviceLocator
      .registerFactory(() => ChooseTypeRegisterCubit(serviceLocator()));
  serviceLocator.registerFactory(() => MainLawyerCubit(serviceLocator()));
  serviceLocator.registerFactory(() => MainCustomerCubit(serviceLocator()));
  serviceLocator.registerFactory(() => LoginCubit(serviceLocator()));
  serviceLocator.registerFactory(() => NewRegisterCubit(serviceLocator()));
  serviceLocator.registerFactory(() => HomeLawyerCubit(serviceLocator()));
  serviceLocator.registerFactory(() => HomeCustomerCubit(serviceLocator()));
  serviceLocator.registerFactory(() => DetailsIssueCubit(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentIssuesCubit(serviceLocator()));
  serviceLocator.registerFactory(() => IssueStatusCubit(serviceLocator()));
  serviceLocator.registerFactory(() => ProfileLawyerCubit(serviceLocator()));
  serviceLocator.registerFactory(() => PersonalDataCubit(serviceLocator()));
  serviceLocator.registerFactory(() => AddNewUpdateCubit(serviceLocator()));
  serviceLocator.registerFactory(() => ChangePasswordCubit(serviceLocator()));
  serviceLocator.registerFactory(() => MarketLawyerCubit(serviceLocator()));
  serviceLocator.registerFactory(() => OrderThisProductCubit(serviceLocator()));
  serviceLocator.registerFactory(() => OffersCustomerCubit(serviceLocator()));
  serviceLocator.registerFactory(() => MyAdvertismentCubit(serviceLocator()));
  serviceLocator.registerFactory(() => ElectronicWalletCubit(serviceLocator()));
  serviceLocator.registerFactory(
      () => DetailsLawyerFromCustomerPartCubit(serviceLocator()));
  serviceLocator.registerFactory(() => WorkingHoursCubit(serviceLocator()));
  serviceLocator.registerFactory(() => NotificationsCubit(serviceLocator()));

  serviceLocator.registerFactory(
      () => AdministrativeStructureOfTheOfficeCubit(serviceLocator()));

  serviceLocator.registerFactory(() => AboutAppCubit(serviceLocator()));
  serviceLocator.registerFactory(() => SosLawyersCubit(serviceLocator()));

  serviceLocator
      .registerFactory(() => TheCourtsCustomerCubit(serviceLocator()));
  serviceLocator.registerFactory(
      () => AddNewCourtCaseAndSendCourtToLawyerCubit(serviceLocator()));
  serviceLocator.registerFactory(() => ProfileCustomerCubit(serviceLocator()));
  serviceLocator
      .registerFactory(() => PersonalCustomerDataCubit(serviceLocator()));
  serviceLocator.registerFactory(() => UploadImageCubit());
  serviceLocator.registerFactory(() => ChatCubit(serviceLocator()));
  serviceLocator.registerFactory(
      () => InheritanceAndZakatCalculatorCubit(serviceLocator()));
  serviceLocator.registerFactory(() => SettingCustomerCubit(serviceLocator()));
  serviceLocator
      .registerFactory(() => ContractAndDocumentCubit(serviceLocator()));
  serviceLocator.registerFactory(() => SocietyCubit(serviceLocator()));
  serviceLocator
      .registerFactory(() => CommunityServicesCubit(serviceLocator()));
  serviceLocator.registerFactory(() => LaywersCubit(serviceLocator()));
  serviceLocator.registerFactory(() => PackagesCubit(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetSettingsFromAppCubit(serviceLocator()));
  serviceLocator.registerFactory(() => PointsCubit(serviceLocator()));
  serviceLocator
      .registerFactory(() => CourtcaseSharedandSendCubit(serviceLocator()));
  //!----------------------------------------------------------------

  //!-------------------------Declare Repo---------------------------
  serviceLocator
      .registerLazySingleton(() => ChooseTypeRegisterRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => MainLawyerRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => MainCustomerRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => LoginRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => MyAdvertismentRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => NotificationsRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => NewRegisterRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => HomeLawyerRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => HomeCustomerRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => DetailsIssueRepo(serviceLocator()));

  serviceLocator
      .registerLazySingleton(() => CurrentIssuesRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => IssueStatusRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => ProfileLawyerRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => PersonalDataRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => AddNewUpdateRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => ChangePasswordRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => MarketLawyerRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => WorkingHoursRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => OrderThisProductRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => ElectronicWalletRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => AboutAppRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => ProfileCustomerRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => AddNewCourtCaseAndSendCourtToLawyerRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SosLawyersRepo(serviceLocator()));

  serviceLocator
      .registerLazySingleton(() => PersonalCustomerDataRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => DetailsLawyerFromCustomerPartRepo(serviceLocator()));

  serviceLocator.registerLazySingleton(
      () => AdministrativeStructureOfTheOfficeRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => TheCourtsCustomerRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ChatRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => SettingCustomerRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => OffersCustomerRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => InheritanceAndZakatCalculatorRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => ContractAndDocumentRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SocietyRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => CommunityServicesRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => LawyersRepoImplementation(serviceLocator()));
  serviceLocator.registerLazySingleton(() => PackagesRepo(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => GetSettingsFromAppRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(() => PointsRepo(serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => CourtcaseSharedandSendRepo(serviceLocator()));

  //!----------------------------------------------------------------

  //! External
  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(client: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppInterceptors());

  //! Dio
  serviceLocator.registerLazySingleton(
    () => Dio(
      BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
  );
}
