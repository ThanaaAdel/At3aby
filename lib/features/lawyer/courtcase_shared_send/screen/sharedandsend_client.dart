import 'package:easy_localization/easy_localization.dart';
import '../../../../core/exports.dart';
import '../../../../core/utils/custom_loading.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../data/models/get_send_courtcases_model.dart';
import '../data/models/sharedcases_model.dart';
import 'courtcase_details.dart';

class CourtcaseSharedAndSendClientScreen extends StatefulWidget {
  const CourtcaseSharedAndSendClientScreen({super.key});

  @override
  State<CourtcaseSharedAndSendClientScreen> createState() =>
      _CourtcaseSharedAndSendClientScreenState();
}

class _CourtcaseSharedAndSendClientScreenState
    extends State<CourtcaseSharedAndSendClientScreen> {
  @override
  void initState() {
    context.read<CourtcaseSharedandSendCubit>().getAllTransferCourtCases();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourtcaseSharedandSendCubit,
        CourtcaseSharedandSendState>(
      builder: (context, state) {
        var cubit = context.read<CourtcaseSharedandSendCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'court_case_send'.tr(),
            ),
            elevation: 0,
          ),
          body: (state is LoadingGetAllTransferCourtCasesState ||
                  cubit.getSendCourtsClientModel == null)
              ? Center(
                  child: CustomLoadingIndicator(),
                )
              : cubit.getSendCourtsClientModel?.data?.length == 0
                  ? Center(
                      child: Text('no_data'.tr()),
                    )
                  : ListView.builder(
                      itemCount: cubit.getSendCourtsClientModel?.data?.length,
                      itemBuilder: (context, index) {
                        final sendCase =
                            cubit.getSendCourtsClientModel?.data?[index];
                        return InkWell(
                          onTap: () {},
                          child: CaseWidget.send(
                            model: sendCase ?? GetSendCourtsClientModelData(),
                          ),
                        );
                      },
                    ), //
        );
      },
    );
  }
}

// Custom Widget for displaying Case Name and Lawyer Name
class CaseWidget extends StatelessWidget {
  factory CaseWidget.send({
    required GetSendCourtsClientModelData model,
  }) {
    return CaseWidget._internal(model: model);
  }

  const CaseWidget._internal({
    required this.model,
  });

  final GetSendCourtsClientModelData model;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CourtcaseSharedandSendCubit>();
    return Card(
      color: Colors.white,
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${'issue_address'.tr()}: ${model.courtCaseName ?? ''}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                    fontSize: 16, color: Colors.grey), // Base style
                children: [
                  TextSpan(
                    text: '${'do_you_accepted'.tr()}: ',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ), // Prompt text
                  TextSpan(
                    text: model.oldLawyer ?? '',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' ${'to'.tr()} ',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.grey, // Different color for data
                      fontWeight: FontWeight.bold, // Optional: Bold font
                    ),
                  ), // Transition word
                  TextSpan(
                    text: model.newLawyer ?? '', // New lawyer name
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.primary, // Different color for data

                      fontWeight: FontWeight.bold, // Optional: Bold font
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                        onTap: () {
                          cubit.transferCourtCaseToAnotherLawyerResponse(
                              courtCaseEventId: model.eventId.toString(),
                              context: context,
                              transferClientStatus: '1');
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
                  10.w.horizontalSpace,
                  Expanded(
                    child: CustomButton(
                        onTap: () {
                          cubit.transferCourtCaseToAnotherLawyerResponse(
                              courtCaseEventId: model.eventId.toString(),
                              context: context,
                              transferClientStatus: '2');
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
