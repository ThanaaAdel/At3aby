import 'package:ataaby/core/api/base_api_consumer.dart';
import 'package:ataaby/core/api/end_points.dart';
import 'package:ataaby/core/error/failures.dart';
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/data/models/send_sos_request.dart';
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/data/models/sos_lawyers_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/error/exceptions.dart';

class SosLawyersRepo {
  BaseApiConsumer api;
  SosLawyersRepo(this.api);
  Future<Either<Failure, SendSosRequestModel>> addSosRequest(
      {required String problem,
      required String phone,
      required String address,
      required String lat,
      required String long,
      required String lawyerId,
      String? voice}) async {
    try {
      final response = await api.post(
        EndPoints.addSosRequestUrl,
        body: {
          'problem': problem,
          'phone': phone,
          'address': address,
          'lat': lat,
          'long': long,
          'lawyer_id': lawyerId,
          if (voice != null)
            'voice': await MultipartFile.fromFile(
              voice,
              filename:
                  voice.split('/').last, // Optional: Specify a custom filename
            ),
        },
        formDataIsEnabled: true,
      );

      return Right(SendSosRequestModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SosLawyerRequestModel>> sosLawyerData({
    required String lat,
    required String long,
  }) async {
    try {
      final response = await api.get(EndPoints.sosLawyersUrl, queryParameters: {
        'lat': lat,
        'lng': long,
      });

      return Right(SosLawyerRequestModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
