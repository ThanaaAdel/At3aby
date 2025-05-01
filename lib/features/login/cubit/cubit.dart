import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/new_register/cubit/cubit.dart';
import '../data/repo/login.dart';
import '../screens/login.dart';
import 'state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginStateInitial());
  LoginRepo api;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginAsCustomer(
      BuildContext context, ChooseTypeRegisterArgs args) async {
    emit(LoadingLoginState());
    final res = await api.loginAsCustomer(
      email: emailController.text,
      password: passwordController.text,
    );
    res.fold((l) {
      emit(ErrorLoginState());
    }, (r) async {
      if (r.status == 200) {
        await Preferences.instance.setUser(r);
        Navigator.pushReplacementNamed(context, Routes.mainCustomerRoute,
            arguments: args);
        emailController.clear();
        passwordController.clear();
        context.read<NewRegisterCubit>().verifyController.clear();
        context.read<NewRegisterCubit>().fullNameController.clear();
        context.read<NewRegisterCubit>().emailController.clear();
        context.read<NewRegisterCubit>().passwordController.clear();
        context.read<NewRegisterCubit>().confirmPasswordController.clear();

        context.read<NewRegisterCubit>().nationalityNumberController.clear();
        context.read<NewRegisterCubit>().phoneNumberController.clear();
        context.read<NewRegisterCubit>().lawyerIdController.clear();
        context.read<NewRegisterCubit>().selectedSpecialityList.clear();
        context.read<NewRegisterCubit>().selectedCityController = null;
        emit(LoadedLoginState());
      } else {
        errorGetBar(r.msg ?? '');
        emit(ErrorLoginState());
      }
    });
  }

  Future<void> loginAsLawyer(
      BuildContext context, ChooseTypeRegisterArgs args) async {
    emit(LoadingLoginState());
    final res = await api.loginAsLawyer(
      email: emailController.text,
      password: passwordController.text,
    );
    res.fold((l) {
      emit(ErrorLoginState());
    }, (r) async {
      if (r.status == 200) {
        await Preferences.instance.setLawyer(r);
        Navigator.pushReplacementNamed(context, Routes.mainLawyerRoute,
            arguments: args);
        emit(LoadedLoginState());
      } else {
        errorGetBar(r.msg ?? '');
        emit(ErrorLoginState());
      }
    });
  }

  Future<void> mainLogin(
      BuildContext context, ChooseTypeRegisterArgs args) async {
    if (args.indexPageClientOrLawyer == 0) {
      loginAsCustomer(context, args);
    } else {
      loginAsLawyer(context, args);
    }
  }
}
