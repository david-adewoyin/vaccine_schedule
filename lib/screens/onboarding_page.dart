import 'package:flutter/material.dart';

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
      'assets/images/page_1.png',
    ];
    var carouselHeadings = ["desc"];

    var carouselBody = ["body"];

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
              itemBuilder: (context, value) => builder(value)),
          Positioned(
            bottom: 80,
            child: Row(
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
    return SizedBox(
        height: 500,
        child: Column(
          children: [
            SizedBox(
              height: 500,
              child: Padding(
                  padding: const EdgeInsets.only(top: 120, bottom: 30),
                  child: Image.asset(image)),
            ),
            Text(heading),
            const SizedBox(height: 50),
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
