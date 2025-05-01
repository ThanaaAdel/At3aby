
import 'package:ataaby/core/exports.dart';
import '../data/models/points_model.dart';
import '../data/repos/points_repo.dart';
import 'points_state.dart';

class PointsCubit extends Cubit<PointsState> {
  PointsCubit(this.pointsRepo) : super(PointsInitial());
  PointsRepo pointsRepo ;
  PointsModel? pointsModel;
  getPointsClientData() async {
    emit(LoadingPointsClientData());
    final res = await pointsRepo.getPointsClientData();
    res.fold((l) {
      emit(ErrorPointsClientData());
    }, (r) {
      pointsModel = r;
      emit(LoadedPointsClientData());
    });
  }

}
