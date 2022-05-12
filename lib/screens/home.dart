import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vaccine_scheduler/styles.dart';

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
            Container(),
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

class HomeTabWidget extends StatelessWidget {
  const HomeTabWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xfafafa),
        margin: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: [
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.red.withOpacity(0.2)),
                    child: Icon(
                      Icons.person,
                      size: 42,
                      color: Colors.redAccent.shade400,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Eno Abang",
                        style: TextStyles.subtitleSm,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "25 days",
                        style: TextStyles.body.withColor(Colors.grey.shade600),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            VaccineScheduleItem(
              index: 1,
            ),
            VaccineScheduleItem(
              index: 2,
            ),
            VaccineScheduleItem(
              index: 3,
            ),
            VaccineScheduleItem(
              index: 4,
            ), VaccineScheduleItem(
              index: 5,
            ),

          ],
        ),
      ),
    );
  }
}

class VaccineScheduleItem extends StatelessWidget {
  final colors = [
    Colors.brown.shade100.withOpacity(0.5),
    Colors.deepOrangeAccent.withOpacity(0.2),
    Colors.pink.withOpacity(0.2),
    Colors.purpleAccent.withOpacity(0.2),
    Colors.orangeAccent.withOpacity(0.2),
    Colors.blueAccent.withOpacity(0.2),

  ];
  final int index;
  VaccineScheduleItem({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      color: colors[index],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.redAccent.withOpacity(0.2),width: 2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 40,
              child: Container(
                child: Text(
                  "At Birth",
                  textAlign: TextAlign.center,
                  style: TextStyles.bodySm.withColor(Colors.black).bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
               Text(
                      "Given on 11 march 2020",
                      style: TextStyles.subtitleSm
                          .withSize(18)
                          .withColor(Colors.grey.shade700),

                  )
                ],
              ),
              SizedBox(height:10),
              ItemWidget(),
              ItemWidget(),
              ItemWidget(),
              ItemWidget(),

            ],
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_outlined,size: 20,color: Colors.grey.shade800,),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Container(
            child: InkWell(
             child: Icon(Icons.check_box,color: Colors.red.withOpacity(0.8),),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "Rotovirus",
            style: TextStyles.body.withSize(16),
          ),
        ],
      ),
    );
  }
}
