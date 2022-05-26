import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:vaccine_scheduler/models/child_model.dart';
import 'package:vaccine_scheduler/models/vaccine_model.dart';

const String _tableChildren = "children_table";
const String _columnChildId = "child_id";
const String _columnName = "child_name";
const String _columnDob = "child_dob";
const String _columnGender = "child_gender";

const String _tableVaccine = "vaccine_table";
const String _columnVaccineId = "vaccine_id";
const String _columnDateTaken = "date_taken";
const String _columnVaccineName = "vaccine_name";
const String _columnDaysPeriodBeforeNotification =
    "vaccine_days_period_before_notification";
const String _columnVaccineIsTaken = "vaccine_is_taken";
const String _columnWeekToBeTaken = "week_to_be_taken";

class _Vaccine {
  String name;
  int? vaccineId;
  int weekToBeTaken;
  int daysPeriodBeforeNotification;

  _Vaccine(
      {required this.name,
      required this.weekToBeTaken,
      this.vaccineId,
      required this.daysPeriodBeforeNotification});
}

final vaccines = [
  _Vaccine(
      vaccineId: 1,
      name: "BCG",
      weekToBeTaken: 0,
      daysPeriodBeforeNotification: 1),
  _Vaccine(
      vaccineId: 2,
      name: "OPV0",
      weekToBeTaken: 0,
      daysPeriodBeforeNotification: 1),
  _Vaccine(
      vaccineId: 3,
      name: "Hep B birth",
      weekToBeTaken: 0,
      daysPeriodBeforeNotification: 1),
  _Vaccine(
      vaccineId: 4,
      name: "Pentavalent (DPT, Hep B, Hib) 1",
      weekToBeTaken: 6,
      daysPeriodBeforeNotification: 42),
  _Vaccine(
      vaccineId: 5,
      name: "Pnemococcal Conjugate Vaccine 1",
      weekToBeTaken: 6,
      daysPeriodBeforeNotification: 42),
  _Vaccine(
      vaccineId: 6,
      name: "OPV1",
      weekToBeTaken: 6,
      daysPeriodBeforeNotification: 42),
  _Vaccine(
      vaccineId: 7,
      name: "Rota 1",
      weekToBeTaken: 6,
      daysPeriodBeforeNotification: 42),
  _Vaccine(
      vaccineId: 8,
      name: "Pentavalent (DPT,Hep B,Hib) 2",
      weekToBeTaken: 10,
      daysPeriodBeforeNotification: 70),
  _Vaccine(
      vaccineId: 9,
      name: "Pnemococcal Conjugate Vaccine 2",
      weekToBeTaken: 10,
      daysPeriodBeforeNotification: 70),
  _Vaccine(
      vaccineId: 10,
      name: "OPV2",
      weekToBeTaken: 10,
      daysPeriodBeforeNotification: 70),
  _Vaccine(
      vaccineId: 11,
      name: "ROTA 2",
      weekToBeTaken: 10,
      daysPeriodBeforeNotification: 70),
  _Vaccine(
      vaccineId: 12,
      name: "Pentavalent (DPT,Hep B,Hib) 3",
      weekToBeTaken: 14,
      daysPeriodBeforeNotification: 98),
  _Vaccine(
      vaccineId: 13,
      name: "Pnemococcal Conjugate Vaccine 3",
      daysPeriodBeforeNotification: 98,
      weekToBeTaken: 14),
  _Vaccine(
      vaccineId: 14,
      name: "OPV3",
      weekToBeTaken: 14,
      daysPeriodBeforeNotification: 98),
  _Vaccine(
      vaccineId: 15,
      name: "ROTA 3",
      weekToBeTaken: 14,
      daysPeriodBeforeNotification: 98),
  _Vaccine(
      vaccineId: 16,
      name: "Vitamin A Ist dose",
      weekToBeTaken: 26,
      daysPeriodBeforeNotification: 183),
  _Vaccine(
      vaccineId: 17,
      name: "Measles Ist dose",
      weekToBeTaken: 39,
      daysPeriodBeforeNotification: 274),
  _Vaccine(
      vaccineId: 18,
      name: "Yellow fever",
      weekToBeTaken: 39,
      daysPeriodBeforeNotification: 274),
  _Vaccine(
      vaccineId: 19,
      name: "Meningitis Vaccine",
      weekToBeTaken: 39,
      daysPeriodBeforeNotification: 274),
  _Vaccine(
      vaccineId: 20,
      name: "Vitamin A 2nd dose",
      weekToBeTaken: 65,
      daysPeriodBeforeNotification: 456),
  _Vaccine(
      vaccineId: 21,
      name: "Measles 2 dose (MCV2)",
      weekToBeTaken: 65,
      daysPeriodBeforeNotification: 456),
];

