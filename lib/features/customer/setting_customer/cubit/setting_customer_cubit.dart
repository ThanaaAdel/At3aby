
import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/setting_customer/cubit/setting_customer_state.dart';
import '../data/repos/setting_customer_repo.dart';

class SettingCustomerCubit extends Cubit<SettingCustomerState> {
  SettingCustomerCubit(this.settingCustomerRepo) : super(SettingCustomerInitial());
  SettingCustomerRepo settingCustomerRepo;
}
