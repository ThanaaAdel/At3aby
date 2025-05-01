import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/new_register/data/model/default_model.dart';


class ChangePasswordRepo {
  BaseApiConsumer api;
  ChangePasswordRepo(this.api);
  Future<Either<Failure, DefaultMainModel>> changePasswordFromLawyer({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirmation,
}) async {
    try {
      final response =
      await api.post(EndPoints.changePasswordFromLawyer,
      body: {
        'old_password':oldPassword,
        'new_password':newPassword,
        'new_password_confirmation':newPasswordConfirmation,
      }
      );

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
