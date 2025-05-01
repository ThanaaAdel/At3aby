import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/exports.dart';
import '../../cubit/cubit.dart';
import '../../data/models/send_courtcase_details_model.dart';

class HeaderOfCourtCaseWidget extends StatefulWidget {
  const HeaderOfCourtCaseWidget({super.key, this.model, this.isShared});
  final CourtCaseDetailsSendModelData? model;

  final bool? isShared;
  @override
  State<HeaderOfCourtCaseWidget> createState() =>
      _HeaderOfCourtCaseWidgetState();
}

class _HeaderOfCourtCaseWidgetState extends State<HeaderOfCourtCaseWidget> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CourtcaseSharedandSendCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.w.horizontalSpace,
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${"num_of_issue".tr()} : ${widget.model?.courtCase?.caseNumber.toString() ?? ''}",
                style: getRegularStyle(
                    fontSize: 14.sp * textScaleFactor(context),
                    color: AppColors.primary),
              ),
              Text(
                widget.model?.courtCase?.title ?? '',
                style: getRegularStyle(
                  fontSize: 14.sp * textScaleFactor(context),
                ),
              ),
              Text(
                widget.model?.courtCase?.details ?? '',
                style: getRegularStyle(
                    fontSize: 14.sp * textScaleFactor(context),
                    color: AppColors.gray),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(end: 22.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.model?.courtCase?.caseFinalPrice
                                      .toString() ??
                                  '',
                              style: getRegularStyle(
                                fontSize: 20.sp * textScaleFactor(context),
                                color: AppColors.greenLight,
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text("egp".tr(),
                              style: getRegularStyle(
                                  fontSize: 18.sp * textScaleFactor(context),
                                  color: AppColors.black))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                            onTap: () {
                              if (widget.isShared == true) {
                                cubit
                                    .shareCourtCaseToAnotherLawyerResponseLawyer(
                                        courtCaseEventId: widget.model
                                                ?.courtCase?.lawyerEvent?.id
                                                .toString() ??
                                            '',
                                        context: context,
                                        transferClientStatus: '1');
                              } else {
                                cubit
                                    .transferCourtCaseToAnotherLawyerResponseLawyer(
                                        courtCaseEventId: widget.model
                                                ?.courtCase?.lawyerEvent?.id
                                                .toString() ??
                                            '',
                                        context: context,
                                        transferClientStatus: '1');
                              }
                            },
                            widget: Center(
                              child: Text(
                                'accept'.tr(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ),
                    ),
                    10.w.horizontalSpace,
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                            onTap: () {
                              if (widget.isShared == true) {
                                cubit
                                    .shareCourtCaseToAnotherLawyerResponseLawyer(
                                        courtCaseEventId: widget.model
                                                ?.courtCase?.lawyerEvent?.id
                                                .toString() ??
                                            '',
                                        context: context,
                                        transferClientStatus: '2');
                              } else {
                                cubit
                                    .transferCourtCaseToAnotherLawyerResponseLawyer(
                                        courtCaseEventId: widget.model
                                                ?.courtCase?.lawyerEvent?.id
                                                .toString() ??
                                            '',
                                        context: context,
                                        transferClientStatus: '2');
                              }
                            },
                            color: AppColors.redLight,
                            widget: Center(
                              child: Text(
                                'reject'.tr(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        )
      ],
    );
  }
}
