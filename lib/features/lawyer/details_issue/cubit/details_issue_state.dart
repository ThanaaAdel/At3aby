abstract class DetailsIssueState {}

class DetailsIssueInitial extends DetailsIssueState {}

class ChangeIndexState extends DetailsIssueState {}

class GetCourtByIdLoading extends DetailsIssueState {}

class GetCourtByIdSuccess extends DetailsIssueState {}

class GetCourtByIdError extends DetailsIssueState {}

class GetRefuseReasonsLoading extends DetailsIssueState {}

class GetRefuseReasonsSuccess extends DetailsIssueState {}

class GetRefuseReasonsError extends DetailsIssueState {}

class LoadingGetRefuseState extends DetailsIssueState {}

class LoadedGetRefuseState extends DetailsIssueState {}

class ErrorGetRefuseState extends DetailsIssueState {}

class LoadingActionCourtCaseState extends DetailsIssueState {}

class LoadedActionCourtCaseState extends DetailsIssueState {}

class ErrorActionCourtCaseState extends DetailsIssueState {}

class LoadingAddEventCourtCaseState extends DetailsIssueState {}

class LoadedAddEventCourtCaseState extends DetailsIssueState {}

class ErrorAddEventCourtCaseState extends DetailsIssueState {}

class AddCourtCaseDuesLoading extends DetailsIssueState {}

class AddCourtCaseDuesError extends DetailsIssueState {}

class AddCourtCaseDuesLoaded extends DetailsIssueState {}

class AdvanceDateSelectedState extends DetailsIssueState {}

class LoadingAdvanceDateSelectedState extends DetailsIssueState {}

class LoadingDeleteEventCourtCaseState extends DetailsIssueState {}

class LoadedDeleteEventCourtCaseState extends DetailsIssueState {}

class ErrorDeleteEventCourtCaseState extends DetailsIssueState {}

class LoadingDeleteNewUpdatesForCouse extends DetailsIssueState {}

class LoadedDeleteNewUpdatesForCouse extends DetailsIssueState {}

class ErrorDeleteNewUpdatesForCouse extends DetailsIssueState {}

class LoadingUpdateNewUpdatesForCouse extends DetailsIssueState {}

class LoadedUpdateNewUpdatesForCouse extends DetailsIssueState {}

class ErrorUpdateNewUpdatesForCouse extends DetailsIssueState {}
