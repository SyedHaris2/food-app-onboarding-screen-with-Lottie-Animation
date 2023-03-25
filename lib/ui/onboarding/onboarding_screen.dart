import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomPaint(
            painter: CustomCode(),
            child: SizedBox(
              height: screenSize.height / 1.4,
              width: screenSize.width,
            ),
          ),
          Positioned(
            top: 60,
            left: 5,
            right: 5,
            child: Lottie.asset(tabs[_currentIndex].lottieFile,
                width: 600,
                alignment: Alignment.topCenter,
                key: Key(Random().nextInt(999999999).toString())),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 250,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: tabs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(
                              tabs[index].title,
                              style: const TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              tabs[index].subtitle,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            )
                          ],
                        );
                      },
                      onPageChanged: (value) {
                        _currentIndex = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < tabs.length; i++)
                        _DotIndicator(isSelected: i == _currentIndex)
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          child: const Icon(CupertinoIcons.chevron_right),
          onPressed: () {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.bounceOut);
          }),
    );
  }
}

class CustomCode extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path orangeArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 170)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 170)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(orangeArc, Paint()..color = Colors.red);

    Path whiteArc = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(0.0, size.height - 185)
      ..quadraticBezierTo(
          size.width / 2, size.height - 70, size.width, size.height - 185)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(whiteArc, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _DotIndicator extends StatelessWidget {
  final bool isSelected;

  const _DotIndicator({Key? key, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 6.0,
        width: 6.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.white : Colors.white38,
        ),
      ),
    );
  }
}

class DataModel {
  final String lottieFile;
  final String title;
  final String subtitle;

  DataModel(this.lottieFile, this.title, this.subtitle);
}

List<DataModel> tabs = [
  DataModel(
    //bike
    'assets/beverag.json',
    'Choose A Best Food',

    'When you order Eat Street \nwe\'ll hook you up with exclusive \ncoupons.',
  ),
  DataModel(
      //places
      'assets/food.json',
      'Order Your Food',
      'Order food and get it at the fastest \n time Possible'
      // 'We make it simple to find the \nfood you crave. Enter your \naddress and let',
      //'Discover Places',
      ),
  DataModel(
      'assets/interaction.json',
      //'Pick Up Or',
      'Delivered to Your Doorstep',
      //'We make food ordering fast ,\n simple and free - no matter if you \norder',
      'Order food and get it at the fastest\n time Possible '),
];
