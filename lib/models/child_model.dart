import 'package:vaccine_scheduler/models/vaccine_model.dart';

class ChildModel {
  int id;
  String name;
  String gender;
  DateTime dob;
  List<VaccineModel> vaccines;

  ChildModel({
    required this.name,
    required this.gender,
    required this.dob,
    required this.id,
    required this.vaccines,
  });
}
