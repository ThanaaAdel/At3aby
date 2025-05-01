import 'package:ataaby/core/exports.dart';

class IssueModel {
  final String nameLawyer;
  final String imageLawyer;
  final String imageIssue;
  final String descriptionIssue;
  final String descriptionLawyer;
  final String date;
  final String status;
  final String cost;
  final String numberIssue;
  final Color colorStatus;

  IssueModel({
    required this.nameLawyer,
    required this.colorStatus,
    required this.imageIssue,
    required this.imageLawyer,
    required this.descriptionIssue,
    required this.descriptionLawyer,
    required this.date,
    required this.status,
    required this.cost,
    required this.numberIssue,
  });
}
