import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/lawyer/issues_status/screen/issues_status.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import 'widgets/court_widget.dart';

class TheCourtsCustomerScreen extends StatefulWidget {
  const TheCourtsCustomerScreen({super.key});

  @override
  State<TheCourtsCustomerScreen> createState() =>
      _TheCourtsCustomerScreenState();
}

class _TheCourtsCustomerScreenState extends State<TheCourtsCustomerScreen> {
  late TheCourtsCustomerCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<TheCourtsCustomerCubit>();
    cubit.getCourtData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TheCourtsCustomerCubit, TheCourtsCustomerState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildAppBar(),
              _buildIssueStatus(),
              _buildCourtList(state),
              _buildPublishButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return Stack(
      children: [
        Image.asset(
          ImageAssets.smallAppbarCustomerImage,
          width: double.infinity,
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: 10.0.h, top: 30.0.h, right: 5.w, left: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                ImageAssets.coloredLogoImage,
                height: 60.h,
                width: 60.w,
                color: AppColors.white,
              ),
              Text(
                "issues".tr(),
                style: getRegularStyle(color: AppColors.white),
              ),
              _buildAppBarIcons(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppBarIcons() {
    return Row(
      children: [
        _buildIcon(
          ImageAssets.messageIcon,
          Routes.chatRoom,
        ),
        SizedBox(width: 10.w),
        _buildIcon(ImageAssets.notificationIcon, Routes.notificationRoute),
      ],
    );
  }

  Widget _buildIcon(String asset, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route, arguments: false),
      child: SvgPicture.asset(
        asset,
        color: AppColors.white,
      ),
    );
  }

  Widget _buildIssueStatus() {
    return IssueStatus(
      onTap: cubit.changeIndex,
      currentIndex: cubit.currentIndex,
      titles: [
        "current_issues".tr(),
        "ended_issues".tr(),
        "Distress_issues".tr(),
      ],
    );
  }

  Widget _buildCourtList(TheCourtsCustomerState state) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cubit.currentIndex == 0
                  ? "list_current_issues".tr()
                  : cubit.currentIndex == 1
                      ? "list_ended_issues".tr()
                      : "list_distress_issues".tr(),
              style: getBoldStyle(fontSize: 15.sp, color: AppColors.blackLight),
            ),
            _buildCourtItems(state),
          ],
        ),
      ),
    );
  }

  Widget _buildCourtItems(TheCourtsCustomerState state) {
    if (state is LoadingGetCourtData) {
      return Center(child: CustomLoadingIndicator());
    }
    if (cubit.courtCaseModel?.data?.isEmpty ?? true) {
      return Expanded(
        child: Center(
          child: Text(
            "no_data".tr(),
            style:
                getRegularStyle(fontSize: 14.sp, color: AppColors.blackLight),
          ),
        ),
      );
    }
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: cubit.courtCaseModel?.data?.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          child: TheCourtsCustomerWidget(
            onTap: () => Navigator.pushNamed(
              context,
              Routes.detailsIssueCustomerRoute,
              arguments: cubit.courtCaseModel!.data![index].id.toString(),
            ),
            courtData: cubit.courtCaseModel!.data![index],
          ),
        ),
      ),
    );
  }

  Widget _buildPublishButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: CustomButton(
        onTap: () => Navigator.pushNamed(context, Routes.publishNewIssueRoute),
        widget: Center(
          child: Text(
            "+ ${"publish_new_issue".tr()}",
            style: getRegularStyle(
              color: AppColors.white,
              fontSize: 14.sp * textScaleFactor(context),
            ),
          ),
        ),
      ),
    );
  }
}
