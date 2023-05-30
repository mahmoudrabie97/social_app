import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialapp/constants.dart';
import 'package:socialapp/screens/registerscreen.dart';
import 'package:socialapp/screens/socialloginscreen.dart';
import 'package:socialapp/screens/welcome/components/background.dart';
import 'package:socialapp/screens/welcome/components/rounded_boutton.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Social App',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * .05,
            ),
            SvgPicture.asset(
              'icons/chat.svg',
              height: size.height * .45,
            ),
            SizedBox(
              height: size.height * .05,
            ),
            RoundedBoutton(
                text: 'LOGIN',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SocialloginScren()));
                }),
            RoundedBoutton(
              text: 'Register',
              press: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
              color: kPrimaryLightColor,
              textcolor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
