import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/cubit/Sos_lawyers_cubit.dart';
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/cubit/sos_lawyers_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'widgets/play_rec.dart';

class SendSosRequestScreen extends StatefulWidget {
  const SendSosRequestScreen({super.key, required this.lawyerId});
  final String lawyerId;
  @override
  State<SendSosRequestScreen> createState() => _SendSosRequestScreenState();
}

class _SendSosRequestScreenState extends State<SendSosRequestScreen> {
  @override
  void initState() {
    var cubit = context.read<SosLawyersCubit>();
    cubit.initializeRecorder();
    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SosLawyersCubit>();
    return WillPopScope(
      onWillPop: () async {
        await cubit.stopRecording();
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        body: BlocBuilder<SosLawyersCubit, SosLawyersState>(
            builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ContractsDataModel
                AppbarContainImage(
                  onTap: () async {
                    await cubit.stopRecording();
                    Navigator.pop(context);
                  },
                  isLawyer: false,
                  titleCenter: "send_distress_request".tr(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'dont_worry'.tr(),
                          style: getRegularStyle(
                              fontSize: 14.sp * textScaleFactor(context),
                              color: AppColors.green),
                        ),
                        Text(
                          'lawyer_will_contact'.tr(),
                          style: getRegularStyle(
                              fontSize: 15.sp, color: AppColors.blackLight),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextField(
                          controller: cubit.descriptionProblemController,
                          padding: EdgeInsets.zero,
                          isMessage: true,
                          titleFromTextFormField: "issue_description".tr(),
                          hintText: "issue_description".tr(),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "هذا الحقل مطلوب"; // نص الخطأ إذا كان الحقل فارغًا
                            }
                            return null; // لا يوجد خطأ
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'you_can_record'.tr(),
                          style: getRegularStyle(
                              fontSize: 14.sp * textScaleFactor(context),
                              color: AppColors.green),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (cubit.recorderController.isRecording ==
                                    true) {
                                  cubit.stopRecording();
                                } else {
                                  cubit.startRecording(context);
                                }
                              },
                              icon: Stack(
                                alignment: Alignment.center,
                                children: [
                                  if (cubit.recorderController.isRecording)
                                    Image.asset(
                                      'assets/icons/voice_rec.gif',
                                      width: 50.w,
                                      height: 50.w,
                                    ),
                                  Icon(
                                      cubit.recorderController.isRecording
                                          ? Icons.stop
                                          : Icons.keyboard_voice,
                                      color: AppColors.primary),
                                ],
                              ),
                            ),
                            if (cubit.recordedFilePath != null)
                              Flexible(
                                child: AudioPlayerWidget(
                                    audioFilePath:
                                        cubit.recordedFilePath ?? ''),
                              ),
                          ],
                        ),

                        SizedBox(height: 10.h),
                        // PlayRecordWidget(cubit: cubit),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextField(
                          controller: cubit.phoneController,
                          padding: EdgeInsets.zero,
                          keyboardType: TextInputType.number,
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: SvgPicture.asset(ImageAssets.phoneIcon),
                          ),
                          titleFromTextFormField: "phone".tr(),
                          hintText: "phone".tr(),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "رقم الهاتف مطلوب";
                            }
                            // if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            //   return "يرجى إدخال رقم هاتف صحيح مكون من 10 أرقام";
                            // }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextField(
                          controller: cubit.addressController,
                          padding: EdgeInsets.zero,
                          titleFromTextFormField: "your_address".tr(),
                          hintText: "your_address".tr(),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "العنوان مطلوب";
                            }
                            return null;
                          },
                        ),
                        // SizedBox(
                        //   height: 10.h,
                        // ),
                        //
                        // GestureDetector(
                        //   onTap: () async {
                        //     final url = Uri.parse(
                        //         "https://www.google.com/maps/search/?api=1&query=");
                        //     if (await canLaunchUrl(url)) {
                        //       await launchUrl(url);
                        //     } else {
                        //       throw 'Could not open the map.';
                        //     }
                        //   },
                        //   child: Align(
                        //     alignment: EasyLocalization.of(context)!
                        //                 .locale
                        //                 .languageCode ==
                        //             'en'
                        //         ? Alignment.centerLeft
                        //         : Alignment.topLeft,
                        //     child: Text(
                        //       "open_map".tr(),
                        //       style: getUnderLine(
                        //           fontSize: 16.sp, color: AppColors.primary),
                        //     ),
                        //   ),
                        // ),

                        SizedBox(
                          height: 20.h,
                        ),
                        (state is LoadingAddSosRequestState)
                            ? Center(
                                child: CustomLoadingIndicator(),
                              )
                            : CustomButton(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    Navigator.pushNamed(
                                        context,
                                        Routes
                                            .lawyerToSendDistressRequestRoute);
                                  }
                                },
                                widget: Center(
                                  child: Text(
                                    "send_distress_request".tr(),
                                    style:
                                        getRegularStyle(color: AppColors.white),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
