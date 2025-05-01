import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/courts/add_new_court_case_and_send_court_to_lawyer/cubit/add_new_court_case_and_send_court_to_lawyer_state.dart';
import 'package:ataaby/features/customer/courts/add_new_court_case_and_send_court_to_lawyer/screens/widgets/type_court.dart';
import 'package:ataaby/features/customer/courts/the_courts/cubit/cubit.dart';
import 'package:ataaby/features/lawyer/home_lawyer/data/model/specialist_model.dart';
import 'package:ataaby/features/new_register/data/model/specialities_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import '../data/repo/add_new_court_case_and_send_court_to_lawyer_repo.dart';

class AddNewCourtCaseAndSendCourtToLawyerCubit
    extends Cubit<AddNewCourtCaseAndSendCourtToLawyerState> {
  AddNewCourtCaseAndSendCourtToLawyerCubit(
      this.addNewCourtCaseAndSendCourtToLawyerRepo)
      : super(AddNewCourtCaseAndSendCourtToLawyerInitial());

  final AddNewCourtCaseAndSendCourtToLawyerRepo
      addNewCourtCaseAndSendCourtToLawyerRepo;

  TextEditingController courtTitleController = TextEditingController();
  TextEditingController courtNumberController = TextEditingController();
  TextEditingController courtPriceController = TextEditingController();
  TextEditingController courtDescriptionController = TextEditingController();
  bool isExpandedSpecialization = false;
  String? selectedCityController;
  TypeCourt? typeSelectedValue;
  final List<File> uploadedImages = [];
  Speciality? selectedSpecialization; // !you will

  onSelectItem(Speciality item) {
    selectedSpecialization = item;
    emit(OnChangeFilterItemState());
  }

  MainSpecialitiesModel? mainSpecialitiesModel;
  getFilterSpecialist() async {
    emit(LoadingGetFilterSpecialist());
    final res =
        await addNewCourtCaseAndSendCourtToLawyerRepo.getFilterHomeLawyer();
    res.fold((l) {
      emit(ErrorGetFilterSpecialist());
    }, (r) {
      mainSpecialitiesModel = r;
      emit(LoadedGetFilterSpecialist());
    });
  }

  /// إزالة صورة من القائمة
  void removeImage(File file) {
    uploadedImages.remove(file);
    emit(FileRemovedSuccessfully());
  }

  /// اختيار صورة واحدة من المعرض أو الكاميرا
  Future<void> pickImage(BuildContext context, bool isGallery) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera,
      );

      if (pickedFile != null) {
        File file = File(pickedFile.path);
        if (!uploadedImages.contains(file)) {
          uploadedImages.add(file);
          emit(FilePickedSuccessfully());
        } else {
          emit(FileAlreadyExists()); // الصورة مكررة
        }
      } else {
        emit(FileNotPicked());
      }
    } catch (e) {
      emit(FileNotPicked()); // التعامل مع أي خطأ أثناء اختيار الصورة
    }
  }

  /// اختيار عدة صور من المعرض
  Future<void> pickImages(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final pickedFiles = await picker.pickMultiImage(
        maxHeight: 500,
        maxWidth: 500,
        imageQuality: 100,
      );

      if (pickedFiles.isNotEmpty) {
        for (final file in pickedFiles) {
          File imageFile = File(file.path);
          if (!uploadedImages.contains(imageFile)) {
            uploadedImages.add(imageFile);
          }
        }
        emit(FilePickedSuccessfully());
      } else {
        emit(FileNotPicked());
      }
    } catch (e) {
      emit(FileNotPicked()); // التعامل مع أي خطأ أثناء اختيار الصور
    }
  }

  /// مسح جميع الصور المختارة
  void clearUploadedImages() {
    uploadedImages.clear();
    emit(AllFilesCleared());
  }

  // AddNewCourtCaseModel? addNewCourtCaseModel;

  /// إرسال بيانات القضية الجديدة
  Future<void> addNewCourtCase(BuildContext context) async {
    emit(AddNewCourtCaseLoading());

    final res = await addNewCourtCaseAndSendCourtToLawyerRepo.addNewCourtCase(
      title: courtTitleController.text,
      details: courtDescriptionController.text,
      caseEstimatedPrice: courtPriceController.text,
      caseNumber: courtNumberController.text,
      specialityId: selectedSpecialization?.id.toString() ?? "",
      images: uploadedImages,
    );

    res.fold((l) {
      emit(AddNewCourtCaseError());
      errorGetBar(l.toString());
      debugPrint("❌ فشل في إضافة القضية: ${l.toString()}"); // طباعة الخطأ
      emit(AddNewCourtCaseError());
      courtDescriptionController.clear();
      courtNumberController.clear();
      courtPriceController.clear();
      courtTitleController.clear();
      clearUploadedImages();
    }, (r) async {
      if (r.status == 200) {
        // addNewCourtCaseModel = r;
        emit(AddNewCourtCaseLoaded());
        AwesomeDialog(
          context: context,
          showCloseIcon: false,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          padding: EdgeInsets.all(10.w),
          title: "add_publish".tr(),
          btnOkOnPress: () {
            Navigator.pop(context);
            // clearUploadedImages();
          },
          btnOkText: "done".tr(),
        ).show();
        successGetBar(r.msg ?? '');
        clearUploadedImages();
        clearUploadedImages();
        courtDescriptionController.clear();
        courtNumberController.clear();
        courtPriceController.clear();
        courtTitleController.clear();
        context.read<TheCourtsCustomerCubit>().getCourtData();
      } else if (r.status == 422) {
        errorGetBar(r.msg ?? '');
        emit(AddNewCourtCaseError()); // 🔥 يجب إصدار هذه الحالة لإيقاف التحميل
      }
    });
  }

  Future<void> addPrivateCase(BuildContext context,
      {required int lawyerId}) async {
    emit(AddPrivateCaseLoading());

    final res =
        await addNewCourtCaseAndSendCourtToLawyerRepo.sendCourtCaseFromLawyer(
      title: courtTitleController.text,
      details: courtDescriptionController.text,
      price: courtPriceController.text,
      caseNumber: courtNumberController.text,
      specialityId: selectedSpecialization?.id.toString() ?? "",
      images: uploadedImages,
      type: typeSelectedValue?.name ?? "",
      lawyerId: lawyerId.toString(),
    );

    res.fold((l) {
      emit(AddPrivateCaseError());
      errorGetBar(l.toString());
      debugPrint("❌ فشل في إضافة القضية: ${l.toString()}"); // طباعة الخطأ
      emit(AddPrivateCaseError());
      courtDescriptionController.clear();
      courtNumberController.clear();
      courtPriceController.clear();
      courtTitleController.clear();
      clearUploadedImages();
    }, (r) async {
      if (r.status == 200) {
        // addNewCourtCaseModel = r;
        emit(AddPrivateCaseLoaded());
        AwesomeDialog(
          context: context,
          showCloseIcon: false,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          padding: EdgeInsets.all(10.w),
          title: "add_publish".tr(),
          btnOkOnPress: () {
            Navigator.pop(context);
            // clearUploadedImages();
          },
          btnOkText: "done".tr(),
        ).show();
        successGetBar(r.msg ?? '');
        clearUploadedImages();
        clearUploadedImages();
        courtDescriptionController.clear();
        courtNumberController.clear();
        courtPriceController.clear();
        courtTitleController.clear();
        context.read<TheCourtsCustomerCubit>().getCourtData();
      } else {
        errorGetBar(r.msg ?? '');
        emit(AddPrivateCaseError()); // 🔥 يجب إصدار هذه الحالة لإيقاف التحميل
      }
    });
  }
}
