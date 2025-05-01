import 'package:ataaby/features/customer/contract_and_doc/data/model/contracts_model.dart';

import '../../../../core/exports.dart';
import '../data/model/doc_model.dart';
import '../data/repo_implementaion/repo_impl_contractanddoc.dart';
import 'contract_and_doc_state.dart';

class ContractAndDocumentCubit extends Cubit<ContractAndDocumentState> {
  ContractAndDocumentCubit(this.api) : super(ContractAndDocumentInitial());
  ContractAndDocumentRepo api;

  //!
  TextEditingController searchController = TextEditingController();

  onTapToOpenPdf(BuildContext context, PDFFileElement model) {
    // emit(OpenContractAndDocumentLoading());
    Navigator.pushNamed(context, Routes.pdfViewScreen, arguments: model);
  }

  GetContractsModel? getContractsModel;
  getContractsData() async {
    emit(LoadingGetContractsData());
    final res = await api.getContactsData(searchController.text ?? '');
    res.fold((l) {
      emit(ErrorGetContractsData());
    }, (r) {
      getContractsModel = r;
      emit(LoadedGetContractsData());
    });
  }

}
