import 'dart:developer';
import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/cubit/sos_lawyers_state.dart';
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/data/models/send_sos_request.dart';
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/data/models/sos_lawyers_model.dart';
import 'package:ataaby/features/customer/sos_courts/sos_lawyers/data/repos/sos_lawyers_repo.dart';
import 'package:ataaby/features/splash/cubit/cubit.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:permission_handler/permission_handler.dart';

class SosLawyersCubit extends Cubit<SosLawyersState> {
  SosLawyersCubit(this.sosLawyersRepo) : super(SosLawyersInitial());
  SosLawyersRepo sosLawyersRepo;

  TextEditingController descriptionProblemController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? recordedFilePath;

  final RecorderController recorderController = RecorderController();
  final PlayerController playerController = PlayerController();

  Future<void> initializeRecorder() async {
    await recorderController.checkPermission();
  }

  Future<void> startRecording(BuildContext context) async {
    await requestPermission(context);
    recordedFilePath = null;
    emit(OnStartRecordingVoiceState());

    if (recorderController.hasPermission) {
      await recorderController.record();
    }
    emit(OnStartRecordingVoiceState());
  }

  clearRecordedFilePath() {
    recordedFilePath = null;
    emit(ClearVoiceFilepathState());
  }

  PermissionStatus _permissionStatus = PermissionStatus.denied;

  Future<void> requestPermission(BuildContext context) async {
    final status = await Permission.microphone.request();

    _permissionStatus = status;

    emit(AllowMicrophoneState());
    if (status.isPermanentlyDenied) {
      // Handle the case where the user has permanently denied the permission
      _showPermissionDeniedDialog(context);
    }
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Permission Required"),
        content: Text(
          "This app needs microphone access to record audio. Please enable it in the app settings.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              openAppSettings(); // Open app settings for the user to manually enable the permission
              Navigator.pop(context);
            },
            child: Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  Future<void> stopRecording() async {
    if (recorderController.isRecording) {
      recordedFilePath = await recorderController.stop();
      log("==> =========>> ${recordedFilePath ?? ''}");
    }
    emit(OnStopRecordingVoiceState());
  }

  SendSosRequestModel? sendSosRequest;
  Future<void> addSosRequest(
    BuildContext context, {
    required String lawyerId,
  }) async {
    emit(LoadingAddSosRequestState());
    final res = await sosLawyersRepo.addSosRequest(
      address: addressController.text,
      lat: context.read<SplashCubit>().currentLocation?.latitude?.toString() ??
          '',
      lawyerId: lawyerId,
      long: context.read<SplashCubit>().currentLocation?.altitude?.toString() ??
          '',
      phone: phoneController.text,
      problem: descriptionProblemController.text,
      voice: recordedFilePath ?? "",
    );

    res.fold((l) {
      errorGetBar(l.toString());
      emit(ErrorAddSosRequestState());
    }, (r) {
      successGetBar(r.msg ?? "");
      descriptionProblemController.clear();
      phoneController.clear();
      addressController.clear();
      // Navigator.pushNamed(context, Routes.mainCustomerRoute,
      //     arguments:ChooseTypeRegisterArgs(indexPageClientOrLawyer: 0));
      emit(LoadedAddSosRequestState());
    });
  }

  SosLawyerRequestModel? sosLawyerRequestModel;
  Future<void> sosLawyerData(BuildContext context) async {
    emit(LoadingSosLawyerState());
    final res = await sosLawyersRepo.sosLawyerData(
      lat: context.read<SplashCubit>().currentLocation?.latitude?.toString() ??
          '',
      long: context.read<SplashCubit>().currentLocation?.altitude?.toString() ??
          '',
    );
    res.fold((l) {
      emit(ErrorSosLawyerState());
    }, (r) {
      sosLawyerRequestModel = r;
      emit(LoadedSosLawyerState());
    });
  }
}
