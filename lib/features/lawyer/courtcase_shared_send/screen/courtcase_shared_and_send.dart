import 'package:easy_localization/easy_localization.dart';
import '../../../../core/exports.dart';
import '../../../../core/utils/custom_loading.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../data/models/get_send_courtcases_model.dart';
import '../data/models/getallshared_courtcase.dart';
import '../data/models/sharedcases_model.dart';
import 'courtcase_details.dart';
import 'details_of_shared.dart';

class CourtcaseSharedAndSendScreen extends StatefulWidget {
  const CourtcaseSharedAndSendScreen({super.key});

  @override
  State<CourtcaseSharedAndSendScreen> createState() =>
      _CourtcaseSharedAndSendScreenState();
}

class _CourtcaseSharedAndSendScreenState
    extends State<CourtcaseSharedAndSendScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample data for Shared and Send tabs
  final List<SharedCase> _sharedCases = [
    SharedCase(id: '1', name: 'Case 1', lawyerName: 'Lawyer A', price: 100.0),
    SharedCase(id: '2', name: 'Case 2', lawyerName: 'Lawyer B', price: 200.0),
    SharedCase(id: '3', name: 'Case 3', lawyerName: 'Lawyer C', price: 300.0),
  ];

  final List<SendCase> _sendCases = [
    SendCase(id: '4', name: 'Case 4', lawyerName: 'Lawyer D'),
    SendCase(id: '5', name: 'Case 5', lawyerName: 'Lawyer E'),
    SendCase(id: '6', name: 'Case 6', lawyerName: 'Lawyer F'),
  ];

  @override
  void initState() {
    context
        .read<CourtcaseSharedandSendCubit>()
        .getAllTransferCourtCaseslawyer();
    context.read<CourtcaseSharedandSendCubit>().getAllCourtCaseShared();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
              'courtcase_shared_send'.tr(),
            ),
            elevation: 0,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              tabs: [
                Tab(text: 'court_case_send'.tr()),
                Tab(
                  text: 'court_case_shared'.tr(),
                ),
              ],
            ),
          ),
          body: (state is LoadingGetAllTransferCourtCasesState)
              ? Center(child: CustomLoadingIndicator())
              : TabBarView(
                  controller: _tabController,
                  children: [
                    // Send Tab Content
                    cubit.getAllTransferCourtCaseslawyerModel?.data?.length == 0
                        ? Center(
                            child: Text('no_data'.tr()),
                          )
                        : ListView.builder(
                            itemCount: cubit.getAllTransferCourtCaseslawyerModel
                                ?.data?.length,
                            itemBuilder: (context, index) {
                              final sendCase = cubit
                                  .getAllTransferCourtCaseslawyerModel
                                  ?.data?[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CourtCaseDetailsSharedAndSendScreen(
                                        model:
                                            CourtCaseDetailsSharedAndSendModel(
                                          id: int.parse(
                                              sendCase?.eventId.toString() ??
                                                  ''),
                                          title: sendCase?.courtCaseName ?? '',
                                          isShared: false,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: CaseWidget.send(
                                  model: sendCase,
                                ),
                              );
                            },
                          ), // Shared Tab Content

                    (cubit.getAllCourtCaseSharedModel?.data?.length == 0)
                        ? Center(
                            child: Text('no_data'.tr()),
                          )
                        : ListView.builder(
                            itemCount:
                                cubit.getAllCourtCaseSharedModel?.data?.length,
                            itemBuilder: (context, index) {
                              final sharedCase = cubit
                                  .getAllCourtCaseSharedModel?.data?[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsOfSharedCourtcase(
                                        model:
                                            CourtCaseDetailsSharedAndSendModel(
                                          id: int.parse(
                                              sharedCase?.eventId?.toString() ??
                                                  ''),
                                          title:
                                              sharedCase?.courtCaseName ?? '',
                                          isShared: true,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child:
                                    CaseSharedWidget.shared(model: sharedCase),
                              );
                            },
                          ),
                  ],
                ),
        );
      },
    );
  }
}

// Custom Widget for displaying Case Name and Lawyer Name
class CaseWidget extends StatelessWidget {
  // Factory constructor for Send cases
  factory CaseWidget.send({
    GetSendCourtsClientModelData? model,
  }) {
    return CaseWidget._internal(model: model);
  }

  // Private constructor
  const CaseWidget._internal({required this.model});

  final GetSendCourtsClientModelData? model;

  @override
  Widget build(BuildContext context) {
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
              '${'issue_address'.tr()}: ${model?.courtCaseName ?? ''}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${'lawyer_data'.tr()}: ${model?.oldLawyer ?? ''}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class CaseSharedWidget extends StatelessWidget {
  // Factory constructor for Send cases
  factory CaseSharedWidget.shared({
    GetAllCourtCaseSharedModelData? model,
  }) {
    return CaseSharedWidget._internal(model: model);
  }

  // Private constructor
  const CaseSharedWidget._internal({required this.model});

  final GetAllCourtCaseSharedModelData? model;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0.w),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 18.sp * textScaleFactor(context),
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "${'issue_address'.tr()}: ",
                      style: TextStyle(color: AppColors.primary), // Title color
                    ),
                    TextSpan(
                      text: model?.courtCaseName ?? '',
                      style: TextStyle(
                          color: AppColors.blackLight,
                          fontWeight: FontWeight.w500), // Data color
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0.w),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 18.sp * textScaleFactor(context),
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                        text: "${'price'.tr()}: ",
                        style: TextStyle(color: AppColors.primary)),
                    TextSpan(
                        text: model?.contributionPrice.toString() ?? '',
                        style: TextStyle(
                            color: AppColors.blackLight,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0.w),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 18.sp * textScaleFactor(context),
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: "${'detailed_description_of_the_case'.tr()}: ",
                        style: TextStyle(color: AppColors.primary)),
                    TextSpan(
                        text: model?.contributionComment.toString() ?? '',
                        style: TextStyle(
                            color: AppColors.blackLight,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
