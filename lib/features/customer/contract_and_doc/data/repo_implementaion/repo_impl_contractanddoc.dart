import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/contract_and_doc/data/model/contracts_model.dart';


class ContractAndDocumentRepo {
  BaseApiConsumer dio;
  ContractAndDocumentRepo(this.dio);
  Future<Either<Failure, GetContractsModel>> getContactsData(String search) async {
    try {
      final response =
      await dio.get(EndPoints.getContractsUrlFromLawyer,queryParameters: {"q":search});
      return Right(GetContractsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
