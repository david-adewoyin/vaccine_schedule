import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_scheduler/screens/home.dart';
import 'package:vaccine_scheduler/styles.dart';

class RegisterChildPage extends StatelessWidget {
  const RegisterChildPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Image.asset("assets/images/registration_1.png"),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Register Child",
              style: TextStyles.h5.copyWith(letterSpacing: 1.5),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              /*  mainAxisSize: MainAxisSize.min, */
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Icon(
                      Icons.child_care,
                      color: Colors.blueGrey,
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        isCollapsed: false,
                        isDense: false,
                        contentPadding: EdgeInsets.only(left: 20),
                        filled: false,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: "Enter child's fullname",
                        hintStyle: TextStyles.body,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
                /*  Text(
                  "Enter Child name",
                  style: TextStyles.body.copyWith(color: Color(0xFF4D4D4D)),
                ), */
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.blueGrey,
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DateTimeFormField(
                    mode: DateTimeFieldPickerMode.date,
                    decoration: InputDecoration(
                      isCollapsed: false,
                      isDense: false,
                      contentPadding: EdgeInsets.only(left: 20),
                      filled: false,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: "Select Child date of birth",
                      hintStyle: TextStyles.body,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 0.3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Icon(
                      Icons.baby_changing_station,
                      color: Colors.blueGrey,
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        isCollapsed: false,
                        isDense: false,
                        contentPadding: EdgeInsets.only(left: 20),
                        filled: false,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: "Select Gender",
                        hintStyle: TextStyles.body,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          child: Text("boy"),
                          value: "boy",
                        ),
                        DropdownMenuItem(
                          child: Text("girl"),
                          value: "girl",
                        )
                      ],
                      onChanged: (value) {}),
                ),
              ],
            ),

            /*  */ /*    Expanded(
              child: Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    isCollapsed: false,
                    isDense: false,
                    contentPadding: EdgeInsets.only(left: 20),
                    filled: false,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: "Enter child's fullname",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 0.3),
                    ),
                  ),
                ),
              ),
            ),
        */
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.maybeOf(context)!.push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Submit",
                        style: TextStyles.h6,
                      ),
                      Icon(Icons.navigate_next_rounded)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
