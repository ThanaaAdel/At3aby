import 'dart:async';
import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:app_links/app_links.dart';
import 'package:ataaby/core/exports.dart';

import '../../login/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Timer _timer;

  _goNext() {
    navigateToHome();
    // _initializeAppLinks();
  }

  _startDelay() async {
    _timer = Timer(
      const Duration(seconds: 2, milliseconds: 200),
      () {
        _goNext();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // context.read<SplashCubit>().getAdsOfApp();

    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.secondPrimary,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // alignment: Alignment.center,
            children: [
              Expanded(
                child: Container(),
              ),
              // const SplashFrameOne(isSplash: true),
              Expanded(
                flex: 2,
                child: FadeIn(
                  animate: true,
                  delay: const Duration(milliseconds: 500),
                  duration: const Duration(seconds: 4),
                  child: Image.asset(
                    ImageAssets.splashLogoImage,
                    height: getHeightSize(context) / 1,
                    width: getWidthSize(context) / 1,
                  ),
                ),
              ),
              Expanded(child: Image.asset(ImageAssets.frameOneFooter)),
            ],
          ),
        ),

        //!
        Positioned(
          top: -100,
          right: -50,
          child: Image.asset(ImageAssets.frameOneHeader,
              height: 300.h, width: 300.w),
        ),
        Positioned(
            top: -100,
            right: -50,
            child: Image.asset(ImageAssets.frameOneHeader,
                height: 200.h, width: 200.w)),
      ],
    );
  }

  //!
  late final AppLinks _appLinks;

  //! Normal Navigation Steps
  Future<void> navigateToHome() async {
    final userModel = await Preferences.instance.getUserModel();
    final lawyerModel = await Preferences.instance.getLawyerModel();
    log('======>> userModel  ${userModel.toString()}');
    log('======>> user Token  ${userModel.data?.token.toString()}');
    log('======>> lawyerModel ${lawyerModel.toString()}');
    log('======>> lawyerToken  ${lawyerModel.data?.token.toString()}');
    log('======>> lawyerModel.data ${lawyerModel.data != null}');
    if (userModel.data != null && lawyerModel.data == null) {
      Navigator.pushReplacementNamed(
        context,
        Routes.mainCustomerRoute,
        arguments: ChooseTypeRegisterArgs(indexPageClientOrLawyer: 0),
      );
    } else if (lawyerModel.data != null && userModel.data == null) {
      Navigator.pushReplacementNamed(
        context,
        Routes.mainLawyerRoute,
        arguments: ChooseTypeRegisterArgs(indexPageClientOrLawyer: 1),
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        Routes.chooseTypeRegistrationRoute,
      );
    }
  }

  Future<void> _initializeAppLinks() async {
    _appLinks = AppLinks();

    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleDeepLink(initialLink);
    } else {
      navigateToHome();
    }

    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    }, onError: (err) {
      debugPrint('Error handling deep link: $err');
    });
  }
  //! Navigation Of deep Link  -->

  void _handleDeepLink(Uri initialDeepLink) {
    print("==> the link is : ${initialDeepLink.toString()}");
    if (initialDeepLink.toString().contains("product")) {
      String id = initialDeepLink.queryParameters['id'] ?? "-1";
      Navigator.pushReplacementNamed(
        context,
        Routes.notificationRoute,
        arguments: false,
      );
    } else {
      //! chooseTypeRegistrationRoute
      Navigator.pushReplacementNamed(context, Routes.mainCustomerRoute,
          arguments: ChooseTypeRegisterArgs(indexPageClientOrLawyer: 0));
    }
  }

  //!
}
