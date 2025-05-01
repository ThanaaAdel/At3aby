

class ChargeMyWalletModel {
    bool? success;
    String? paymentUrl;
    int? orderId;

    ChargeMyWalletModel({
        this.success,
        this.paymentUrl,
        this.orderId,
    });

    factory ChargeMyWalletModel.fromJson(Map<String, dynamic> json) => ChargeMyWalletModel(
        success: json["success"],
        paymentUrl: json["payment_url"],
        orderId: json["order_id"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "payment_url": paymentUrl,
        "order_id": orderId,
    };
}
