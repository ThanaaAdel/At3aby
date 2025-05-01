import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/customer/points/cubit/points_cubit.dart';
import 'package:ataaby/features/customer/points/cubit/points_state.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../../core/exports.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  @override

  void initState() {
    context.read<PointsCubit>().getPointsClientData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<PointsCubit>();
    return Scaffold(
      body: BlocBuilder<PointsCubit,PointsState>(
        builder: (context,state) {
          return
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: getWidthSize(context),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageAssets.pointsBackground),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Column(children: [
                  20.h.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: AppColors.white.withOpacity(0.2)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "points".tr(),
                            style: getSemiBoldStyle(
                                color: AppColors.white, fontSize: 16.sp),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "myPoints".tr(),
                            style: getSemiBoldStyle(
                                color: AppColors.white, fontSize: 16.sp),
                          ),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 10.h,
                              ),
                              child: Text(
                                "change_to_wallet".tr(),
                                style: getSemiBoldStyle(
                                    fontHeight: 1,
                                    color: AppColors.primary,
                                    fontSize: 16.sp),
                              ),
                            ),
                          )
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "${cubit.pointsModel?.data?.points ?? 0} ${"point".tr()}",
                              style: getRegularStyle(
                                fontHeight: 1,
                                color: AppColors.white,
                                fontSize: 26.sp * textScaleFactor(context),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.white,
                            size: 36.sp * textScaleFactor(context),
                          ),
                          Flexible(
                            child: Text(
                              "${cubit.pointsModel?.data?.cash ?? 0} ${"currency".tr()}",
                              style: getRegularStyle(
                                fontHeight: 1,
                                color: AppColors.white,
                                fontSize: 26.sp * textScaleFactor(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.verticalSpace,
                ]),
              ),
              20.h.verticalSpace,
              (state is LoadingPointsClientData)?
              Center(child: CustomLoadingIndicator(),):
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text("lastTransactions".tr(),
                          style: getBoldStyle(fontSize: 16.sp)),
                    ),
                    cubit.pointsModel?.data?.transactions == [] || cubit.pointsModel?.data?.transactions?.length == 0 ?
                        Center(child: Text("no_transaction".tr(),style: TextStyle(
                          color: AppColors.black,
                          fontSize: 20.sp
                        ),),):
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView.separated(
                          itemBuilder: (context, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(cubit.pointsModel?.data?.transactions![index].comment ?? ""),
                                  10.h.verticalSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        ImageAssets.appbarHomeCustomerImage,
                                        color: AppColors.grey,
                                        width: 25.w,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        cubit.pointsModel?.data?.transactions![index].createdAt ?? "",
                                        style: getRegularStyle(
                                          fontSize: 14.sp * textScaleFactor(context),
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                          separatorBuilder: (context, index) => const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Divider(),
                              ),
                          itemCount: cubit.pointsModel?.data?.transactions?.length ??0),
                    )),
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
