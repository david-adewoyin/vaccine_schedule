import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      'assets/images/mother.png',
      'assets/images/mother.png',
      'assets/images/mother.png',
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

              padding: EdgeInsets.only(bottom: 80,left: 50,right: 40),
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

                  ],),
                  Spacer(),
                  Column(mainAxisSize:MainAxisSize.min,children: [Row(children: [Text("Next",style: TextStyles.h6,),Icon(Icons.navigate_next_rounded)],)],)
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
              height: 100,
            ),
            Text(
              "Vaccine Scheduler",
              style: GoogleFonts.oleoScript(textStyle: TextStyles.h5),
            ),
            SizedBox(
              height: 300,
              child: Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 0),
                  child: Image.asset(image)),
            ),
            const SizedBox(height: 50),
            Text(
              heading,
              style: GoogleFonts.oleoScript(textStyle: TextStyles.h5),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                body,
                style: GoogleFonts.redHatDisplay(textStyle: TextStyles.h6),
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
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.pink : Colors.green[300],
      ),
    );
  }
}
