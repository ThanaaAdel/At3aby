import 'package:ataaby/core/widgets/search_text_field.dart';
import 'package:ataaby/features/customer/contract_and_doc/cubit/contract_and_doc_cubit.dart';
import 'package:ataaby/features/customer/contract_and_doc/cubit/contract_and_doc_state.dart';
import 'package:ataaby/features/customer/contract_and_doc/data/model/contracts_model.dart';
import 'package:ataaby/features/lawyer/market_lawyer/screen/widgets/appbar_home_lawyer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/exports.dart';
import '../../../../core/utils/custom_loading.dart';
import '../../community_services/cubit/cubit.dart';
import '../../community_services/cubit/state.dart';

class ContractAndDocumentScreen extends StatefulWidget {
  const ContractAndDocumentScreen({super.key});

  @override
  State<ContractAndDocumentScreen> createState() =>
      _ContractAndDocumentScreenState();
}

class _ContractAndDocumentScreenState extends State<ContractAndDocumentScreen> {
  @override
  initState() {
    super.initState();
    context.read<ContractAndDocumentCubit>().getContractsData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityServicesCubit, CommunityServicesState>(
      builder: (context, state) {
        return BlocBuilder<ContractAndDocumentCubit, ContractAndDocumentState>(
          builder: (context, state) {
            var cubit = context.read<ContractAndDocumentCubit>();
            return Scaffold(
              body: ListView(
                children: [
                  MainAppBarHomeWidget(
                    widget: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0.w),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grayLite,
                              offset: const Offset(1, 2),
                              blurRadius: 20,
                              blurStyle: BlurStyle.inner,
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      width: getWidthSize(context),
                      child: SearchTextField(
                        controller: cubit.searchController,
                        hintText: "search".tr(),
                        onChanged: (p0) {
                          context
                              .read<ContractAndDocumentCubit>()
                              .getContractsData();
                        },
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(ImageAssets.searchIcon),
                        ),
                      ),
                    ),
                    actionWidget: Container(),
                    isBackButton: true,
                    isSearchWidget: true,
                    textCenter: Text(
                      'free_contracts_and_documents'.tr(),
                      style: getBoldStyle(color: AppColors.white),
                    ),
                  ),
                  10.h.verticalSpace,
                  (state is LoadingGetContractsData)
                      ? Center(
                          child: CustomLoadingIndicator(),
                        )
                      : ListView.builder(
                          itemCount: cubit.getContractsModel?.data?.length ?? 0,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 8.0.h),
                                  child: Text(
                                    cubit.getContractsModel?.data?[index]
                                            .title ??
                                        "",
                                    style: TextStyle(
                                      color: AppColors.darkGray,
                                      fontSize:
                                          14.sp * textScaleFactor(context),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.h, horizontal: 16.w),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cubit.getContractsModel
                                          ?.data?[index].files?.length ??
                                      0,
                                  itemBuilder: (context, index2) {
                                    var item = cubit.getContractsModel
                                        ?.data?[index].files?[index2];

                                    return InkWell(
                                      onTap: () {
                                        cubit.onTapToOpenPdf(
                                            context, item ?? PDFFileElement());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: customShadow,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                ImageAssets.fileIcon,
                                              ),
                                              10.w.horizontalSpace,
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Text(
                                                  item?.fileName ?? '',
                                                  style: getUnderLine(
                                                      color: AppColors.primary),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  /*   cubit.pdfFiles[index].progress == 0
                                              ? cubit2.downloadPdf(cubit.pdfFiles[index])
                                              : null;*/
                                                },
                                                icon: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    CircularProgressIndicator(
                                                      color: item?.progress ==
                                                              100
                                                          ? AppColors.greenLight
                                                          : AppColors.primary,
                                                      strokeWidth: 2,
                                                      value: (item?.progress ??
                                                              0) /
                                                          100,
                                                    ),
                                                    item?.progress == 100
                                                        ? Icon(
                                                            CupertinoIcons
                                                                .checkmark_alt,
                                                            color: AppColors
                                                                .greenLight,
                                                          )
                                                        : Icon(
                                                            CupertinoIcons
                                                                .arrow_down,
                                                            color: AppColors
                                                                .primary,
                                                          ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
