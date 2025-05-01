
import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/about_app/cubit/about_app_state.dart';

import '../data/repos/about_app_repo.dart';

class AboutAppCubit extends Cubit<AboutAppState> {
  AboutAppCubit(this.aboutAppRepo) : super(AboutAppInitial());
  AboutAppRepo aboutAppRepo ;

}
