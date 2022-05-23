import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_scheduler/commands/bootstrap_command.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_scheduler/models/app_models.dart';
import 'package:vaccine_scheduler/models/child_model.dart';
import 'package:vaccine_scheduler/models/vaccine_model.dart';
import 'package:vaccine_scheduler/screens/add_new_child.dart';
import 'package:vaccine_scheduler/screens/register_child_page.dart';
import 'package:vaccine_scheduler/services/offline.dart';
import 'package:vaccine_scheduler/styles.dart';

class HomeTabWidget extends StatelessWidget {
  const HomeTabWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var c = context.watch<AppModel>();
    var children = c.getChildren();
    return SafeArea(
      child: Container(
        color: const Color(0x00fafafa),
        margin: const EdgeInsets.only(bottom: 20),
        child: BuildWidget(
          childrenModels: children,
        ),
      ),
    );
  }
}

class BuildWidget extends StatefulWidget {
  final List<ChildModel> childrenModels;
  const BuildWidget({Key? key, required this.childrenModels}) : super(key: key);

  @override
  State<BuildWidget> createState() => _BuildWidgetState();
}

class _BuildWidgetState extends State<BuildWidget> {
  List<DropdownMenuItem<ChildModel>> buildChildModelWidget(
      List<ChildModel> children) {
    List<DropdownMenuItem<ChildModel>> dropdownMenuItems = [];
    for (var child in children) {
      var dob = DateFormat.yMMMMd().format(child.dob);
      var item = DropdownMenuItem(
        value: child,
        child: Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red.withOpacity(0.2)),
                child: SvgPicture.asset(
                  child.gender == "male" || child.gender == "boy"
                      ? "assets/images/boy.svg"
                      : "assets/images/girl.svg",
                  height: 40,
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    child.name,
                    style: TextStyles.subtitleSm,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "DOB: $dob",
                    style: TextStyles.body.withColor(Colors.grey.shade600),
                  ),
                ],
              )
            ],
          ),
        ),
      );
      dropdownMenuItems.add(item);
    }
    return dropdownMenuItems;
  }

  late ChildModel _selectedChild = widget.childrenModels.first;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 25),
        Row(
          children: [
            SizedBox(width: 10),
            Expanded(
              child: DropdownButton<ChildModel>(
                items: buildChildModelWidget(widget.childrenModels),
                icon: Container(
                  padding: const EdgeInsets.only(left: 40),
                  child: const Icon(Icons.arrow_drop_down),
                ),
                value: _selectedChild,
                itemHeight: 60,
                iconSize: 32,
                alignment: Alignment.topLeft,
                underline: Container(),
                onChanged: (child) {
                  setState(() {
                    _selectedChild = child!;
                  });
                },
              ),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: () async {
                ChildModel child = await showModalBottomSheet(
                    constraints:
                        const BoxConstraints(maxHeight: 470, minHeight: 400),
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return const AddNewChildPage();
                    });
                setState(() {
                  _selectedChild = child;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red.withOpacity(0.2)),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: const Icon(
                  Icons.add,
                  color: Colors.red,
                  size: 26,
                ),
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        const SizedBox(height: 30),
        ChildVaccines(child: _selectedChild),
      ],
    );
  }
}

class ChildVaccines extends StatelessWidget {
  final ChildModel child;
  ChildVaccines({Key? key, required this.child}) : super(key: key);

