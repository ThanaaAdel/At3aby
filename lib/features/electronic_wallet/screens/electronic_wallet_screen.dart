import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/appbar_with_image.dart';
import 'package:ataaby/features/electronic_wallet/cubit/electronic_wallet_cubit.dart';
import 'package:ataaby/features/electronic_wallet/cubit/electronic_wallet_state.dart';
import 'package:easy_localization/easy_localization.dart';

class ElectronicWalletScreen extends StatefulWidget {
  const ElectronicWalletScreen({super.key, required this.isLawyer});
  final bool isLawyer;

  @override
  State<ElectronicWalletScreen> createState() => _ElectronicWalletScreenState();
}

class _ElectronicWalletScreenState extends State<ElectronicWalletScreen> {
  @override
  void initState() {
    if (widget.isLawyer) {
      context.read<ElectronicWalletCubit>().getWalletTransactionData();
    } else {
      context.read<ElectronicWalletCubit>().getClientWalletTransaction();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ElectronicWalletCubit>();
    return SafeArea(child: Scaffold(
      body: BlocBuilder<ElectronicWalletCubit, ElectronicWalletState>(
          builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppbarContainImage(
              isLawyer: widget.isLawyer,
              titleCenter: "electronic_wallet".tr(),
            ),
            SizedBox(height: 20.h),
            (state is LoadingGetWalletTransactionDataState)
                ? Center(
                    child: CustomLoadingIndicator(),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.secondPrimary,
                              borderRadius: BorderRadius.circular(12.sp)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0.w, vertical: 15.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "current_balance".tr(),
                                      style: getRegularStyle(
                                          fontSize:
                                              11.sp * textScaleFactor(context),
                                          color: AppColors.primary),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      '${cubit.getWalletTransactionModel?.data?.wallet ?? 0} ${"egp".tr()}',
                                      style: getRegularStyle(
                                          fontSize:
                                              20.sp * textScaleFactor(context),
                                          color: AppColors.primary),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              title:
                                                  Text("deposit_process".tr()),
                                              content: TextField(
                                                controller: cubit
                                                    .priceOfChargeController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      "enter_the_amount".tr(),
                                                  border:
                                                      const OutlineInputBorder(),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    
                                                    cubit.chargeMyWallet(
                                                        context);
                                                  },
                                                  child: Text("deposit".tr()),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                              20.sp * textScaleFactor(context)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0.w, vertical: 5.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                ImageAssets.pushIcon,
                                                color: AppColors.white,
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                "deposit".tr(),
                                                style: getRegularStyle(
                                                  fontSize: 14.sp *
                                                      textScaleFactor(context),
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            String selectedMethod = 'wallet';
                                            List<String> methods = [
                                              'wallet',
                                              'ipa',
                                              'bank'
                                            ];

                                            return StatefulBuilder(
                                              builder: (context, setState) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  title:
                                                      Text("pull_process".tr()),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextField(
                                                          controller: cubit
                                                              .amountController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                "enter_the_amount"
                                                                    .tr(),
                                                            border:
                                                                const OutlineInputBorder(),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 15),
                                                        DropdownButtonFormField<
                                                            String>(
                                                          value: selectedMethod,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                "choose_the_method"
                                                                    .tr(),
                                                            border:
                                                                const OutlineInputBorder(),
                                                          ),
                                                          items: methods.map(
                                                              (String method) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: method,
                                                              child:
                                                                  Text(method),
                                                            );
                                                          }).toList(),
                                                          onChanged: (String?
                                                              newValue) {
                                                            if (newValue !=
                                                                null) {
                                                              setState(() {
                                                                selectedMethod =
                                                                    newValue;
                                                                cubit.paymentMethodController
                                                                        .text =
                                                                    newValue;
                                                              });
                                                            }
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            height: 15),
                                                        TextField(
                                                          controller: cubit
                                                              .paymentKeyController,
                                                          keyboardType: selectedMethod ==
                                                                      'wallet' ||
                                                                  selectedMethod ==
                                                                      'ipa'
                                                              ? TextInputType
                                                                  .phone
                                                              : TextInputType
                                                                  .text,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: selectedMethod ==
                                                                    'wallet'
                                                                ? 'enter_mobile_number'
                                                                    .tr()
                                                                : selectedMethod ==
                                                                        'ipa'
                                                                    ? 'enter_phone_or_account_number'
                                                                        .tr()
                                                                    : 'enter_iban'
                                                                        .tr(),
                                                            border:
                                                                const OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        widget.isLawyer
                                                            ? cubit
                                                                .pullMoneyLawyer()
                                                            : cubit
                                                                .pullMoneyClient();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("pull".tr()),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                              20.sp * textScaleFactor(context)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0.w, vertical: 5.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                ImageAssets.pillIcon,
                                                color: AppColors.white,
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                "pull".tr(),
                                                style: getRegularStyle(
                                                  fontSize: 14.sp *
                                                      textScaleFactor(context),
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "process".tr(),
                          style: getRegularStyle(
                              fontSize: 16.sp, color: AppColors.blackLight),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        (cubit.getWalletTransactionModel?.data
                                    ?.walletTransactions?.length ==
                                0)
                            ? Center(child: Text("no_process".tr()))
                            : ListView.builder(
                                itemBuilder: (context, index) => Container(
                                    padding: EdgeInsets.all(
                                      10.sp * textScaleFactor(context),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          8.sp * textScaleFactor(context),
                                        ),
                                        boxShadow: customShadow),
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.redLight,
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                8.sp * textScaleFactor(context),
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.arrow_upward_outlined,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: getWidthSize(context) /
                                                      1.6,
                                                  child: Text(
                                                    cubit
                                                            .getWalletTransactionModel
                                                            ?.data
                                                            ?.walletTransactions?[
                                                                index]
                                                            .comment ??
                                                        "",
                                                    maxLines: 2,
                                                    style: getRegularStyle(
                                                      color:
                                                          AppColors.blackLight,
                                                      fontSize: 14.sp *
                                                          textScaleFactor(
                                                              context),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${cubit.getWalletTransactionModel?.data?.walletTransactions?[index].debit ?? ""} ${"egp".tr()}",
                                                  style: getRegularStyle(
                                                    color: AppColors.green,
                                                    fontSize: 14.sp *
                                                        textScaleFactor(
                                                            context),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 100.w,
                                                ),
                                                Text(
                                                  cubit
                                                          .getWalletTransactionModel
                                                          ?.data
                                                          ?.walletTransactions?[
                                                              index]
                                                          .createdAt
                                                          .toString()
                                                          .substring(0, 10) ??
                                                      "",
                                                  style: getRegularStyle(
                                                    color: AppColors.gray,
                                                    fontSize: 14.sp *
                                                        textScaleFactor(
                                                            context),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                                itemCount: cubit.getWalletTransactionModel?.data
                                        ?.walletTransactions?.length ??
                                    0,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                              ),
                      ],
                    ),
                  ),
          ],
        );
      }),
    ));
  }
}
