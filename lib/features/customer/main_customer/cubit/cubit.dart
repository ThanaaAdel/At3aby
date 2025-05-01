import 'package:ataaby/features/customer/main_customer/data/repo/main_customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';

class MainCustomerCubit extends Cubit<MainCustomerState> {
  MainCustomerCubit(this.api) : super(MainCustomerInitial());
  MainCustomerRepo api;
}
