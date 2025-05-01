import 'package:ataaby/features/lawyer/order_this_product/data/models/orders_model.dart';

import '../../../../../core/exports.dart';
import '../../../../new_register/data/model/default_model.dart';

class OrderThisProductRepo {
  BaseApiConsumer dio;
  OrderThisProductRepo(this.dio);

  ///!orderProduct
  ///
  ///
  Future<Either<Failure, DefaultMainModel>> orderProduct({
    String? marketProductId,
    String? qty,
    String? phone,
    String? address,
  }) async {
    try {
      final response = await dio.post(EndPoints.addOrderUrl,
          body: {
            "market_product_id": marketProductId,
            "qty": qty,
            "phone": phone,
            "address": address,
          },
          formDataIsEnabled: true);

      return Right(DefaultMainModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // orders
  Future<Either<Failure, OrdersModel>> getOrdersData() async {
    try {
      final response = await dio.get(EndPoints.getOrdersUrl);

      return Right(OrdersModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
