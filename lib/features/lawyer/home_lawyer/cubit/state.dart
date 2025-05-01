abstract class HomeLawyerState {}

class HomeLawyerStateInitial extends HomeLawyerState {}

class ChangeColorState extends HomeLawyerState {}

class OnChangeFilterItemState extends HomeLawyerState {}

class OnClearFilterItemState extends HomeLawyerState {}

class LoadingGetFilterSpecialist extends HomeLawyerState {}

class LoadedGetFilterSpecialist extends HomeLawyerState {}

class ErrorGetFilterSpecialist extends HomeLawyerState {}

class HomeLawyerStateSuccess extends HomeLawyerState {}

class HomeLawyerStateLoading extends HomeLawyerState {}

class HomeLawyerStateError extends HomeLawyerState {}
class GetOfficeRequestStateLoading extends HomeLawyerState {}

class GetOfficeRequestStateError extends HomeLawyerState {}

class GetOfficeRequestStateSuccess extends HomeLawyerState {}
class CourtCaseFromSearchLoading extends HomeLawyerState {}

class CourtCaseFromSearchError extends HomeLawyerState {}

class CourtCaseFromSearchSuccess extends HomeLawyerState {}
