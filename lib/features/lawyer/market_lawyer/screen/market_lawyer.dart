import 'package:ataaby/core/exports.dart';
import 'package:ataaby/core/utils/custom_loading.dart';
import 'package:ataaby/core/widgets/search_text_field.dart';
import 'package:ataaby/features/lawyer/home_lawyer/screen/widgets/appbar_home_lawyer.dart';
import 'package:ataaby/features/lawyer/market_lawyer/cubit/cubit.dart';
import 'package:ataaby/features/lawyer/market_lawyer/cubit/state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/widgets/network_image.dart';
import 'widgets/custom_main_category.dart';
import 'widgets/offer_market.dart';

class MarketLawyerScreen extends StatefulWidget {
  const MarketLawyerScreen({super.key});

  @override
  State<MarketLawyerScreen> createState() => _MarketLawyerScreenState();
}

class _MarketLawyerScreenState extends State<MarketLawyerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MarketLawyerCubit>().getHomeMarket();
  }

  @override
  void dispose() {
    EasyDebounce.cancel('MarketLawyerdebouncer');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MarketLawyerCubit>();
    return Scaffold(
      body: BlocBuilder<MarketLawyerCubit, MarketLawyerState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarHomeLawyer(
                bottom: 30.h,
                heightContainer: 50.h,
                textCenter: Text(
                  "super_market_bliss".tr(),
                  style: getBoldStyle(color: AppColors.white),
                ),
                widget: SearchTextField(
                  controller: cubit.searchController,
                  hintText: "search_from_market".tr(),
                  prefixIcon: _buildSearchPrefixIcon(),
                  suffixIcon: _buildSearchSuffixIcon(context, cubit),
                  onChanged: (value) async {
                    //!
                    EasyDebounce.debounce(
                        'MarketLawyerdebouncer',
                        const Duration(seconds: 1),
                        () async =>
                            //!cubit.searchController
                            await cubit.getHomeMarket(isCategory: true));

                    // setState(() {});
                  },
                ),
              ),
              Flexible(
                child: (state is LoadingGetHomeMarketState &&
                        cubit.mainHomeMarketModel?.data == null)
                    ? Center(
                        child: CustomLoadingIndicator(),
                      )
                    : ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0.w, vertical: 10.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("new_offers".tr(),
                                    style: getRegularStyle(fontSize: 16.sp)),
                                SizedBox(height: 10.h),
                                SizedBox(
                                    height: 160.h,
                                    child: CustomMainMarketOfferWidget(
                                        cubit: cubit)),
                                SizedBox(height: 10.h),
                                Text("categories".tr(),
                                    style: getRegularStyle(fontSize: 16.sp)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60.h,
                            child: MainCategoryWidget(cubit: cubit),
                          ),
                          GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8.0),
                              itemCount: cubit.mainHomeMarketModel?.data
                                  ?.marketProduct?.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.84,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                              ),
                              itemBuilder: (context, index) {
                                var item = cubit.mainHomeMarketModel?.data
                                    ?.marketProduct?[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.detailsProductRoute,
                                        arguments: item);
                                  },
                                  child: Card(
                                      color: AppColors.white,
                                      margin: EdgeInsets.all(
                                        8.sp * textScaleFactor(context),
                                      ),
                                      elevation: 4.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                              fit: FlexFit.tight,
                                              child: CustomNetworkImage(
                                                image: item?.image ?? '',
                                                width: double.infinity,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                  item?.title ?? '',
                                                  style: getRegularStyle(
                                                      fontSize: 14),
                                                ),
                                                AutoSizeText(
                                                  '${item?.price.toString() ?? ''} ${AppStrings.currency}',
                                                  style: getRegularStyle(
                                                      fontSize: 14,
                                                      color:
                                                          AppColors.greenLight),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                );
                              }),
                        ],
                      ),
              )
            ],
          );
        },
      ),
    );
  }
}

Widget _buildSearchSuffixIcon(BuildContext context, MarketLawyerCubit cubit) {
  return cubit.searchController.text.isEmpty
      ? const SizedBox()
      : InkWell(
          onTap: () {
            cubit.searchController.clear();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.close, color: AppColors.red),
            ),
          ),
        );
}

Widget _buildSearchPrefixIcon() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SvgPicture.asset(ImageAssets.searchIcon),
  );
}
