import 'package:ataaby/features/customer/community_services/data/models/get_community_service_categories_model.dart';
import 'package:ataaby/features/customer/community_services/data/models/get_community_service_details_categories_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/exports.dart';
import '../../contract_and_doc/data/model/doc_model.dart';
import '../data/repos/repo_implementation.dart';
import 'state.dart';
import 'package:http/http.dart' as http;

class CommunityServicesCubit extends Cubit<CommunityServicesState> {
  CommunityServicesCubit(this.api) : super(CommunityServicesInitial());
  CommunityServicesRepo api;
  Map<int, bool> expandedIndexes = {}; // تخزين حالة التوسيع لكل عنصر
  void toggleExpand(int index) {
    expandedIndexes[index] = !(expandedIndexes[index] ?? false);
    emit(CommunityServiceUpdated()); // تأكد من وجود هذا الـ State في `state.dart`
  }
  TextEditingController searchController = TextEditingController();
  TextEditingController postController = TextEditingController();
  // main  category
  GetCommunityServiceCategoriesModel? mainCommunityService;
  getCommunityServiceCategories() async {
    emit(LoadingGetCommunityServiceCategories());
    final res = await api.getCommunityServiceCategories(
      searchController.text ?? '',
    );
    res.fold((l) {
      emit(ErrorGetCommunityServiceCategories());
    }, (r) {
      mainCommunityService = r;
      emit(LoadedGetCommunityServiceCategories());
    });
  }



  //sub sub category
  GetCommunityServiceDetailsFromCategoriesModel? getCommunityServiceDetailsFromCategoriesModel;
  getCommunityServiceDetailsCategories({required String id}) async {
    emit(LoadingGetCommunityServiceSubSubCategories());
    final res = await api.getCommunityServiceDetailsCategories(
      id: id,
    );
    res.fold((l) {
      emit(ErrorGetCommunityServiceSubSubCategories());
    }, (r) {
      getCommunityServiceDetailsFromCategoriesModel = r;
      emit(LoadedGetCommunityServiceSubSubCategories());
    });
  }

  List<PdfFileModel> pdfFiles = [
    PdfFileModel(
        id: 1,
        name: 'ملف ابتدائي للقضية',
        pdfLink:
            'https://mjle.journals.ekb.eg/article_269288_90f8177e5dd2dd873b8d1fd1cc032a7d.pdf',
        price: 1),
    PdfFileModel(
        id: 2,
        name: 'ملف ثانوي للقضية',
        pdfLink:
            'https://mjle.journals.ekb.eg/article_269288_90f8177e5dd2dd873b8d1fd1cc032a7d.pdf',
        price: 1),
    PdfFileModel(
        id: 3,
        name: 'ملف استئناف للقضية',
        pdfLink:
            'https://mjle.journals.ekb.eg/article_269288_90f8177e5dd2dd873b8d1fd1cc032a7d.pdf',
        price: 1),
    PdfFileModel(
        id: 1,
        name: 'ملف ابتدائي للقضية',
        pdfLink:
            'https://mjle.journals.ekb.eg/article_269288_90f8177e5dd2dd873b8d1fd1cc032a7d.pdf',
        price: 1),
    PdfFileModel(
        id: 2,
        name: 'ملف ثانوي للقضية',
        pdfLink:
            'https://mjle.journals.ekb.eg/article_269288_90f8177e5dd2dd873b8d1fd1cc032a7d.pdf',
        price: 1),
    PdfFileModel(
        id: 3,
        name: 'ملف استئناف للقضية',
        pdfLink:
            'https://mjle.journals.ekb.eg/article_269288_90f8177e5dd2dd873b8d1fd1cc032a7d.pdf',
        price: 1),
  ];

  // onTapToOpenPdf(BuildContext context, PdfFileModel model) {
  //   // emit(OpenContractAndDocumentLoading());
  //   Navigator.pushNamed(context, Routes.pdfViewScreen, arguments: model);
  // }

  String localPath = ''; // Path to display PDF
  bool isDownloading = false;
  bool nightMode = false; // Flag for night mode
  double downloadProgress = 0.0; // Track download progress
  Uint8List? pdfBytes;

  Future<Uint8List?> fetchPdfBytes(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print("Failed to load PDF. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred: $e");
      return null;
    }
  }

  Future<void> sharePdf() async {
    if (pdfBytes != null) {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/document.pdf');
      await file.writeAsBytes(pdfBytes!);
      final xFile = XFile(file.path);
      await Share.shareXFiles([xFile], text: 'Check out this PDF document!');
    } else {
      errorGetBar(
        "PDF not loaded yet, please try again later",
      );
    }
  }

  downloadCurrentPdfOnError(String pdfUrl) async {
    pdfBytes = await fetchPdfBytes(pdfUrl);
    await sharePdf();
  }

  Future<void> downloadPdf(PdfFileModel model) async {
    try {
      // Request storage permission
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        await downloadCurrentPdfOnError(model.pdfLink ?? '');
        throw Exception('Storage permission not granted');
      }

      //!
      final url = Uri.parse(model.pdfLink!);

      // Perform a HEAD request to fetch Content-Length
      final headResponse = await http.head(url);
      final contentLength =
          int.tryParse(headResponse.headers['content-length'] ?? '0');

      if (contentLength == null || contentLength <= 0) {
        emit(OpenContractAndDocumentError());
        return;
      }

      final request = http.Request('GET', url);
      final streamedResponse = await http.Client().send(request);

      if (streamedResponse.statusCode == 200) {
        // Get the directory for saving the file
        Directory? directory;
        if (Platform.isAndroid) {
          directory = await getExternalStorageDirectory();
        } else if (Platform.isIOS) {
          directory = await getApplicationDocumentsDirectory();
        }
        if (directory == null) {
          await downloadCurrentPdfOnError(model.pdfLink ?? '');
          throw Exception('Could not get the download directory');
        }

        String filePath = '${directory.path}/${model.name ?? 'download'}.pdf';
        final file = File(filePath);
        final sink = file.openWrite();
        Dio dio = Dio();
        await dio.download(
          model.pdfLink ?? '',
          filePath,
          options:
              Options(responseType: ResponseType.bytes, followRedirects: true),
          onReceiveProgress: (receivedBytes, totalBytes) async {},
        );
        int downloaded = 0;

        await for (var chunk in streamedResponse.stream) {
          sink.add(chunk);
          downloaded += chunk.length;

          final progress =
              (downloaded / contentLength * 100).toStringAsFixed(2);
          print('==>> $progress :: ${model.progress}');
          model.progress = (downloaded / contentLength * 100);
          emit(OpenContractAndDocumentProgress());
        }
        print('File downloaded to: $filePath');

        successGetBar('تم تحميل الملف بنجاح \n $filePath',
            duration: const Duration(seconds: 3));
      }
      //!
    } catch (e) {
      await downloadCurrentPdfOnError(model.pdfLink ?? '');
      print('Error downloading file: $e');
    }
  }
}
