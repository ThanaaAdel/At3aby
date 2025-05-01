import 'package:ataaby/core/exports.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MySvgWidget extends StatelessWidget {
  const MySvgWidget({super.key, required this.path, required this.imageColor, required this.size});

  final String path;
  final Color imageColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: SvgPicture.asset(
        path,
        colorFilter: ColorFilter.mode(imageColor, BlendMode.srcIn),
        // height: size,
        // width: size,
      ),
    );
  }
}
