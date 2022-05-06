import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_scheduler/screens/register_child_page.dart';
import 'package:vaccine_scheduler/styles.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _controller =
      PageController(initialPage: 0, keepPage: false);
  final _currentPageNotifier = ValueNotifier<int>(0);

  builder(int index) {
    if (index > 2) return;

    var carouselImages = [
      'assets/images/grandma.png',
      'assets/images/calender.png',
      'assets/images/nurse_2.png',
    ];
    var carouselHeadings = [
      "Add Child Details",
      "Notification & Reminders",
      "Monitor Vaccine History",
    ];

    var carouselBody = [
      "Add child details and autogenerate recommended vaccine schedule",
      "Get notified when it's due to get your child vaccinated. Never miss a vaccine deadline again",
      "Monitor and see the vaccine history of your child"
    ];

    return BuildCarouselItem(
      key: UniqueKey(),
      image: carouselImages[index],
      heading: carouselHeadings[index],
      body: carouselBody[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: 3,
            onPageChanged: (value) {
              setState(() {
                _currentPageNotifier.value = value;
              });
            },
            itemBuilder: (context, value) => builder(value),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: 80, left: 40, right: 30),
              width: double.maxFinite,

              //      bottom: 80,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PageIndicator(
                            notifier: _currentPageNotifier,
                            index: 0,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          PageIndicator(
                            notifier: _currentPageNotifier,
                            index: 1,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          PageIndicator(
                            notifier: _currentPageNotifier,
                            index: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 0,
                        ),
                        onPressed: () {
                          if (_currentPageNotifier.value == 2) {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    RegisterChildPage(),
                              ),
                            );
                          } else {
                            setState(() {
                              _controller.animateToPage(
                                  _currentPageNotifier.value + 1,
                                  duration: Duration(milliseconds: 600),
                                  curve: Curves.easeIn);
                              /*      _controller.nextPage(
                                  duration: Duration(milliseconds: 600),
                                  curve: Curves.decelerate); */
                              _currentPageNotifier.value =
                                  _currentPageNotifier.value + 1;
                            });
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              (_currentPageNotifier.value == 2)
                                  ? "Get Started"
                                  : "Next",
                              style: TextStyles.h6,
                            ),
                            Icon(Icons.navigate_next_rounded)
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BuildCarouselItem extends StatelessWidget {
  final String image;
  final String heading;
  final String body;
  const BuildCarouselItem(
      {Key? key,
      required this.image,
      required this.heading,
      required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            /*  Text(
              "Vaccine Scheduler",
              style: GoogleFonts.poppins(textStyle: TextStyles.h5),
            ), */
            SizedBox(
              height: 300,
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 50, bottom: 0, left: 20, right: 20),
                  child: Image.asset(
                    image,
                    height: 250,
                    width: 300,
                  )),
            ),
            const SizedBox(height: 50),
            Text(
              heading,
              style: GoogleFonts.poppins(
                textStyle: TextStyles.h5,
                wordSpacing: 2,
                /*  color: Color(0xFF2A94F4), */
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                body,
                style: GoogleFonts.redHatDisplay(
                    color: Colors.blueGrey,
                    textStyle: TextStyles.h6,
                    wordSpacing: 2,
                    height: 1.55),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }
}

class PageIndicator extends StatefulWidget {
  final ValueNotifier notifier;
  final double index;
  PageIndicator({required this.index, required this.notifier});

  @override
  PageIndicatorState createState() => PageIndicatorState();
}

class PageIndicatorState extends State<PageIndicator> {
  @override
  Widget build(BuildContext context) {
    bool isActive = false;
    if (widget.index == widget.notifier.value) {
      isActive = true;
    }
    if (widget.index == widget.notifier.value) {
      return Container(
        width: 20,
        height: 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          shape: BoxShape.rectangle,
          color: Color(0xFF2A94F4),
        ),
      );
    } else {
      return Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueGrey,
        ),
      );
    }
  }
}
