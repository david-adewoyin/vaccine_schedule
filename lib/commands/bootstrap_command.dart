import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_scheduler/models/app_models.dart';
import 'package:vaccine_scheduler/models/child_model.dart';
import 'package:vaccine_scheduler/models/vaccine_model.dart';
import 'package:vaccine_scheduler/services/app_service.dart';

BuildContext? _mainContext;
BuildContext get mainContext => _mainContext!;
bool get hasContext => _mainContext != null;
// ignore: non_constant_identifier_names
bool _app_is_bootstrapped = false;
void setContext(BuildContext context) {
  _mainContext = context;
}

class BaseAppCommand {
  AppService get appService => getProvided();
  AppModel get appModel => getProvided();

  T getProvided<T>() {
    assert(_mainContext != null,
        "You must call set context(buildcontext before call commands");
    return _mainContext!.read<T>();
  }
}

class BootstrapCommand extends BaseAppCommand {
  static done() {
    return _app_is_bootstrapped;
  }

  Future<void> run(BuildContext context) async {
    if (hasContext == false) {
      setContext(context);
    }
    await appService.init();
    print(" is app fresh ${appService.isAppFreshInstall()}");
    bool fresh = appService.isAppFreshInstall();
    appModel.setIsFreshInstall(fresh);

    if (!appModel.isFreshInstall()) {
      print("here ......");

      var children = await appService.getInitialChildren();
      appModel.setChildren(children);
    }
    _app_is_bootstrapped = true;
  }
}

class RegisterChildCommand extends BaseAppCommand {
  run(
      {required String name,
      required DateTime dob,
      required String gender}) async {
    var child = await appService.registerChild(name, dob, gender);
    appModel.addChild(child);
    appService.setUserOnboarded();
  }
}

class RegisterNewChildCommand extends BaseAppCommand {
  Future<ChildModel> run(
      {required String name,
      required DateTime dob,
      required String gender}) async {
    var child = await appService.registerChild(name, dob, gender);
    appModel.addChild(child);
    return child;
  }
}

class ChangeVaccineTakenStateCommand extends BaseAppCommand {
  Future<bool> run(VaccineModel vaccine) async {
    return await appService.ChangeVaccineTakenState(vaccine);
  }
}
