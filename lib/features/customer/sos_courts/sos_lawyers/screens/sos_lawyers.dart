import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/features/chat/screens/message_screen.dart';
import 'package:ataaby/features/customer/home_customer/screen/widgets/lawer_item.dart';
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/cubit/Sos_lawyers_cubit.dart';
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/cubit/sos_lawyers_state.dart';
import 'package:easy_localization/easy_localization.dart';

class SosLawyersScreen extends StatefulWidget {
  const SosLawyersScreen({super.key});

  @override
  State<SosLawyersScreen> createState() => _SosLawyersScreenState();
}

class _SosLawyersScreenState extends State<SosLawyersScreen> {
  @override
  initState() {
    super.initState();

    context.read<SosLawyersCubit>().sosLawyerData(context);
  }

  Widget build(BuildContext context) {
    var cubit = context.read<SosLawyersCubit>();
    return Scaffold(
      body: BlocBuilder<SosLawyersCubit, SosLawyersState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarContainImage(
                isLawyer: false,
                titleCenter: "send_distress_request".tr(),
              ),
              SizedBox(height: 20.h),
              (state is LoadingSosLawyerState)
                  ? Expanded(child: CustomLoadingIndicator())
                  : Expanded(
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                              child: Text(
                                "dont_worry_we_are_close".tr(),
                                style: getRegularStyle(
                                    fontSize: 14.sp * textScaleFactor(context),
                                    color: AppColors.green),
                              ),
                            ),
                            if (cubit.sosLawyerRequestModel?.data?.myLawyers
                                    ?.length !=
                                0)
                              _buildLawyersSection(
                                  title: "already_interacted".tr(),
                                  lawyers: cubit
                                      .sosLawyerRequestModel?.data?.myLawyers,
                                  cubit: cubit),
                            if (cubit.sosLawyerRequestModel?.data?.nearLawyers
                                    ?.length !=
                                0)
                              _buildLawyersSection(
                                  title: "no_lawyers_near".tr(),
                                  lawyers: cubit
                                      .sosLawyerRequestModel?.data?.nearLawyers,
                                  cubit: cubit),
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

  Widget _buildLawyersSection({
    required String title,
    required List<dynamic>? lawyers,
    required SosLawyersCubit cubit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getBoldStyle(fontSize: 15.sp, color: AppColors.blackLight),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: lawyers?.length ?? 0,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  LawyerItem(
                    loginModelLawyer: lawyers?[index],
                    type: "distress_request",
                  ),
                  Positioned(
                    left: 10,
                    bottom: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.messageRoute,
                            arguments: MainUserAndRoomChatModel(
                              receiverId: lawyers?[index].id.toString(),
                              isLawyer: true,
                            ));
                        cubit.addSosRequest(context,
                            lawyerId: lawyers?[index].id?.toString() ?? "");
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 160.h, right: 180.w, left: 10.w),
                        padding:
                            EdgeInsets.all(8.sp * textScaleFactor(context)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.sp),
                          color: AppColors.primary,
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SvgPicture.asset(ImageAssets.messageIcon),
                              5.w.horizontalSpace,
                              Text(
                                "contact_us".tr(),
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
