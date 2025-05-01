import 'dart:developer';
import 'dart:io';

import 'package:ataaby/core/api/end_points.dart';
import 'package:ataaby/core/preferences/preferences.dart';
import 'package:ataaby/core/utils/get_mac_address.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api/base_api_consumer.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../models/login_model.dart';
import '../models/login_model_lawyer.dart';

//! we use dartx to make right and left
class LoginRepo {
  BaseApiConsumer dio;
  LoginRepo(this.dio);

  Future<Either<Failure, LoginModel>> loginAsCustomer({
    required String email,
    required String password,
  }) async {
    final macAddress = await getMacAddress() ?? 'macAddress';
    final deviceToken = await Preferences.instance.getDeviceToken();
    log('====>> $macAddress');
    log('====>> device Token :$deviceToken');
    try {
      final response = await dio.post(EndPoints.loginClientUrl, body: {
        'email': email,
        'password': password,
        'device_type': Platform.isAndroid ? 'android' : 'ios',
        'device_token': deviceToken,
        "mac_address": macAddress,
      });//elsapagh123@gmail.com

      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModelLawyer>> loginAsLawyer({
    required String email,
    required String password,
  }) async {
    final macAddress = await getMacAddress() ?? '';
    final deviceToken = await Preferences.instance.getDeviceToken();
    log('====>> $macAddress');
    log('====>> device Token :$deviceToken');
    try {
      final response = await dio.post(EndPoints.loginLawyerUrl, body: {
        'email': email,
        'password': password,
        'device_type': Platform.isAndroid ? 'android' : 'ios',
        'device_token': deviceToken,
        "mac_address": macAddress,
      });

      return Right(LoginModelLawyer.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
