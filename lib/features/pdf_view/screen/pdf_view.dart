import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../core/exports.dart';
import '../../customer/contract_and_doc/cubit/contract_and_doc_cubit.dart';
import '../../customer/contract_and_doc/cubit/contract_and_doc_state.dart';
import '../../customer/contract_and_doc/data/model/contracts_model.dart';

class PDFViewScreen extends StatefulWidget {
  final PDFFileElement pdfModel;

  const PDFViewScreen({super.key, required this.pdfModel});

  @override
  State<PDFViewScreen> createState() => _PDFViewScreenState();
}

class _PDFViewScreenState extends State<PDFViewScreen> {
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractAndDocumentCubit, ContractAndDocumentState>(
      builder: (context, state) {
        var cubit = context.read<ContractAndDocumentCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.pdfModel?.fileName ?? 'PDF Viewer'),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     cubit.requestPermissionAndDownload(widget.pdfModel, context);
          //   },
          //   child: const Icon(Icons.download),
          // ),
          body: Stack(
            children: [
              (widget.pdfModel.filePath != null &&
                      widget.pdfModel.filePath!.isNotEmpty)
                  ? SfPdfViewer.network(
                      widget.pdfModel.filePath!,
                      onDocumentLoadFailed: (details) {
                        setState(() {
                          errorMessage = details.description;
                        });
                      },
                    )
                  : const Center(
                      child: Text(
                        'No PDF available to display',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
              if (errorMessage.isNotEmpty)
                Center(
                  child: Text(errorMessage,
                      style: const TextStyle(color: Colors.red)),
                ),
            ],
          ),
        );
      },
    );
  }
}
