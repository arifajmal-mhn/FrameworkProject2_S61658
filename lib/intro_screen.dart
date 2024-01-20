import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:project2_test3/screens/login_screen.dart';
// import 'screens/dashboard_screen.dart';

class IntroScreen extends StatelessWidget {
  final introKey = GlobalKey<IntroductionScreenState>();

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        title: "Welcome to SwiftSpot",
        body:
            "Experience the convenience of our Smart Parking App. Effortlessly manage your parking needs, find available lots, and streamline your parking experience.",
        image: Image.asset(
          "images/drawkit-transport-scene-1.png",
          width: 300,
        ),
        decoration: const PageDecoration(
            pageColor: Color(0xFFeeeeee),
            bodyTextStyle: TextStyle(fontSize: 16)),
      ),
      PageViewModel(
        title: "Real-Time Availability Updates",
        body:
            "Stay informed with real-time updates on parking lot availability. Our app keeps you in the loop, ensuring you find a spot quickly and efficiently.",
        image: Image.asset(
          "images/drawkit-transport-scene-2.png",
          width: 300,
        ),
        decoration: const PageDecoration(
            pageColor: Color(0xFFeeeeee),
            bodyTextStyle: TextStyle(fontSize: 16)),
      ),
      PageViewModel(
        title: "User-Friendly Navigation",
        body:
            "Navigate through our app with ease. The user-friendly interface ensures a seamless experience, allowing you to find, book, and manage parking effortlessly.",
        image: Image.asset(
          "images/drawkit-transport-scene-3.png",
          width: 300,
        ),
        decoration: const PageDecoration(
            pageColor: Color(0xFFeeeeee),
            bodyTextStyle: TextStyle(fontSize: 16)),
      ),
      // Add more PageViewModels as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: getPages(),
      onDone: () {
        // Navigate to your main dashboard screen when introduction is done
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
      onSkip: () {
        // You can handle skipping if needed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done"),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.orange,
        activeColor: Colors.orange,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
