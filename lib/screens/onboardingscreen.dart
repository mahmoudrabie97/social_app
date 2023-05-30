import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:socialapp/components.dart';
import 'package:socialapp/screens/socialloginscreen.dart';

class Onbaardingscren extends StatelessWidget {
  Onbaardingscren({Key? key}) : super(key: key);
  List<PageViewModel> pages = [
    PageViewModel(
      title: 'Update your Status ',
      body: 'you can share your status with your friends now ',
      image: Center(
        child: Image.asset(
          'images/social1.jpg',
          width: 350,
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle:
            const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: const TextStyle(fontSize: 20),
        descriptionPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: const EdgeInsets.all(24),
      ),
    ),
    PageViewModel(
      title: 'React friends posts ',
      body: 'react with your frientd posts and comment to posts ',
      // be trend shere your skill to be atrend
      image: Center(
        child: Image.asset(
          'images/social4.jpg',
          width: 350,
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle:
            const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: const TextStyle(fontSize: 20),
        descriptionPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: const EdgeInsets.all(24),
      ),
    ),
    PageViewModel(
      title: 'Connect your friends ',
      body: 'you will enjoy chatting with friend ',
      image: Center(
        child: Image.asset(
          'images/social3.jpg',
          width: 350,
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle:
            const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: const TextStyle(fontSize: 20),
        descriptionPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: const EdgeInsets.all(24),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        showNextButton: true,
        pages: pages,
        done: const Text(
          'Starting',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        onDone: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => SocialloginScren()));
        },
        showSkipButton: true,
        skip: const Text(
          'Skip',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onSkip: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => SocialloginScren())),
        next: const CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 20,
          child: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        skipFlex: 1,
        nextFlex: 1,
        dotsDecorator: DotsDecorator(
          color: Colors.blue,
          activeColor: Colors.orange,
          size: const Size(10, 10),
          activeSize: const Size(22, 10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        animationDuration: 1000,
        onChange: (index) {
          //  print('page $index selected');
        },
      ),
    );
  }
}