  List<VaccineModel> week0 = [];
  List<VaccineModel> week6 = [];
  List<VaccineModel> week10 = [];
  List<VaccineModel> week14 = [];
  List<VaccineModel> week26 = [];
  List<VaccineModel> week39 = [];
  List<VaccineModel> week65 = [];
  buildVaccineScheduleItem(List<VaccineModel> vaccs) {
    week0.clear();
    week6.clear();
    week10.clear();
    week14.clear();
    week26.clear();
    week39.clear();
    week65.clear();
    for (var v in vaccs) {
      switch (v.weekToBeTaken) {
        case 0:
          week0.add(v);
          break;
        case 6:
          week6.add(v);
          break;
        case 10:
          week10.add(v);
          break;
        case 14:
          week14.add(v);
          break;
        case 26:
          week26.add(v);
          break;
        case 39:
          week39.add(v);
          break;
        case 65:
          week65.add(v);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    buildVaccineScheduleItem(child.vaccines);
    return Column(
      children: [
        VaccineScheduleItem(index: 1, vaccines: week0),
        VaccineScheduleItem(index: 2, vaccines: week6),
        VaccineScheduleItem(index: 3, vaccines: week10),
        VaccineScheduleItem(index: 4, vaccines: week14),
        VaccineScheduleItem(index: 5, vaccines: week26),
        VaccineScheduleItem(index: 1, vaccines: week39),
        VaccineScheduleItem(index: 2, vaccines: week65),
      ],
    );
  }
}

class VaccineScheduleItem extends StatefulWidget {
  List<VaccineModel> vaccines;

  final int index;

  VaccineScheduleItem({
    required this.index,
    required this.vaccines,
    Key? key,
  }) : super(key: key);

  @override
  State<VaccineScheduleItem> createState() => _VaccineScheduleItemState();
}

class _VaccineScheduleItemState extends State<VaccineScheduleItem> {
  ValueNotifier<double> isChangedNotifier = ValueNotifier(0.2);
  final colors = [
    Colors.deepOrangeAccent.withOpacity(0.2),
    Colors.orangeAccent.withOpacity(0.2),
    Colors.brown.shade100.withOpacity(0.5),
    Colors.pink.withOpacity(0.2),
    Colors.purpleAccent.withOpacity(0.2),
    Colors.blueAccent.withOpacity(0.2),
  ];
  @override
  void dispose() {
    isChangedNotifier.dispose();
    super.dispose();
  }

  bool? is_completed;

  Widget vaccs_is_completed() {
    var isCompleted =
        widget.vaccines.where((element) => element.isTaken == false).isEmpty;
    if (isCompleted) {
      return Row(
        children: [
          Icon(
            Icons.sunny,
            color: Colors.deepOrangeAccent.withOpacity(0.6),
            size: 22,
          ),
          const SizedBox(width: 5),
          Text(
            "Vaccines completed",
            style: TextStyles.subtitleSm
                .withSize(19)
                .withColor(Colors.grey.shade800),
          )
        ],
      );
    }
    return Container();
  }

  String buildTagline() {
    var week = widget.vaccines.first.weekToBeTaken;
    switch (week) {
      case 0:
        return "At Birth";
      case 6:
        return "6 Weeks";
      case 10:
        return "10 Weeks";
      case 14:
        return "14 Weeks";
      case 26:
        return "6 months";
      case 39:
        return "9 months";
      case 65:
        return "15 months";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: colors[widget.index],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.redAccent.withOpacity(0.2), width: 2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 38,
              child: Text(
                buildTagline(),
                textAlign: TextAlign.center,
                style: TextStyles.bodySm.withColor(Colors.black).bold.sizeMinus,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder<double>(
                  valueListenable: isChangedNotifier,
                  builder: (context, value, __) {
                    return vaccs_is_completed();
                  }),
              const SizedBox(height: 15),
              for (var vac in widget.vaccines) ...[
                ItemWidget(vaccine: vac, notifier: isChangedNotifier),
              ],
            ],
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 20,
            color: Colors.grey.shade800,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class ItemWidget extends StatefulWidget {
  final VaccineModel vaccine;
  final ValueNotifier<double> notifier;

  const ItemWidget({
    required this.notifier,
    required this.vaccine,
    Key? key,
  }) : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async {
              widget.notifier.value = Random().nextDouble();
              setState(() {
                widget.vaccine.isTaken = !(widget.vaccine.isTaken!);
              });
              bool done =
                  await ChangeVaccineTakenStateCommand().run(widget.vaccine);
              if (!done) {
                ScaffoldMessenger.maybeOf(context)!.showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    content: Container(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Unable to set value",
                            style: TextStyles.body,
                          ),
                        ],
                      ),
                    )));
                setState(() {
                  widget.vaccine.isTaken = !(widget.vaccine.isTaken!);
                });
              }
            },
            child: Icon(
              widget.vaccine.isTaken!
                  ? Icons.check_box
                  : Icons.check_box_outline_blank_rounded,
              color: Colors.red.withOpacity(0.8),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            width: 250,
            child: Text(
              widget.vaccine.vaccineName!,
              style: TextStyles.body.withSize(18),
            ),
          ),
        ],
      ),
    );
  }
}
