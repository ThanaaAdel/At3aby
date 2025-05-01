import 'package:ataaby/features/electronic_wallet/data/models/get_wallet_transaction_model.dart';
import 'package:ataaby/features/new_register/data/model/default_model.dart';

import '../../../../core/exports.dart';
import '../models/charge_my_wallet.dart';
import '../models/paymentCallBack.dart';

class ElectronicWalletRepo {
  BaseApiConsumer dio;
  ElectronicWalletRepo(this.dio);

  Future<Either<Failure, GetWalletTransactionModel>>
      getWalletTransaction() async {
    try {
      final response = await dio.get(EndPoints.getWalletTransaction);

      return Right(GetWalletTransactionModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetWalletTransactionModel>>
      getClientWalletTransaction() async {
    try {
      final response = await dio.get(EndPoints.getClientWalletTransaction);

      return Right(GetWalletTransactionModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> pullMoneyLawyer({
    required String paymentMethod,
    required String amount,
    required String paymentKey,
  }) async {
    try {
      final response =
          await dio.post(EndPoints.withdrawRequestLawyerUrl, body: {
        "payment_method": paymentMethod,
        "amount": amount,
        "payment_key": paymentKey,
      });

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultMainModel>> pullMoneyClient({
    required String paymentMethod,
    required String amount,
    required String paymentKey,
  }) async {
    try {
      final response =
          await dio.post(EndPoints.withdrawRequestClientUrl, body: {
        "payment_method": paymentMethod,
        "amount": amount,
        "payment_key": paymentKey,
      });

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //! Charge Yur Wallet
  Future<Either<Failure, ChargeMyWalletModel>> chargeMyWallet({
    required String amount,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.paymobPayUrl + amount,
      );

      return Right(ChargeMyWalletModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  //! Charge Yur Wallet
  Future<Either<Failure, PaymentCallBackModel>> paymentCallBack(
      {required String orderId}) async {
    try {
      final response = await dio.get(
        EndPoints.paymentCallBackUrl + orderId,
      );

      return Right(PaymentCallBackModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
