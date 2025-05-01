import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/features/customer/offers_customer/cubit/offers_customer_cubit.dart';
import 'package:ataaby/features/customer/offers_customer/cubit/offers_customer_state.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/widgets/appbar_with_image.dart';

class OffersCustomerScreen extends StatefulWidget {
  const OffersCustomerScreen({super.key});

  @override
  State<OffersCustomerScreen> createState() => _OffersCustomerScreenState();
}

class _OffersCustomerScreenState extends State<OffersCustomerScreen> {
  @override
  void initState() {
    context.read<OffersCustomerCubit>().getOffersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AppbarContainImage(
          isLawyer: false,
          titleCenter: "offers".tr(),
        ),
        BlocBuilder<OffersCustomerCubit, OffersCustomerState>(
            builder: (context, state) {
          var cubit = context.read<OffersCustomerCubit>();

          return (state is LoadingGetOffers)
              ? Center(
                  child: CustomLoadingIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,

                    itemCount:
                        cubit.offersModel?.data?.lawyerOffers?.length ?? 0,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        //!
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10.w, right: 5.w, top: 10.h, bottom: 10.h),
                        child: Image.network(
                          cubit.offersModel?.data?.lawyerOffers?[index].image
                                  .toString() ??
                              '',
                          // height: 140.h,
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                        ),

                      ),
                    ),
                  ),
                );
        }),
      ],
    ));
  }
}