class Child {
  int? id;
  String? name;
  String? dob;
  String? gender;
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      _columnName: name,
      _columnDob: dob,
      _columnGender: gender,
    };
    return map;
  }

  Child({required this.name, required this.dob, required this.gender});

  Child.fromMap(Map<String, Object?> map) {
    id = map[_columnChildId] as int?;
    name = map[_columnName] as String?;
    gender = map[_columnGender] as String?;
    dob = map[_columnDob] as String?;
  }
}

class Vaccine {
  late int? childId;
  late int? vaccineId;
  late int weekToBeTaken;
  late int daysPeriodBeforeNotification;
  String? vaccineName;
  bool? isTaken;
  DateTime? dateTaken;

  Vaccine({
    required this.vaccineId,
    required this.childId,
    required this.weekToBeTaken,
    this.dateTaken,
    required this.daysPeriodBeforeNotification,
    required this.isTaken,
    required this.vaccineName,
  });

  Vaccine.fromMap(Map<String, Object?> map) {
    childId = map[_columnChildId] as int;
    vaccineId = map[_columnVaccineId] as int;
    weekToBeTaken = map[_columnWeekToBeTaken] as int;
    vaccineName = map[_columnVaccineName] as String;
    daysPeriodBeforeNotification =
        map[_columnDaysPeriodBeforeNotification] as int;
    isTaken = (map[_columnVaccineIsTaken] as int) == 0;
    var temp = map[_columnDateTaken] as String?;

    if (temp != null && temp != "null") {
      dateTaken = DateTime.tryParse(temp)!;
    }
  }

  Map<String, Object?> toMap() {
    isTaken ??= false;

    var map = <String, Object?>{
      _columnChildId: childId,
      _columnVaccineIsTaken: isTaken! ? 0 : 1,
      _columnVaccineName: vaccineName,
      _columnVaccineId: vaccineId,
      _columnDateTaken: dateTaken,
      _columnDaysPeriodBeforeNotification: daysPeriodBeforeNotification,
      _columnWeekToBeTaken: weekToBeTaken,
    };
    return map;
  }
}

class DbProvider {
  late Database db;

  Future<void> initDb() async {
    String path = join(await getDatabasesPath(), "vaccine_scheduler_002.db");
    try {
      await open(path);
    } catch (e) {
      print("unable to open path");
    }
  }

