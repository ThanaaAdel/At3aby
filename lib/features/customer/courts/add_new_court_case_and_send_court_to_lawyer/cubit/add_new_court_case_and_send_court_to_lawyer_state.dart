
 class AddNewCourtCaseAndSendCourtToLawyerState {}

 class AddNewCourtCaseAndSendCourtToLawyerInitial extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class AdvanceDateSelectedState extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class FilePickedSuccessfully extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class FileNotPicked extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class FileRemovedSuccessfully extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class AllFilesCleared extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class FileAlreadyExists extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class AddNewCourtCaseLoading extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class OnChangeFilterItemState extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class LoadingGetFilterSpecialist extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class ErrorGetFilterSpecialist extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class LoadedGetFilterSpecialist extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class AddNewCourtCaseLoaded extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class AddNewCourtCaseError extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class AddPrivateCaseError extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class AddPrivateCaseLoading extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class AddPrivateCaseLoaded extends AddNewCourtCaseAndSendCourtToLawyerState {}
 class PublishNewIssueError extends AddNewCourtCaseAndSendCourtToLawyerState {
   final String message;
   PublishNewIssueError(this.message);
 }
