import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/market_lawyer/cubit/cubit.dart';

class MainCategoryWidget extends StatefulWidget {
  const MainCategoryWidget({super.key, required this.cubit});
  final MarketLawyerCubit cubit;
  @override
  _MainCategoryWidgetState createState() => _MainCategoryWidgetState();
}

class _MainCategoryWidgetState extends State<MainCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget
            .cubit.mainHomeMarketModel?.data?.marketProductCategory?.length,
        itemBuilder: (context, index) {
          var item = widget
              .cubit.mainHomeMarketModel?.data?.marketProductCategory?[index];
          return GestureDetector(
            onTap: () {
              widget.cubit.onTapToChangeCategory(item);

              widget.cubit.getHomeMarket(isCategory: true);
            },
            child: Container(
              padding: EdgeInsets.all(
                8.sp * textScaleFactor(context),
              ),
              margin: EdgeInsets.all(
                8.sp * textScaleFactor(context),
              ),
              decoration: BoxDecoration(
                color: item?.id == widget.cubit.mainCategoryModel?.id
                    ? AppColors.primary
                    : AppColors.grayLite,
                borderRadius: BorderRadius.circular(
                  8.sp * textScaleFactor(context),
                ),
              ),
              child: Center(
                child: Text(
                  item?.title ?? '',
                  style: getRegularStyle(
                      fontSize: 14.sp * textScaleFactor(context),
                      color: item?.id == widget.cubit.mainCategoryModel?.id
                          ? AppColors.white
                          : AppColors.gray),
                ),
              ),
            ),
          );
        });
  }
}