  Future open(String path) async {
    try {
      db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute('''
create table $_tableChildren ( 
  $_columnChildId integer primary key autoincrement, 
  $_columnName text not null,
  $_columnDob text not null,
  $_columnGender text not null)
''');
        await db.execute('''
create table $_tableVaccine ( 
  $_columnChildId integer not null, 
  $_columnDaysPeriodBeforeNotification integer not  null,
  $_columnVaccineId integer not null,
  $_columnVaccineName text not null,
  $_columnWeekToBeTaken int not null,
  $_columnVaccineIsTaken int not null,
  $_columnDateTaken text )
''');
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<ChildModel> insert(Child child) async {
    var id = await db.insert(_tableChildren, child.toMap());
    List<VaccineModel> vacs = [];
    for (var vac in vaccines) {
      var v = Vaccine(
          vaccineId: vac.vaccineId,
          daysPeriodBeforeNotification: vac.daysPeriodBeforeNotification,
          weekToBeTaken: vac.weekToBeTaken,
          childId: id,
          isTaken: false,
          dateTaken: null,
          vaccineName: vac.name);

      await db.insert(_tableVaccine, v.toMap());
    }
    var vs = await _getVaccines(id);
    for (var v in vs) {
      vacs.add(VaccineModel(
          childId: id,
          daysPeriodBeforeNotification: v.daysPeriodBeforeNotification,
          vaccineId: v.vaccineId,
          weekToBeTaken: v.weekToBeTaken,
          isTaken: v.isTaken,
          vaccineName: v.vaccineName));
    }

    var date = DateTime.tryParse(child.dob!);
    return ChildModel(
      id: id,
      dob: date!,
      name: child.name!,
      gender: child.gender!,
      vaccines: vacs,
    );
  }

  Future<ChildModel?> getChild(int id) async {
    List<VaccineModel> vacs = [];
    List<Map> maps = await db.query(_tableChildren,
        columns: [_columnChildId, _columnName, _columnDob, _columnGender],
        where: '$_columnChildId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      var first = maps.first as Map<String, Object?>;
      var child = Child.fromMap(first);
      var vs = await getVaccines(child.id!);
      for (var v in vs) {
        vacs.add(
          VaccineModel(
            childId: id,
            daysPeriodBeforeNotification: v.daysPeriodBeforeNotification,
            vaccineId: v.vaccineId,
            weekToBeTaken: v.weekToBeTaken,
            isTaken: v.isTaken,
            vaccineName: v.vaccineName,
          ),
        );
      }
      var date = DateTime.tryParse(child.dob!);
      return ChildModel(
        id: child.id!,
        dob: date!,
        name: child.name!,
        gender: child.gender!,
        vaccines: vacs,
      );
    }
    return null;
  }

  Future<List<ChildModel>> getChildren() async {
    List<ChildModel> children = [];
    List<Map> maps = await db.query(
      _tableChildren,
      columns: [_columnChildId, _columnName, _columnDob, _columnGender],
    );
    for (var map in maps) {
      List<VaccineModel> vacs = [];
      var m = map as Map<String, Object?>;
      var child = Child.fromMap(m);
      var vs = await _getVaccines(child.id!);
      for (var v in vs) {
        vacs.add(VaccineModel(
            daysPeriodBeforeNotification: v.daysPeriodBeforeNotification,
            vaccineId: v.vaccineId,
            childId: v.childId,
            weekToBeTaken: v.weekToBeTaken,
            isTaken: v.isTaken,
            vaccineName: v.vaccineName));
      }
      var date = DateTime.tryParse(child.dob!);
      var ch = ChildModel(
        id: child.id!,
        dob: date!,
        name: child.name!,
        gender: child.gender!,
        vaccines: vacs,
      );
      children.add(ch);
    }
    return children;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(_tableChildren, where: '$_columnChildId = ?', whereArgs: [id]);
  }

  Future<int> update(Child child) async {
    return await db.update(_tableChildren, child.toMap(),
        where: '$_columnChildId = ?', whereArgs: [child.id]);
  }

  Future<List<VaccineModel>> getVaccines(int childId) async {
    List<VaccineModel> vacs = [];
    var vs = await _getVaccines(childId);
    for (var v in vs) {
      vacs.add(VaccineModel(
          daysPeriodBeforeNotification: v.daysPeriodBeforeNotification,
          vaccineId: v.vaccineId,
          childId: v.childId,
          weekToBeTaken: v.weekToBeTaken,
          isTaken: v.isTaken,
          vaccineName: v.vaccineName));
    }
    return vacs;
  }

  Future<List<Vaccine>> _getVaccines(int childId) async {
    List<Vaccine> vacs = [];
    List<Map> maps = await db.query(_tableVaccine,
        columns: [
          _columnChildId,
          _columnVaccineId,
          _columnDaysPeriodBeforeNotification,
          _columnVaccineName,
          _columnVaccineIsTaken,
          _columnDateTaken,
          _columnWeekToBeTaken
        ],
        where: '$_columnChildId = ?',
        whereArgs: [childId]);

    if (maps.isNotEmpty) {
      for (var map in maps) {
        var m = map as Map<String, Object?>;
        var vac = Vaccine.fromMap(m);
        vacs.add(vac);
      }
    }
    return vacs;
  }

  Future<bool> updateVaccine(VaccineModel vaccine) async {
    var isT = vaccine.isTaken! ? 0 : 1;
    try {
      int count = await db.rawUpdate(
          'UPDATE $_tableVaccine SET $_columnVaccineIsTaken = ?, $_columnDateTaken = ? WHERE $_columnVaccineId = ? and $_columnChildId = ?',
          [
            isT,
            vaccine.dateTaken.toString(),
            vaccine.vaccineId,
            vaccine.childId
          ]);

      print("updating $count record");

      return true;
      if (count > 0) {
        return Future.value(true);
      }
    } catch (e) {
      print("errrrrrrrrr");
      print(e);
    }

    return false;
  }

  Future close() async => db.close();
}
