import 'package:ataaby/core/exports.dart';

class SplashFrameOne extends StatelessWidget {
  const SplashFrameOne({super.key, required this.isSplash});
  final bool isSplash;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isSplash
            ? SizedBox(
                width: getWidthSize(context),
                child: Stack(alignment: Alignment.topRight, children: [
                  Positioned(
                    top: 5,
                    child: Image.asset(ImageAssets.frameOneHeader,
                        height: 300.h, width: 300.w),
                  ),
                  Positioned(
                      top: -100,
                      right: -50,
                      child: Image.asset(ImageAssets.frameOneHeader,
                          height: 200.h, width: 200.w)),
                ]))
            : Container(),
        const Spacer(),
        Image.asset(ImageAssets.frameOneFooter),
      ],
    );
  }
}
