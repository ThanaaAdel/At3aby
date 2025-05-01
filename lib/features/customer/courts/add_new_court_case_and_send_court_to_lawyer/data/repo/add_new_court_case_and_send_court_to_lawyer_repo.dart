import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/courts/add_new_court_case_and_send_court_to_lawyer/data/model/add_new_court_case_model.dart';
import 'package:ataaby/features/new_register/data/model/default_model.dart';
import 'package:ataaby/features/new_register/data/model/specialities_model.dart';
import 'package:dio/dio.dart';

class AddNewCourtCaseAndSendCourtToLawyerRepo {
  BaseApiConsumer api;
  AddNewCourtCaseAndSendCourtToLawyerRepo(this.api);

  Future<Either<Failure, AddNewCourtCaseModel>> addNewCourtCase({
    required String title,
    required String details,
    required String caseEstimatedPrice,
    required String caseNumber,
    required String specialityId,
    List<File>? images,
  }) async {
    try {
      final response = await api.post(
        EndPoints.addNewCourtCase,
        formDataIsEnabled: true,
        body: {
          'title': title,
          'details': details,
          'case_estimated_price': caseEstimatedPrice,
          'case_number': caseNumber,
          'speciality_id': specialityId,
          for (int i = 0; i < images!.length; i++)
            "files[$i]": MultipartFile.fromFileSync(images[i].path,
                filename: images[i].path.split('/').last)
        },
      );
      return Right(AddNewCourtCaseModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> sendCourtCaseFromLawyer({
    required String title,
    required String details,
    required String price,
    required String caseNumber,
    required String specialityId,
    required String lawyerId,
    required String type,
    List<File>? images,
  }) async {
    try {
      final response = await api.post(
        EndPoints.addPrivateCourtCase,
        formDataIsEnabled: true,
        body: {
          'title': title,
          'type': type,
          'details': details,
          'lawyer_id': lawyerId,
          'price': price,
          'case_number': caseNumber,
          'speciality_id': 2,
          for (int i = 0; i < images!.length; i++)
            "files[$i]": MultipartFile.fromFileSync(images[i].path,
                filename: images[i].path.split('/').last)
        },
      );
      return Right(DefaultMainModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainSpecialitiesModel>> getSpecialities(
      String id) async {
    try {
      final response = await api.get(EndPoints.specialitiesByIdUrl + id);
      return Right(MainSpecialitiesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MainSpecialitiesModel>> getFilterHomeLawyer() async {
    try {
      final response = await api.get(EndPoints.lawyertGetSpecialitieslUrl);
      return Right(MainSpecialitiesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
