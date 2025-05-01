
 class AddNewUpdateState {}

 class AddNewUpdateInitial extends AddNewUpdateState {}
 class AdvanceDateSelectedState extends AddNewUpdateState {}
 class FilePickedSuccessfully extends AddNewUpdateState {}
 class FileNotPicked extends AddNewUpdateState {}
 class FileRemovedSuccessfully extends AddNewUpdateState {}
 class AllFilesCleared extends AddNewUpdateState {}
 class FileAlreadyExists extends AddNewUpdateState {}
 class AddNewUpdateError extends AddNewUpdateState {
   final String message;
   AddNewUpdateError(this.message);
 }
 class LoadingAddNewUpdatesForCouse extends AddNewUpdateState {}
 class LoadedAddNewUpdatesForCouse extends AddNewUpdateState {}
 class ErrorAddNewUpdatesForCouse extends AddNewUpdateState {}
