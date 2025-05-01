import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/electronic_wallet/cubit/electronic_wallet_state.dart';
import 'package:ataaby/features/electronic_wallet/data/models/get_wallet_transaction_model.dart';
import 'package:ataaby/features/electronic_wallet/data/repos/electronic_wallet_repo.dart';
import 'package:ataaby/features/new_register/data/model/default_model.dart';

import '../data/models/charge_my_wallet.dart';
import '../screens/payment.dart';

class ElectronicWalletCubit extends Cubit<ElectronicWalletState> {
  ElectronicWalletCubit(this.electronicWalletRepo)
      : super(ElectronicWalletInitial());
  ElectronicWalletRepo electronicWalletRepo;
  GetWalletTransactionModel? getWalletTransactionModel;
  TextEditingController amountController = TextEditingController();
  TextEditingController paymentKeyController = TextEditingController();
  TextEditingController paymentMethodController = TextEditingController();
  TextEditingController priceOfChargeController = TextEditingController();

  Future<void> getWalletTransactionData() async {
    emit(LoadingGetWalletTransactionDataState());
    final res = await electronicWalletRepo.getWalletTransaction();

    res.fold((l) {
      emit(ErrorGetWalletTransactionDataState());
    }, (r) {
      getWalletTransactionModel = r;

      emit(LoadedGetWalletTransactionDataState());
    });
  }

  Future<void> getClientWalletTransaction() async {
    emit(LoadingGetWalletTransactionDataState());
    final res = await electronicWalletRepo.getClientWalletTransaction();

    res.fold((l) {
      emit(ErrorGetWalletTransactionDataState());
    }, (r) {
      getWalletTransactionModel = r;

      emit(LoadedGetWalletTransactionDataState());
    });
  }

  DefaultMainModel? defaultMainModel;
  Future<void> pullMoneyLawyer() async {
    emit(LoadingGetWalletTransactionDataState());
    final res = await electronicWalletRepo.pullMoneyLawyer(
      amount: amountController.text,
      paymentKey: paymentKeyController.text,
      paymentMethod: paymentMethodController.text,
    );

    res.fold((l) {
      emit(ErrorGetWalletTransactionDataState());
    }, (r) {
      defaultMainModel = r;
      successGetBar(r.msg ?? "");
      amountController.clear();
      paymentKeyController.clear();
      paymentMethodController.clear();
      emit(LoadedGetWalletTransactionDataState());
    });
  }

  Future<void> pullMoneyClient() async {
    emit(LoadingGetWalletTransactionDataState());
    final res = await electronicWalletRepo.pullMoneyClient(
      amount: amountController.text,
      paymentKey: paymentKeyController.text,
      paymentMethod: paymentMethodController.text,
    );

    res.fold((l) {
      emit(ErrorGetWalletTransactionDataState());
    }, (r) {
      defaultMainModel = r;
      successGetBar(r.msg ?? "");
      amountController.clear();
      paymentKeyController.clear();
      paymentMethodController.clear();
      emit(LoadedGetWalletTransactionDataState());
    });
  }

  ChargeMyWalletModel? chargeMyWalletModel;
  Future<void> chargeMyWallet(BuildContext context) async {
    emit(LoadingGetWalletTransactionDataState());
    final res = await electronicWalletRepo.chargeMyWallet(
        amount: priceOfChargeController.text);
    res.fold((l) {
      emit(ErrorGetWalletTransactionDataState());
    }, (r) {
      chargeMyWalletModel = r;
      priceOfChargeController.clear();
      if (r.success == true) {
        //!Nav To Webview
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PaymentWebViewScreen(url: r.paymentUrl);
        }));
      } else {
        errorGetBar(r.paymentUrl ?? "");
      }

      emit(LoadedGetWalletTransactionDataState());
    });
  }

  Future<void> paymentCallBack(BuildContext context) async {
    emit(LoadingGetWalletTransactionDataState());
    final res = await electronicWalletRepo.paymentCallBack(
        orderId: chargeMyWalletModel?.orderId.toString() ?? "");

    res.fold((l) {
      emit(ErrorGetWalletTransactionDataState());
    }, (r) {
      if (r.success == true) {
        Navigator.pop(context);
        successGetBar('تمت عملية الشحن بنجاح');
      } else {
        successGetBar('فشلت عملية الشحن يرجى المحاولة لاحقاً');
      }

      Preferences.instance.getUserModel().then((value) {
        if (value.data != null) {
          getClientWalletTransaction();
        } else {
          getWalletTransactionData();
        }
      });
      emit(LoadedGetWalletTransactionDataState());
    });
  }
}
