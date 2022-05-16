import 'package:flutter/cupertino.dart';
import 'package:vaccine_scheduler/models/child_model.dart';

class AppModel extends ChangeNotifier {
  late bool _isFreshInstall;
  final List<ChildModel> _children = [];

  setChildren(List<ChildModel> children) {
    _children.clear();
    _children.addAll(children);
    notifyListeners();
  }

  addChild(ChildModel child) {
    _children.add(child);
    notifyListeners();
  }

  removeChild(String id) {
    _children.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  ChildModel? getChild(String id) {
    return _children.where((element) => element.id == id).first;
  }

  List<ChildModel> getChildren() {
    return _children;
  }

  bool isFreshInstall() {
    return _isFreshInstall;
  }

  setIsFreshInstall(bool fresh) {
    print(" i am here");
    _isFreshInstall = fresh;
    notifyListeners();
  }
}
