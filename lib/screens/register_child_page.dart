import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_scheduler/commands/bootstrap_command.dart';
import 'package:vaccine_scheduler/screens/landing_page.dart';
import 'package:vaccine_scheduler/styles.dart';

class RegisterChildPage extends StatefulWidget {
  const RegisterChildPage({Key? key}) : super(key: key);

  @override
  State<RegisterChildPage> createState() => _RegisterChildPageState();
}

class _RegisterChildPageState extends State<RegisterChildPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _dateFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  late DateTime date;
  late String? gender;

  @override
  void dispose() {
    _dateFocus.dispose();
    _nameFocus.dispose();
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Image.asset(
                    "assets/images/logo.png",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Register Child",
                  style: TextStyles.h5.copyWith(letterSpacing: 1.5),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  /*  mainAxisSize: MainAxisSize.min, */
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Icon(
                          Icons.child_care,
                          color: Colors.blueGrey,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null) {
                            return "enter a name";
                          }

                          if (value.length < 3) {
                            return "length of name must be greater than 3";
                          }
                        },
                        controller: _nameController,
                        focusNode: _nameFocus,
                        decoration: InputDecoration(
                          isCollapsed: false,
                          isDense: false,
                          contentPadding: const EdgeInsets.only(left: 20),
                          filled: false,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: "Enter child's full name",
                          hintStyle: TextStyles.body,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          color: Colors.blueGrey,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DateTimeFormField(
                        lastDate: DateTime.now(),
                        validator: (value) {
                          if (value == null) {
                            return "select a date";
                          }
                        },
                        onDateSelected: (value) {
                          setState(() {
                            date = value;
                          });
                        },
                        mode: DateTimeFieldPickerMode.date,
                        decoration: InputDecoration(
                          isCollapsed: false,
                          isDense: false,
                          contentPadding: const EdgeInsets.only(left: 20),
                          filled: false,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: "Select Child date of birth",
                          hintStyle: TextStyles.body,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 0.3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Icon(
                          Icons.baby_changing_station,
                          color: Colors.blueGrey,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return "select a gender";
                          }
                        },
                        decoration: InputDecoration(
                          isCollapsed: false,
                          isDense: false,
                          contentPadding: const EdgeInsets.only(left: 20),
                          filled: false,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: "Select Gender",
                          hintStyle: TextStyles.body,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "male",
                            child: Text("boy"),
                          ),
                          DropdownMenuItem(
                            value: "female",
                            child: Text("girl"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          print("errrrrrrrrrrrr");
                          return;
                        }
                        var name = _nameController.value.text;

                        await RegisterChildCommand()
                            .run(name: name, gender: gender!, dob: date);

                        Navigator.maybeOf(context)!.pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Submit",
                            style: TextStyles.h6,
                          ),
                          const Icon(Icons.navigate_next_rounded)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
