import 'package:ataaby/core/exports.dart';
import 'package:ataaby/features/lawyer/issues_status/cubit/issue_status_state.dart';
import 'package:ataaby/features/lawyer/issues_status/data/repo/issue_status.dart';

class IssueStatusCubit extends Cubit<IssueStatusState> {
  IssueStatusCubit(this.repo) : super(IssueStatusInitial());
  IssueStatusRepo repo;
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }
}
