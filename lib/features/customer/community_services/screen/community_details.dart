import 'package:ataaby/core/widgets/custom_appbar_title_and_back.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter_html/flutter_html.dart';

import '../../../../core/exports.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class ArgumentOfCommunityDetailsServices {
  String title;
  int id;
  bool isLawyer;

  ArgumentOfCommunityDetailsServices({
    required this.title,
    required this.id,
    required this.isLawyer,
  });
}

class CommunityDetailsScreen extends StatefulWidget {
  const CommunityDetailsScreen({required this.model, super.key});
  final ArgumentOfCommunityDetailsServices model;
  @override
  State<CommunityDetailsScreen> createState() => _CommunityDetailsScreenState();
}

const String htmlContent = """
      <div style='padding: 20px; direction: rtl; text-align: right;'>
        <h1 style='color: #2196F3;'>دليل ترخيص السيارات في مصر</h1>
        
        <h2>الأوراق المطلوبة للترخيص:</h2>
        <ul>
          <li>صورة البطاقة الشخصية</li>
          <li>استمارة الفحص الفني للسيارة</li>
          <li>وثيقة التأمين الإجباري سارية</li>
          <li>إيصال سداد الضرائب والرسوم</li>
          <li>شهادة براءة الذمة من المخالفات المرورية</li>
        </ul>
        
        <h2>خطوات الترخيص:</h2>
        <div style='border: 2px solid #2196F3; padding: 15px; margin: 10px 0;'>
          <p>١. التوجه إلى وحدة المرور التابع لها</p>
          <p>٢. سداد الرسوم المقررة</p>
          <p>٣. إجراء الفحص الفني للسيارة</p>
          <p>٤. استلام الرخصة الجديدة</p>
        </div>
        
        <h2>الرسوم المطلوبة:</h2>
        <table border='1'>
          <tr>
            <th>نوع الرسم</th>
            <th>القيمة</th>
          </tr>
          <tr>
            <td>رسوم الترخيص الأساسية</td>
            <td>حسب سعة المحرك</td>
          </tr>
          <tr>
            <td>ضريبة القيمة المضافة</td>
            <td>١٤٪</td>
          </tr>
          <tr>
            <td>رسوم الفحص الفني</td>
            <td>يتم تحديدها حسب نوع السيارة</td>
          </tr>
        </table>
        
        <h2>معلومات هامة:</h2>
        <div style='background-color: #FFF3E0; padding: 15px; margin: 10px 0;'>
          <p>• مدة صلاحية الرخصة ٣ سنوات</p>
          <p>• يجب تجديد التأمين الإجباري سنوياً</p>
          <p>• يمكن الاستعلام عن المخالفات عبر موقع المرور الإلكتروني</p>
        </div>
      </div>
    """;

class _CommunityDetailsScreenState extends State<CommunityDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityServicesCubit, CommunityServicesState>(
      builder: (context, state) {
        var cubit = context.read<CommunityServicesCubit>();
        return Scaffold(
          body: Column(
            children: [
              //!
              CustomAppBarTitleAndbackButton(
                title: 'community_services'.tr(),
                isLawyer: widget.model.isLawyer,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Html(
                    data: htmlContent,
                    style: {
                      "h1": Style(
                        fontSize: FontSize.large,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                      "table": Style(
                        border: Border.all(color: Colors.black),
                        padding: HtmlPaddings.all(8.0),
                      ),
                      "td": Style(
                        padding:
                            HtmlPaddings.symmetric(vertical: 5, horizontal: 10),
                        border: Border.all(color: Colors.black),
                      ),
                      "th": Style(
                        padding:
                            HtmlPaddings.symmetric(vertical: 5, horizontal: 10),
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.grey[300],
                      ),
                      "img": Style(
                        width: Width(150.w),
                        height: Height.auto(),
                      ),
                    },
                  ),
                ),
              )
              /*  ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cubit.pdfFiles.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    cubit.onTapToOpenPdf(context, cubit.pdfFiles[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: customShadow,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.fileIcon,
                          ),
                          10.w.horizontalSpace,
                          Flexible(
                            fit: FlexFit.tight,
                            child: Text(cubit.pdfFiles[index].name ?? '',
                                style: getUnderLine(color: AppColors.primary)),
                          ),
                          IconButton(
                              onPressed: () {
                                cubit.downloadPdf(cubit.pdfFiles[index]);
                                // cubit.requestPermissionAndDownload(
                                // cubit.pdfFiles[index], context);
                              },
                              icon: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: cubit.pdfFiles[index].progress == 100
                                        ? AppColors.greenLight
                                        : AppColors.primary,
                                    strokeWidth: 2,
                                    value:
                                        (cubit.pdfFiles[index].progress ?? 0) /
                                            100,
                                  ),
                                  cubit.pdfFiles[index].progress == 100
                                      ? Icon(
                                          CupertinoIcons.checkmark_alt,
                                          color: AppColors.greenLight,
                                        )
                                      : Icon(
                                          CupertinoIcons.arrow_down,
                                          color: AppColors.primary,
                                        ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        );
      },
    );
  }
}
