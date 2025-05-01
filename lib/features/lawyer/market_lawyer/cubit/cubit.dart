import 'package:ataaby/core/exports.dart';

import 'package:ataaby/features/lawyer/market_lawyer/cubit/state.dart';
import 'package:ataaby/features/lawyer/market_lawyer/data/repo/market_repo.dart';

import '../data/model/all_products_model.dart';

class MarketLawyerCubit extends Cubit<MarketLawyerState> {
  MarketLawyerCubit(this.api) : super(MarketLawyerStateInitial());
  MarketLawyerRepo api;
  TextEditingController searchController = TextEditingController();

  MarketProductCategory? mainCategoryModel;
  onTapToChangeCategory(MarketProductCategory? cat) {
    mainCategoryModel = cat;

    emit(OnChangeCategoryState());
  }

  MainHomeMarketModel? mainHomeMarketModel;

  Future<void> getHomeMarket({bool isCategory = false}) async {
    emit(LoadingGetHomeMarketState());
    final res = await api.getHomeMarket(
        search: searchController.text,
        category: mainCategoryModel?.id?.toString() ?? '');

    res.fold((l) {
      //!
      emit(ErrorGetHomeMarketState());
    }, (r) {
      if (isCategory) {
        mainHomeMarketModel?.data?.marketProduct = r.data?.marketProduct;
      }
      mainHomeMarketModel = r;
      emit(LoadedGetHomeMarketState());

      //!
    });
  }
}
