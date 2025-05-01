
import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/change_password/cubit/change_password_state.dart';
import 'package:ataaby/features/change_password/data/repos/change_password_repo.dart';
import 'package:ataaby/features/new_register/data/model/default_model.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.changePasswordRepo) : super(ChangePasswordInitial());
  ChangePasswordRepo changePasswordRepo;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  DefaultMainModel? defaultMainModel;
  changePasswordFromLawyer(BuildContext context) async {
    emit(LoadingChangePasswordFromLawyerData());
    final res = await changePasswordRepo.changePasswordFromLawyer(
      newPassword: newPasswordController.text,
      newPasswordConfirmation:confirmPasswordController.text ,
      oldPassword: oldPasswordController.text,
    );
    res.fold((l) {
      emit(ErrorChangePasswordFromLawyerData());
    }, (r) {
      defaultMainModel = r;
      if(r.status == 200){
        successGetBar(r.msg ?? "");
        newPasswordController.clear();
        oldPasswordController.clear();
        confirmPasswordController.clear();
      }
      else{
        errorGetBar(r.msg ?? "");
      }

      emit(LoadedChangePasswordFromLawyerData());
    });
  }
}
