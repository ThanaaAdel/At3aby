import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/login/data/models/login_model_lawyer.dart';

import 'widgets/lawer_item.dart';

class AllLawyerScreen extends StatelessWidget {
  AllLawyerScreen({super.key, required this.title, this.loginModelLawyer});
  String title;
  final List<LoginModelLawyerData>? loginModelLawyer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) =>  Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: LawyerItem(type: 'home',
          loginModelLawyer:loginModelLawyer?[index] ,),
        ),
        itemCount: loginModelLawyer?.length,
      ),
    );
  }
}
