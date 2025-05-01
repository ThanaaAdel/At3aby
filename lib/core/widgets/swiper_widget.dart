import 'package:ataaby/core/exports.dart';
import 'package:card_swiper/card_swiper.dart';

class SwiperWidget extends StatefulWidget {
  const SwiperWidget({super.key});

  @override
  State<SwiperWidget> createState() => _SwiperWidgetState();
}

class _SwiperWidgetState extends State<SwiperWidget> {
  // قائمة الصور المحلية
  final List<String> imageAssets = [
    "assets/images/test_swiper.png",
    "assets/images/market_example.png",
    "assets/images/test.png",
    "assets/images/test_swiper.png",
    "assets/images/market_example.png",
    "assets/images/test.png",
  ];

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
                    onTap: () {
                      // وظيفة عند الضغط على الصورة
                      print("Tapped on image $index");
                    },
                    child: ClipRRect(
                      child: Image.asset(
                        imageAssets[index], // استخدام الصور المحلية من القائمة
                        fit: BoxFit.contain,
                        width:
                            double.infinity, // ضبط الصورة لتغطية الـContainer
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: imageAssets.length, // عدد العناصر في الـSwiper
        ),
      ),
    );
  }
}
