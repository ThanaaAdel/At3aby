import 'dart:developer';

import 'package:ataaby/core/exports.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cubit/cubit.dart';

class CustomMainMarketOfferWidget extends StatefulWidget {
  CustomMainMarketOfferWidget({this.cubit, super.key});
  MarketLawyerCubit? cubit;
  @override
  State<CustomMainMarketOfferWidget> createState() =>
      _CustomMainMarketOfferWidgetState();
}

class _CustomMainMarketOfferWidgetState
    extends State<CustomMainMarketOfferWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: Padding(
        padding: EdgeInsets.all(8.0.sp), // إضافة البادينج باستخدام ScreenUtil
        child: Swiper(
          autoplayDelay: 3000,
          autoplay: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
              ),
              child: Stack(
                fit: StackFit.loose, // جعل النص يظهر فوق الصورة
                children: [
                  InkWell(
                    focusColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pushNamed(context, Routes.detailsProductRoute,
                          arguments: widget
                              .cubit
                              ?.mainHomeMarketModel
                              ?.data
                              ?.marketOffer?[index]
                              .marketProduct); // وظيفة عند الضغط على الصورة
                      log("Tapped on image $index");
                    },
                    child: ClipRRect(
                      child: Image.network(
                        widget.cubit?.mainHomeMarketModel?.data
                                ?.marketOffer?[index].image ??
                            '', // استخدام الصور المحلية من القائمة
                        fit: BoxFit.cover,
                        width:
                            double.infinity, // ضبط الصورة لتغطية الـContainer
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount:
              widget.cubit?.mainHomeMarketModel?.data?.marketOffer?.length ??
                  0, // عدد العناصر في الـSwiper
        ),
      ),
    );
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $urlString';
    }
  }
}
