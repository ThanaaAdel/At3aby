import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/add_new_update/cubit/add_new_update_state.dart';
import 'package:ataaby/features/lawyer/add_new_update/data/repo/add_new_update_repo.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';

import '../../details_issue/cubit/details_issue_cubit.dart';

class AddNewUpdateCubit extends Cubit<AddNewUpdateState> {
  AddNewUpdateCubit(this.api) : super(AddNewUpdateInitial());
  TextEditingController updateDetailsController = TextEditingController();
  TextEditingController initialRulingController = TextEditingController();
  AddNewUpdateRepo api;
  DateTime selectedDate = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
  final List<File> uploadedImage = [];
  final List<String> uploadedImageStrings = [];

  Future<void> onSelectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(9999),
    );

    if (picked != null) {
      selectedDate = picked;
      updateFormattedDate();
      emit(AdvanceDateSelectedState());
    }
  }

  void updateFormattedDate() {
    formattedDate = DateFormat('yyyy-MM-dd', 'en').format(selectedDate);
  }

  void removeImage(File file) {
    uploadedImage.remove(file);
    uploadedImageStrings.remove(file.path);
    emit(FileRemovedSuccessfully());
  }

  Future<void> pickImage(BuildContext context, bool isGallery) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: isGallery ? ImageSource.gallery : ImageSource.camera,
    );

    if (pickedFile != null) {
      if (!uploadedImageStrings.contains(pickedFile.path)) {
        uploadedImage.add(File(pickedFile.path));
        uploadedImageStrings.add(pickedFile.path);
        emit(FilePickedSuccessfully());
      } else {
        emit(FileAlreadyExists()); // Emit state for duplicate file
      }
    } else {
      emit(FileNotPicked());
    }
  }

  Future<void> pickImages(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage(
      maxHeight: 500,
      maxWidth: 500,
      imageQuality: 100,
    );

    if (pickedFiles.isNotEmpty) {
      for (final file in pickedFiles) {
        if (!uploadedImageStrings.contains(file.path)) {
          uploadedImage.add(File(file.path));
          uploadedImageStrings.add(file.path);
        }
      }
      emit(FilePickedSuccessfully());
    } else {
      emit(FileNotPicked());
    }
  }

  void clearUploadedImages() {
    uploadedImage.clear();
    uploadedImageStrings.clear();
    emit(AllFilesCleared());
  }

  Future<void> addNewUpdateLawyer(
    BuildContext context, {
    required String courtCaseId,
  }) async {
    emit(LoadingAddNewUpdatesForCouse());
    final res = await api.addNewUpdateLawyer(
      courtCaseId: courtCaseId,
      date: DateFormat('yyyy-MM-dd', 'en').format(selectedDate),
      details: updateDetailsController.text,
      title: initialRulingController.text,
      images: uploadedImage,
    );

    res.fold((l) {
      emit(ErrorAddNewUpdatesForCouse());

      //!
    }, (r) {
//!
      AwesomeDialog(
        context: context,
        showCloseIcon: false,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        padding: EdgeInsets.all(10.w),
        title: "send_update_success".tr(),
        btnOkOnPress: () {
          Navigator.pop(context);
        },
        btnOkText: "start_now".tr(),
      ).show();
      context.read<DetailsIssueCubit>().getCourtById(context, id: courtCaseId);
      clearUploadedImages();
      initialRulingController.clear();
      updateDetailsController.clear();
      emit(LoadedAddNewUpdatesForCouse());
    });
    //!
  }


}
