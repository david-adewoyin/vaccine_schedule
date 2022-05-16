import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vaccine_scheduler/models/child_model.dart';
import 'package:vaccine_scheduler/models/vaccine_model.dart';
import 'package:vaccine_scheduler/services/offline.dart';

const _isFreshInstall = "isFreshInstall";

class AppService {
  late SharedPreferences prefs;
  late DbProvider db;
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

    db = DbProvider();
    await db.initDb();
  }

  bool isAppFreshInstall() {
    bool? isFresh = prefs.getBool(_isFreshInstall);
    if (isFresh == null) return true;
    return isFresh;
  }

  setUserOnboarded() async {
    try {
      await prefs.setBool(_isFreshInstall, false);
      print("setting is fresh install as false");
    } catch (e) {
      print("unable to set fresh install");
    }
  }

  Future<bool> ChangeVaccineTakenState(VaccineModel vaccine) {
    return db.updateVaccine(vaccine);
  }

  Future<ChildModel> registerChild(
      String name, DateTime dob, String gender) async {
    var child = Child(name: name, dob: dob.toString(), gender: gender);
    return await db.insert(child);
  }

  Future<ChildModel> getInitialChild() async {
    var c = await db.getChildren();
    return c!;
  }
}
