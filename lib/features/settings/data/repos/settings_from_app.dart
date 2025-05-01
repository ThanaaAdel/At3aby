import 'package:ataaby/features/settings/data/models/settings_from_app_model.dart';

import '../../../../core/api/base_api_consumer.dart';
import '../../../../core/exports.dart';

class GetSettingsFromAppRepo {
  BaseApiConsumer api;
  GetSettingsFromAppRepo(this.api);
  Future<Either<Failure, GetSettingsFromAppModel>> getSettingsFromApp() async {
    try {
      final response = await api.get(EndPoints.getSettingDataFromApp);

      return Right(GetSettingsFromAppModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
