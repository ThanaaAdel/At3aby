import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/cubit/administrative_structure_of_the_office_cubit.dart';
import 'package:ataaby/features/lawyer/administrative_structure_of_the_office/data/model/search_lawyer_model.dart';
import 'package:easy_localization/easy_localization.dart';

class LawyerInformationWidget extends StatefulWidget {
  const LawyerInformationWidget({
    super.key,
    required this.type,
    required this.searchLawyerModelData,
    required this.cubit,
    required this.id,
    this.onTapSelected,
  });
  final int id;
  final String type;
  final SearchLawyerModelData searchLawyerModelData;
  final AdministrativeStructureOfTheOfficeCubit cubit;
  final Function()? onTapSelected;

  @override
  State<LawyerInformationWidget> createState() =>
      _LawyerInformationWidgetState();
}

class _LawyerInformationWidgetState extends State<LawyerInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.lawyerDetailsInformationRoute,
            arguments: widget.searchLawyerModelData.lawyerId);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.h),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: customShadow,
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 25.sp,
                      backgroundImage: NetworkImage(
                          widget.searchLawyerModelData.image ?? ""),
                    ),
                    SizedBox(width: 5.w),
                    widget.type == "delete"
                        ? GestureDetector(
                            onTap: () {
                              widget.cubit.deleteLawyerFromOffice(
                                  id: widget.id.toString());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.grayLite,
                                borderRadius: BorderRadius.circular(
                                  8.sp * textScaleFactor(context),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  ImageAssets.deleteIcon,
                                  height: 14.h,
                                  width: 14.w,
                                ),
                              ),
                            ),
                          )
                        : widget.type == 'select'
                            ? CustomButton(
                                onTap: widget.onTapSelected,
                                color: AppColors.white,
                                border: Border.all(color: AppColors.primary),
                                widget: Text(
                                  "select".tr(),
                                  style: getRegularStyle(
                                      color: AppColors.primary,
                                      fontSize: 12.sp),
                                ))
                            : Container()
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  widget.searchLawyerModelData.name ?? "",
                  style: getRegularStyle(
                      fontSize: 14.sp * textScaleFactor(context),
                      color: AppColors.blackLight),
                ),
                SizedBox(height: 10.h),
                Text(
                  widget.searchLawyerModelData.type ?? "",
                  style: getRegularStyle(
                      fontSize: 14.sp * textScaleFactor(context),
                      color: AppColors.gray),
                ),
                SizedBox(height: 20.h),
                widget.type == "add"
                    ? CustomButton(
                        onTap: () {
                          widget.cubit.sendOfficeRequest(
                              lawyerId: widget.cubit.searchController.text);
                          Navigator.pushNamed(context,
                              Routes.administrativeStructureOfTheOfficeRoute);
                        },
                        widget: Center(
                          child: Text(
                            "add_lawyer".tr(),
                            style: getRegularStyle(
                              color: AppColors.white,
                              fontSize: 14.sp * textScaleFactor(context),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
