import 'package:ataaby/features/customer/courts/add_new_court_case_and_send_court_to_lawyer/data/model/add_new_court_case_model.dart';
import 'package:ataaby/features/customer/courts/add_new_court_case_and_send_court_to_lawyer/screens/add_new_court_case_screen.dart';
import 'package:ataaby/features/customer/courts/add_new_court_case_and_send_court_to_lawyer/screens/send_order_to_lawyer_screen.dart';
import 'package:ataaby/features/lawyer/details_issue/screen/accept_issue_screen.dart';
import 'package:ataaby/features/lawyer/home_lawyer/data/model/home_Laywer_model.dart';
import 'package:ataaby/features/lawyer/my_advertiment_screen/screens/add_advertisment_screen.dart';
import 'package:ataaby/features/lawyer/my_advertiment_screen/screens/my_advertisment_screen.dart';
import 'package:ataaby/features/lawyer/order_this_product/screens/orders_screen.dart';
import 'package:ataaby/features/login/data/models/login_model_lawyer.dart';
import 'package:ataaby/features/new_register/screens/activate_otp_code.dart';
import 'package:ataaby/features/new_register/screens/change_email_screen.dart';
import 'package:ataaby/features/change_password/screens/change_password_screen.dart';
import 'package:ataaby/features/chat/screens/message_screen.dart';
import 'package:ataaby/features/choose_type_registeration/screens/choose_type_registeration.dart';
import 'package:ataaby/features/new_register/screens/create_new_password.dart';
import 'package:ataaby/features/customer/courts/the_courts/screen/deatails_court_case_customer.dart';
import 'package:ataaby/features/customer/details_lawyer_from_customer/screens/details_lawyer_from_customer_part_screen.dart';
import 'package:ataaby/features/customer/details_lawyer_from_customer/screens/lawyer_office_screen.dart';
import 'package:ataaby/features/customer/main_customer/screens/main_customer.dart';
import 'package:ataaby/features/customer/offers_customer/screens/offers_customer_screen.dart';
import 'package:ataaby/features/customer/personal_data_customer/screens/personal_customer_data_screen.dart';
import 'package:ataaby/features/customer/setting_customer/screens/setting_customer_screen.dart';
import 'package:ataaby/features/new_register/screens/forget_password.dart';
import 'package:ataaby/features/lawyer/add_new_update/screens/add_new_update_screen.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/screens/add_new_lawyer_screen.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/screens/administrative_structure_of_the_office_screen.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/screens/lawyer_details_information.dart';
import 'package:ataaby/features/lawyer/current_issues/screen/current_issues.dart';
import 'package:ataaby/features/lawyer/market_lawyer/screen/details_product_screen.dart';
import 'package:ataaby/features/lawyer/details_issue/screen/deatails_issue.dart';
import 'package:ataaby/features/electronic_wallet/screens/electronic_wallet_screen.dart';
import 'package:ataaby/features/lawyer/home_lawyer/screen/home_lawyer.dart';
import 'package:ataaby/features/lawyer/main_lawyer/screens/main_lawyer.dart';
import 'package:ataaby/features/lawyer/market_lawyer/screen/market_lawyer.dart';
import 'package:ataaby/features/lawyer/order_this_product/screens/order_this_product_screen.dart';
import 'package:ataaby/features/lawyer/packages/screens/packages_screen.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/screens/send_issue_from_lawyer_or_subscribe_screen.dart';
import 'package:ataaby/features/lawyer/working_hours/screens/working_hours.dart';
import 'package:ataaby/features/login/screens/login.dart';
import 'package:ataaby/features/new_register/screens/new_register.dart';
import 'package:ataaby/features/notifications/screens/notifications_screens.dart';
import 'package:flutter/material.dart';
import 'package:ataaby/features/splash/screens/splash_screen.dart';
import '../../core/utils/app_strings.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/about_app/screens/about_app_screen.dart';
import '../../features/chat/screens/room_screen.dart';
import '../../features/customer/community_services/screen/community_details.dart';
import '../../features/customer/community_services/screen/community_services_screen.dart';
import '../../features/customer/contract_and_doc/data/model/contracts_model.dart';
import '../../features/customer/contract_and_doc/data/model/doc_model.dart';
import '../../features/customer/contract_and_doc/screen/contract_and_doc_screen.dart';
import '../../features/customer/courts/the_courts/screen/el_ataab_screen.dart';
import '../../features/customer/home_customer/screen/home_customer.dart';
import '../../features/customer/inheritance_and_zakat_cal/screens/cal_zakat.dart';
import '../../features/customer/inheritance_and_zakat_cal/screens/inheritance_and_zakat_calculation.dart';
import '../../features/customer/sos_courts/sos_lawyers/screens/send_sos_request.dart';
import '../../features/customer/sos_courts/sos_lawyers/screens/sos_lawyers.dart';
import '../../features/lawyer/add_new_update/data/model/model.dart';
import '../../features/lawyer/courtcase_shared_send/screen/courtcase_shared_and_send.dart';
import '../../features/lawyer/market_lawyer/data/model/all_products_model.dart';
import '../../features/new_register/screens/info_laywer.dart';
import '../../features/lawyer/personal_data/screens/personal_data_screen.dart';
import '../../features/lawyer/my_advertiment_screen/screens/subscribtion_screen.dart';
import '../../features/new_register/screens/verify_change_password.dart';
import '../../features/pdf_view/screen/pdf_view.dart';
import '../../features/society/screen/society_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String mainLawyerRoute = '/mainLawyerRoute';
  static const String mainCustomerRoute = '/mainCustomerRoute';
  static const String calZakatScreen = '/calZakatScreen';
  static const String pdfViewScreen = '/pdfViewScreen';
  static const String chooseTypeRegistrationRoute =
      '/chooseTypeRegistrationRoute';
  static const String onboardingPageRoute = '/onboardingPageRoute';
  static const String myAdvertismentRoute = '/myAdvertismentRoute';
  static const String addAdvertismentRoute = '/addAdvertismentRoute';
  static const String newRegisterRoute = '/newRegisterRoute';
  static const String infoLawyerScreen = '/InfoLawyerScreen';
  static const String forgetPasswordRoute = '/forgetPasswordRoute';
  static const String createNewPasswordRoute = '/createNewPasswordRoute';
  static const String verifyEmailRoute = '/verifyEmailRoute';
  static const String homeLawyerRoute = '/homeLawyerRoute';
  static const String detailsIssueLawyerRoute = '/detailsIssueLawyerRoute';
  static const String detailsIssueCustomerRoute = '/detailsIssueCustomerRoute';
  static const String acceptIssueRoute = '/acceptIssueRoute';
  static const String currentIssuesRoute = '/currentIssuesRoute';
  static const String personalInfoRoute = '/personalInfoRoute';
  static const String personalCustomerInfoRoute = '/personalCustomerInfoRoute';
  static const String addNewUpdateRoute = '/addNewUpdateRoute';
  static const String homeCustomerRoute = '/homeCustomerRoute';
  static const String changePasswordRoute = '/changePasswordRoute';
  static const String detailsProductRoute = '/detailsProductRoute';
  static const String marketRoute = '/marketRoute';
  static const String detailsLawyerFromCustomerPartRoute =
      '/detailsLawyerFromCustomerPartRoute';
  static const String orderThisProductRoute = '/orderThisProductRoute';
  static const String electronicWalletRoute = '/electronicWalletRoute';
  static const String addNewLawyerRoute = '/addNewLawyerRoute';
  static const String workingHoursRoute = '/workingHoursRoute';
  static const String lawyerOfficeRoute = '/lawyerOfficeRoute';
  static const String notificationRoute = '/notificationRoute';
  static const String offersCustomerRoute = '/offersCustomerRoute';
  static const String aboutAppRoute = '/aboutAppRoute';
  static const String settingCustomerRoute = '/settingCustomerRoute';
  static const String changeEmailRoute = '/changeEmailRoute';
  static const String inheritanceAndZakatCalculatorRoute =
      '/inheritanceAndZakatCalculatorRoute';
  static const String activateAccountRoute = '/activateAccountRoute';
  static const String sendADistressRequestRoute = '/sendADistressRequestRoute';
  static const String messageRoute = '/messageRoute';
  static const String sendOrderToLawyerRoute = '/sendOrderToLawyerRoute';
  static const String sendIssueFromLawyerOrSubscribeRoute =
      '/sendIssueFromLawyerOrSubscribeRoute';
  static const String lawyerDetailsInformationRoute =
      '/lawyerDetailsInformationRoute';
  static const String administrativeStructureOfTheOfficeRoute =
      '/administrativeStructureOfTheOfficeRoute';
  static const String lawyerToSendDistressRequestRoute =
      '/lawyerToSendDistressRequestRoute';
  static const String publishNewIssueRoute = '/publishNewIssueRoute';
  static const String contractAndDocumentScreen = '/contractAndDocumentScreen';
  static const String societyMainScreen = '/societyMainScreen';
  static const String communityServicesScreen = '/communityServicesScreen';
  static const String communityDetailsScreen = '/communityDetailsScreen';
  static const String packagesScreen = '/packagesScreen';
  static const String subscribtionScreen = '/subscribtionScreen';
  static const String elAtaabScreen = '/elAtaabScreen';
  static const String ordersScreen = '/ordersScreen';
  static const String chatRoom = '/chatRoom';
  static const String courtcaseSharedAndSendScreenRoute =
      '/courtcaseSharedAndSendScreenRoute';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      // ------------------ login ------------------- //
      case Routes.chooseTypeRegistrationRoute:
        return PageTransition(
          child: const ChooseTypeRegisterScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ login ------------------- //
      case Routes.loginRoute:
        ChooseTypeRegisterArgs args =
            settings.arguments as ChooseTypeRegisterArgs;
        return PageTransition(
          child: LoginScreen(args: args),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ main lawyer------------------- //
      case Routes.mainLawyerRoute:
        ChooseTypeRegisterArgs args =
            settings.arguments as ChooseTypeRegisterArgs;
        return PageTransition(
          child: MainLawyerScreen(
            args: args,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ main customer ------------------- //
      case Routes.mainCustomerRoute:
        ChooseTypeRegisterArgs args =
            settings.arguments as ChooseTypeRegisterArgs;
        return PageTransition(
          child: MainCustomerScreen(
            args: args,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ new register ------------------- //
      case Routes.newRegisterRoute:
        ChooseTypeRegisterArgs args =
            settings.arguments as ChooseTypeRegisterArgs;
        return PageTransition(
          child: NewRegisterScreen(args: args),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );

      // ------------------ inheritanceAndZakatCalculatorRoute ------------------- //
      case Routes.inheritanceAndZakatCalculatorRoute:
        return PageTransition(
          child: const InheritanceAndZakatCalculatorScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ Info Lawyer ------------------- //
      case Routes.infoLawyerScreen:
        ChooseTypeRegisterArgs args =
            settings.arguments as ChooseTypeRegisterArgs;
        return PageTransition(
          child: InfoLawyerScreen(args: args),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );

      // ------------------ forget password ------------------- //
      case Routes.forgetPasswordRoute:
        ChooseTypeRegisterArgs args =
            settings.arguments as ChooseTypeRegisterArgs;
        return PageTransition(
          child: ForgetPasswordScreen(args: args),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );

      // ------------------ create new password ------------------- //
      case Routes.createNewPasswordRoute:
        ChooseTypeRegisterArgs args =
            settings.arguments as ChooseTypeRegisterArgs;
        return PageTransition(
          child: CreateNewPasswordScreen(args: args),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ activate Email ------------------- //
      case Routes.verifyEmailRoute:
        ChooseTypeRegisterArgs args =
            settings.arguments as ChooseTypeRegisterArgs;
        return PageTransition(
          child: VerifyEmailScreen(args: args),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ activate Email ------------------- //
      case Routes.activateAccountRoute:
        ChooseTypeRegisterArgs args =
            settings.arguments as ChooseTypeRegisterArgs;
        return PageTransition(
          child: ActivateAccountScreen(
            args: args,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ home customer ------------------- //
      case Routes.homeLawyerRoute:
        return PageTransition(
          child: const HomeLawyerScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );

      // ------------------ details issue  ------------------- //
      case Routes.detailsIssueLawyerRoute:
        NewCourtCase newCourtCase = settings.arguments as NewCourtCase;
        return PageTransition(
          child: DetailsIssueScreen(
            newCourtCase: newCourtCase,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );

      // ------------------ details issue Customer  ------------------- //
      case Routes.detailsIssueCustomerRoute:
        String id = settings.arguments as String;
        return PageTransition(
          child: DetailsIssueCustomerScreen(id: id),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );

      // ------------------ accept Issue ------------------- //
      case Routes.acceptIssueRoute:
        bool isShowAt3aby = settings.arguments as bool;
        return PageTransition(
          child: AcceptIssueScreen(
            isShowAt3aby: isShowAt3aby,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ current issues ------------------- //
      case Routes.currentIssuesRoute:
        return PageTransition(
          child: const CurrentIssuesScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ personal info ------------------- //
      case Routes.personalInfoRoute:
        bool isLawyer = settings.arguments as bool;

        return PageTransition(
          child: PersonalDataScreen(isLawyer: isLawyer),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        ); // ------------------ personal info ------------------- //
      case Routes.homeCustomerRoute:
        return PageTransition(
          child: const HomeCustomerScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ add new update ------------------- //
      case Routes.addNewUpdateRoute:
        // String courtCaseId = settings.arguments as String;
        // bool? isUpdate = settings.arguments as bool?;
        // String? updateId = settings.arguments as String?;
        UpdateCourtCaseModel list = settings.arguments as UpdateCourtCaseModel;
        return PageTransition(
          child: AddNewUpdateScreen(
            courtCaseId: list.courtid,
            isUpdate: list.isUpdate,
            updateId: list.updateid,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------change password ------------------- //
      case Routes.changePasswordRoute:
        bool isLawyer = settings.arguments as bool;

        return PageTransition(
          child: ChangePasswordScreen(
            isLawyer: isLawyer,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ market  ------------------- //
      case Routes.marketRoute:
        return PageTransition(
          child: const MarketLawyerScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ details category  ------------------- //
      case Routes.detailsProductRoute:
        MarketProduct product = settings.arguments as MarketProduct;

        return PageTransition(
          child: DetailsProductScreen(
            product: product,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ order this product  ------------------- //
      case Routes.orderThisProductRoute:
        MarketProduct product = settings.arguments as MarketProduct;

        return PageTransition(
          child: OrderThisProductScreen(product: product),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ Electronic Wallet ------------------- //
      case Routes.electronicWalletRoute:
        bool isLawyer = settings.arguments as bool;
        return PageTransition(
          child: ElectronicWalletScreen(
            isLawyer: isLawyer,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ Administrative Structure Of The Office ------------------- //
      case Routes.administrativeStructureOfTheOfficeRoute:
        return PageTransition(
          child: const AdministrativeStructureOfTheOfficeScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ Administrative Structure Of The Office ------------------- //
      case Routes.addNewLawyerRoute:
        return PageTransition(
          child: const AddNewLawyerScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ Details lawyer info ------------------- //
      case Routes.lawyerDetailsInformationRoute:
        String lawyerId = settings.arguments as String;
        return PageTransition(
          child: LawyerDetailsInformationScreen(
            lawyerId: int.parse(lawyerId),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ Working Hours ------------------- //
      case Routes.workingHoursRoute:
        int lawyerId = settings.arguments as int;
        return PageTransition(
          child: WorkingHoursScreen(
            lawyerId: lawyerId,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ send Issue From Lawyer Or Subscribe ------------------- //
      case Routes.sendIssueFromLawyerOrSubscribeRoute:
        final args = settings.arguments as Map<String, dynamic>? ??
            {}; // استخدام خريطة آمنة
        final bool sendFromAnotherLawyer =
            args['sendFromAnotherLawyer'] as bool? ?? false;
        final CourtData? courtData = args['courtData'] as CourtData?;

        if (courtData == null) {
          throw ArgumentError("CourtData cannot be null for this route.");
        }

        return PageTransition(
          child: SendIssueFromLawyerOrSubscribeScreen(
            courtData: courtData,
            sendFromAnatherLawyer: sendFromAnotherLawyer,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );

      // ------------------Details Lawyer From Customer Part ------------------- //
      case Routes.detailsLawyerFromCustomerPartRoute:
        int lawyerId = settings.arguments as int;
        return PageTransition(
          child: DetailsLawyerFromCustomerPartScreen(
            lawyerId: lawyerId,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ Lawyer Office ------------------- //
      case Routes.lawyerOfficeRoute:
        return PageTransition(
          child: const LawyerOfficeScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ Send Order To Lawyer ------------------- //
      case Routes.sendOrderToLawyerRoute:
        LoginModelLawyerData lawyer =
            settings.arguments as LoginModelLawyerData;
        return PageTransition(
          child: SendOrderToLawyerScreen(
            lawyer: lawyer,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );

      // ------------------ notification  ------------------- //
      case Routes.notificationRoute:
        bool isLawyer = settings.arguments as bool;
        return PageTransition(
          child: NotificationsScreen(
            isLawyer: isLawyer,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );

      // ------------------ about app  ------------------- //
      case Routes.aboutAppRoute:
        bool isLawyer = settings.arguments as bool;
        return PageTransition(
          child: AboutAppScreen(
            isLawyer: isLawyer,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ chat screen ------------------- //
      case Routes.messageRoute:
        MainUserAndRoomChatModel model =
            settings.arguments as MainUserAndRoomChatModel;
        return PageTransition(
          child: MessageScreen(
            model: model,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );

      // ------------------ SendADistressRequest ------------------- //
      case Routes.sendADistressRequestRoute:
        String lawyerId = settings.arguments as String;
        return PageTransition(
          child: SendSosRequestScreen(
            lawyerId: lawyerId,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );

      // ------------------ lawyerToSendDistressRequestRoute ------------------- //
      case Routes.lawyerToSendDistressRequestRoute:
        return PageTransition(
          child: const SosLawyersScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );

      // ------------------ PublishNewIssueScreen ------------------- //
      case Routes.publishNewIssueRoute:
        return PageTransition(
          child: const AddNewCourtCaseScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ personalCustomerInfoRoute ------------------- //
      case Routes.personalCustomerInfoRoute:
        return PageTransition(
          child: const PersonalCustomerDataScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );

      // ------------------ changeEmailRoute ------------------- //
      case Routes.changeEmailRoute:
        bool isLawyer = settings.arguments as bool;
        return PageTransition(
          child: ChangeEmailScreen(
            isLawyer: isLawyer,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ offersCustomerRoute ------------------- //
      case Routes.offersCustomerRoute:
        return PageTransition(
          child: const OffersCustomerScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ SettingCustomerCubit ------------------- //
      case Routes.settingCustomerRoute:
        return PageTransition(
          child: const SettingCustomerScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      // ------------------ SettingCustomerCubit ------------------- //
      case Routes.calZakatScreen:
        String title = settings.arguments as String;
        return PageTransition(
          child: CalZakatScreen(
            title: title,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        ); // ------------------ ORDERS ------------------- //
      case Routes.ordersScreen:
        return PageTransition(
          child: const OrdersScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      case Routes.pdfViewScreen:
        PDFFileElement pdfModel = settings.arguments as PDFFileElement;
        return PageTransition(
          child: PDFViewScreen(
            pdfModel: pdfModel,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      case Routes.contractAndDocumentScreen:
        return PageTransition(
          child: const ContractAndDocumentScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      case Routes.societyMainScreen:
        bool isLawyer = settings.arguments as bool;
        return PageTransition(
          child: SocietyMainScreen(
            isLawyer: isLawyer,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      case Routes.communityServicesScreen:
        bool isLawyer = settings.arguments as bool;
        return PageTransition(
          child: CommunityServicesScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      case Routes.myAdvertismentRoute:
        String idFromPackage = settings.arguments as String;
        return PageTransition(
          child: MyAdvertismentScreen(
            idFromPackage: idFromPackage,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      case Routes.addAdvertismentRoute:
        String id = settings.arguments as String;
        return PageTransition(
          child: AddAdvertismentScreen(
            id: id,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      case Routes.communityDetailsScreen:
        return PageTransition(
          child: CommunityServicesScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      case Routes.subscribtionScreen:
        ChooseTypeRegisterArgs model =
            settings.arguments as ChooseTypeRegisterArgs;
        return PageTransition(
          child: SubscribtionScreen(args: model),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      case Routes.packagesScreen:
        ChooseTypeRegisterArgs model =
            settings.arguments as ChooseTypeRegisterArgs;
        return PageTransition(
          child: PackagesScreen(args: model),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      case Routes.elAtaabScreen:
        int id = settings.arguments as int;
        return PageTransition(
          child: ElAtaabScreen(id: id.toString()),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      case Routes.chatRoom:
        bool islawyer = settings.arguments as bool;
        return PageTransition(
          child: RoomScreen(isLawyer: islawyer),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );
      case Routes.courtcaseSharedAndSendScreenRoute:
        return PageTransition(
          child: const CourtcaseSharedAndSendScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
