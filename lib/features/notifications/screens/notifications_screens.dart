import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/notifications/cubit/notifications_cubit.dart';
import 'package:ataaby/features/notifications/cubit/notifications_state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/widgets/appbar_with_image.dart';

class NotificationsScreen extends StatefulWidget {
   NotificationsScreen({super.key, required this.isLawyer});
  bool isLawyer;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    context.read<NotificationsCubit>().getNotificationClientData();
    context.read<NotificationsCubit>().getNotificationLawyersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          AppbarContainImage(
            isLawyer: widget.isLawyer ? true : false,
            titleCenter: "notifications".tr(),
          ),
          Expanded(
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {

                  var cubit = context.read<NotificationsCubit>();
                  final notifications = widget.isLawyer
                      ? cubit.notificationLawyerModel?.data
                      : cubit.notificationClientModel?.data;
                return (state is LoadingNotificationClientData ||
                      state is LoadingNotificationLawyersData)
                  ? Center(
                      child: CustomLoadingIndicator(),
                    )
                  :(notifications == null || notifications.isEmpty || notifications == []) ?
                Center(child: Text("no_notification".tr(),style: TextStyle(
                    color: AppColors.black,
                    fontSize: 20.sp
                ),),): ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.isLawyer
                          ? cubit.notificationLawyerModel?.data?.length ?? 0
                          : cubit.notificationClientModel?.data?.length ?? 0,
                      itemBuilder: (context, index){
                        var item = widget.isLawyer
                            ? cubit.notificationLawyerModel?.data![index]
                            : cubit.notificationClientModel?.data?[index];
                        return
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10.w,
                            left: 10.w,
                            bottom: 5.h,
                            top: 5.h
                          ),
                          child: Container(

                            decoration: BoxDecoration(
                              boxShadow: customShadow,
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12.sp),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.notificationIcon,
                                    color: AppColors.primary,
                                    height: 25.h,
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: getWidthSize(context) / 1.5,
                                        child: AutoSizeText(
                                          (   widget.isLawyer==true ?
                                          cubit.notificationLawyerModel?.data![index].body ?? ""
                                              :  cubit.notificationClientModel?.data?[index].body ?? "" ),
                                          maxLines: 2,
                                          style: getRegularStyle(
                                            color: AppColors.blackLight,
                                            fontSize: 14.sp * textScaleFactor(context),
                                          ),
                                        ),
                                      ),
                                      AutoSizeText(
                                        widget.isLawyer
                                            ? cubit.notificationLawyerModel?.data![index].createdAt ?? ""
                                            : cubit.notificationClientModel?.data?[index].createdAt ?? "",                                  style: getRegularStyle(
                                        color: AppColors.gray,
                                        fontSize: 14.sp * textScaleFactor(context),
                                      ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );

                      },
                    );
            }),
          )
        ],
      ),
    );
  }
}
