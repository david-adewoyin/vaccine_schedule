import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_scheduler/models/app_models.dart';
import 'package:vaccine_scheduler/models/vaccine_model.dart';
import 'package:vaccine_scheduler/screens/Info_tab.dart';
import 'package:vaccine_scheduler/styles.dart';

import 'home_tab.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/landing_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  bool showAppBar = true;
  late TabController _controller;
  var _currentIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    _controller.animateTo(_currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          HomeTabWidget(),
          InfoTabWidget(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        color: Colors.redAccent.withOpacity(0.05),
        padding: EdgeInsets.symmetric(vertical: 5),
        child: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Color(0x66000000),
          selectedLabelStyle: TextStyles.bodySm.sizeMinus.withSize(11).bold,
          unselectedLabelStyle: TextStyles.bodySm.sizeMinus.withSize(11).bold,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          showUnselectedLabels: true,
          elevation: 0,
          onTap: (value) {
            if (value == 3) {
              setState(() {
                showAppBar = false;
              });
            } else {
              setState(() {
                showAppBar = true;
              });
            }
            setState(() {
              _currentIndex = value;
              _controller.animateTo(
                value,
                duration: Duration(milliseconds: 10),
              );
            });
          },
          items: [
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.home),
                icon: Icon(Icons.home_rounded),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.info_rounded), label: "Information"),
          ],
        ),
      ),
    );
  }
}
