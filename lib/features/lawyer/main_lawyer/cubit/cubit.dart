import '../../../../core/exports.dart';
import '../../current_issues/screen/current_issues.dart';
import '../../home_lawyer/screen/home_lawyer.dart';
import '../../market_lawyer/screen/market_lawyer.dart';
import '../../profile_lawyer/Screen/profile_lawyer_screen.dart';
import '../data/repo/main_lawyer_repo.dart';
import 'state.dart';

class MainLawyerCubit extends Cubit<MainLawyerState> {
  MainLawyerCubit(this.api) : super(MainLawyerInitial());

  MainLawyerRepo api;
  int currentIndex = 0;
  final List<Widget> buildScreens = [
    const HomeLawyerScreen(),
    const CurrentIssuesScreen(),
    const MarketLawyerScreen(),
     const ProfileLawyerScreen(),
  ];
}
