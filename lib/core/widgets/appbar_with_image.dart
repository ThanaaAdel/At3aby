import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/home_lawyer/data/model/issue_model.dart';

class AppbarContainImage extends StatelessWidget {
  const AppbarContainImage({
    super.key,
    required this.isLawyer,
    this.widget,
    this.titleCenter,
    this.issueModel,
    this.onTap,
  });
  final IssueModel? issueModel;
  final bool isLawyer;
  final Widget? widget;
  final String? titleCenter;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isLawyer
            ? Image.asset(
                ImageAssets.smallAppbarImage,
                width: double.infinity,
              )
            : Image.asset(
                ImageAssets.smallAppbarCustomerImage,
                width: double.infinity,
              ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 20.0.h,
            top: 30.0.h,
          ),
          child: CustomAppbar(
            onTap: onTap,
            widget: widget,
            titleCenter: titleCenter,

          ),
        ),
      ],
    );
  }
}
