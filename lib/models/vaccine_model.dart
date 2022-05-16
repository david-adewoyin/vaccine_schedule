class VaccineModel {
  late int? childId;
  late int? vaccineId;
  late int weekToBeTaken;
  String? vaccineName;
  bool? isTaken;
  DateTime? dateTaken;

  VaccineModel({
    required this.childId,
    required this.vaccineId,
    required this.weekToBeTaken,
    this.dateTaken,
    required this.isTaken,
    required this.vaccineName,
  });
}
