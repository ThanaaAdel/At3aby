import 'package:dio/dio.dart';
import '../../../../../core/exports.dart';
import '../model/add_update_model.dart';

class AddNewUpdateRepo {
  BaseApiConsumer dio;
  AddNewUpdateRepo(this.dio);

  Future<Either<Failure, LawyerAddNewUpdateModel>> addNewUpdateLawyer({
    String? courtCaseId,
    String? title,
    String? details,
    String? date,
    List<File>? images,
  }) async {
    try {
      final response = await dio.post(EndPoints.addNewUpdateLawyerUrl,
          formDataIsEnabled: true,
          body: {
            'court_case_id': courtCaseId,
            "details": details,
            'date': date,
            'title': title,
            for (int i = 0; i < images!.length; i++)
              "files[$i]": MultipartFile.fromFileSync(images[i].path,
                  filename: images[i].path.split('/').last)
          });
      return Right(LawyerAddNewUpdateModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
