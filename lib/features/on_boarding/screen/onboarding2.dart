import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/get_size.dart';
import '../cubit/onboarding_cubit.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        OnboardingCubit cubit = context.read<OnboardingCubit>();
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: const [],
          ),
          body: Column(
            children: [
              SizedBox(
                height: getHeightSize(context) / 22,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.all(getHeightSize(context) / 22),
                  child: Center(
                    child: Image.asset(
                      ImageAssets.introBackgroundImage2,
                      // width: getSize(context) / 1.1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: getHeightSize(context) / 12),
              Container(
                child: Text(
                  'مبيعاتك أسهل وأكثر كفاءة',
                  style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.bold,
                      fontSize: getHeightSize(context) / 18),
                ),
              ),
              Container(
                padding: EdgeInsets.all(getHeightSize(context) / 44),
                child: Text(
                  'حقق أهدافك البيعية بفضل إدارة متقدمة للعمليات والمزيد من التحكم في كل خطوة.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Tajawal',
                      fontSize: getHeightSize(context) / 22),
                ),
              ),
              SizedBox(height: getHeightSize(context) / 12),
            ],
          ),
        );
      },
    );
  }
}
