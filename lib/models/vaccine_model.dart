class VaccineModel {
  late int? childId;
  late int? vaccineId;
  late int weekToBeTaken;
  late int daysPeriodBeforeNotification;
  String? vaccineName;
  bool? isTaken;
  DateTime? dateTaken;

  VaccineModel({
    required this.childId,
    required this.vaccineId,
    required this.weekToBeTaken,
    required this.daysPeriodBeforeNotification,
    this.dateTaken,
    required this.isTaken,
    required this.vaccineName,
  });
}
