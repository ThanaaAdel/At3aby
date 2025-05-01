import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/features/lawyer/working_hours/cubit/working_hours_cubit.dart';
import 'package:ataaby/features/lawyer/working_hours/cubit/working_hours_state.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/widgets/switch_widget.dart';

class WorkingHoursScreen extends StatefulWidget {
  const WorkingHoursScreen({super.key, required this.lawyerId});
  final int lawyerId;
  @override
  State<WorkingHoursScreen> createState() => _WorkingHoursScreenState();
}

class _WorkingHoursScreenState extends State<WorkingHoursScreen> {
  @override
  initState() {
    super.initState();
    context.read<WorkingHoursCubit>().getLawyerWorkTimes();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<WorkingHoursCubit>();

    return Scaffold(
      body: BlocBuilder<WorkingHoursCubit, WorkingHoursState>(
          builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppbarContainImage(
              isLawyer: true,
              titleCenter: "working_hours".tr(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text("working_hours".tr()),
            ),
            (state is LoadingLawyerWorkTimesState)
                ? Center(
                    child: CustomLoadingIndicator(),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            cubit.lawyerWorkTimesModel?.data?.length ?? 0,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Container(
                            padding: EdgeInsets.all(
                              10.sp * textScaleFactor(context),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: customShadow,
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12.sp),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.lawyerWorkTimesModel?.data?[index]
                                          .day ??
                                      "",
                                  style:
                                      getRegularStyle(color: AppColors.primary),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "from".tr(),
                                      style: getRegularStyle(
                                          color: AppColors.black,
                                          fontSize: 15.sp),
                                    ),
                                    Text(
                                      "to".tr(),
                                      style: getRegularStyle(
                                          color: AppColors.black,
                                          fontSize: 15.sp),
                                    ),
                                    StyledSwitch(
                                      status: (cubit.lawyerWorkTimesModel?.data?[index].status == "active")
                                          ? true
                                          : false,
                                      onToggled: (value) {
                                        setState(() {
                                          String status = value ? "active" : "inactive";
                                          String day = cubit.lawyerWorkTimesModel?.data?[index].day ?? "";

                                          cubit.updateStatusLawyerWorkTimes(
                                            lawyerId: widget.lawyerId,
                                            status: status,
                                            day: day,
                                          );

                                          cubit.lawyerWorkTimesModel?.data?[index].status = status;
                                        });
                                      },
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          cubit.onSelectedTime(context, index,
                                              true); // true تعني "from"
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.grayLite),
                                            borderRadius:
                                                BorderRadius.circular(15.sp),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.h, horizontal: 20.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                cubit.lawyerWorkTimesModel
                                                        ?.data?[index].from ??
                                                    "ساعة:دقيقة",
                                                style: getRegularStyle(
                                                    fontSize: 16.sp,
                                                    color:
                                                        AppColors.blackLight),
                                              ),
                                              SizedBox(width: 10.w),
                                              SvgPicture.asset(
                                                  ImageAssets.timeIcon),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    10.w.horizontalSpace,
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          cubit.onSelectedTime(context, index,
                                              false); // false تعني "to"
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.grayLite),
                                            borderRadius:
                                                BorderRadius.circular(15.sp),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.h, horizontal: 20.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                cubit.lawyerWorkTimesModel
                                                        ?.data?[index].to ??
                                                    "ساعة:دقيقة",
                                                style: getRegularStyle(
                                                    fontSize: 16.sp,
                                                    color:
                                                        AppColors.blackLight),
                                              ),
                                              SizedBox(width: 10.w),
                                              SvgPicture.asset(
                                                  ImageAssets.timeIcon),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.only(
                  left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
              child: CustomButton(
                  onTap: () {
                    cubit.updateLawyerWorkTimes(
                      lawyerId: widget.lawyerId,
                    );
                  },
                  width: double.infinity,
                  widget: Center(
                      child: Text(
                    "update".tr(),
                    style: TextStyle(color: AppColors.white),
                  ))),
            ),
          ],
        );
      }),
    );
  }
}
