import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/inheritance_and_zakat_cal/cubit/inheritance_and_zakat_calculator_customer_state.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import '../data/model/model_zakat.dart';
import '../data/model/zakat_type.dart';
import '../data/repos/inheritance_and_zakat_calculator_customer_repo.dart';

class InheritanceAndZakatCalculatorCubit
    extends Cubit<InheritanceAndZakatCalculatorState> {
  InheritanceAndZakatCalculatorCubit(this.settingCustomerRepo)
      : super(InheritanceAndZakatCalculatorInitial()) {
    currentZakatType = zakatTypeModel.first;
  }
  InheritanceAndZakatCalculatorRepo settingCustomerRepo;

  List<ZakatAndInhertModel> myListItems = [
    ZakatAndInhertModel(title: 'cal_zakat'.tr(), id: 1),
    // ZakatAndInhertModel(title: 'cal_inherit'.tr(), id: 2),
  ];

  ZakatTypeModel? currentZakatType;

  List<ZakatTypeModel> zakatTypeModel = [
    ZakatTypeModel(id: 1, title: 'zakat_money'.tr(), status: false),
    // ZakatTypeModel(id: 2, title: 'zakat_zoroa'.tr(), status: false),
  ];
  onItemSelected(ZakatTypeModel? item) {
    currentZakatType = item;
    item!.id == 2 ? currentZakatElzaraType = zakatTypeElzaraModel.first : null;
    clearData();
    emit(OnChangeZakatCalculatorInitial());
  }

  TextEditingController totalWealth = TextEditingController();
  double zakat = 0.0;
//! zakat money
  void calculateZakat() {
    emit(LoadingOnCalculateZakatCalculatorInitial());
    zakat = (double.parse(totalWealth.text) / 100) * 2.5;
    emit(OnCalculateZakatCalculatorInitial());
  }

//! zakat elzar3
  TextEditingController totalCrop = TextEditingController();
  TextEditingController wasteCrop = TextEditingController();

//! Zakat elzara
  ZakatTypeModel? currentZakatElzaraType;

  List<ZakatTypeModel> zakatTypeElzaraModel = [
    ZakatTypeModel(id: 2, title: 'industrial'.tr(), status: false),
    ZakatTypeModel(id: 1, title: 'natural'.tr(), status: false),
  ];
  onItemSelectedZakatElzara(ZakatTypeModel? item, BuildContext context) {
    currentZakatElzaraType = item;
    calculateCropZakat(context);
    emit(OnChangeZakatCalculatorInitial());
  }

  double zakatElzaraa = 0;
  calculateCropZakat(BuildContext context) {
    const double nisab = 653.0; // النصاب الشرعي للزرع بالكيلوغرام

    // تحديد نسبة الزكاة
    //! 0.10 >> case from rain else 0.05
    double zakatRate = currentZakatElzaraType?.id == 1 ? 0.10 : 0.05;

    // حساب المحصول الصافي
    double netCrop =
        double.parse(totalCrop.text.isNotEmpty ? totalCrop.text : '0') -
            double.parse(wasteCrop.text.isNotEmpty ? wasteCrop.text : '0');
    if (double.parse(totalCrop.text.isNotEmpty ? totalCrop.text : '0') <
        double.parse(wasteCrop.text.isNotEmpty ? wasteCrop.text : '0')) {
      AwesomeDialog(
        context: context,
        showCloseIcon: false,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        padding: EdgeInsets.all(10.w),
        title: "waste_less_than_crop".tr(),
        // btnOkOnPress: () {},
        btnCancelOnPress: () {},
        btnCancelText: "cancel".tr(),
      ).show();
      zakatElzaraa = 0.0;
    } else if (netCrop < nisab) {
      zakatElzaraa = 0.0;
      AwesomeDialog(
        context: context,
        showCloseIcon: false,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        padding: EdgeInsets.all(10.w),
        title: "no_zakat_msg".tr(),
        // btnOkOnPress: () {},
        btnCancelOnPress: () {},
        btnCancelText: "cancel".tr(),
      ).show();
    } else {
      zakatElzaraa = netCrop * zakatRate;
    }
    // حساب الزكاة

    emit(OnCalculateZakatElZaraaCalculatorInitial());
  }

  clearData() {
    totalWealth.clear();
    totalCrop.clear();
    wasteCrop.clear();
    zakatElzaraa = 0.0;
    zakat = 0.0;
  }
}
