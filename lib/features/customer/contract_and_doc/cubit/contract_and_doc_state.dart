abstract class ContractAndDocumentState {}

class ContractAndDocumentInitial extends ContractAndDocumentState {}

class OpenContractAndDocumentLoading extends ContractAndDocumentState {}

class OpenContractAndDocumentLoaded extends ContractAndDocumentState {}

class OpenContractAndDocumentProgress extends ContractAndDocumentState {}

class OpenContractAndDocumentSuccess extends ContractAndDocumentState {}

class OpenContractAndDocumentError extends ContractAndDocumentState {}
class LoadedGetContractsData extends ContractAndDocumentState {}

class ErrorGetContractsData extends ContractAndDocumentState {}

class LoadingGetContractsData extends ContractAndDocumentState {}
