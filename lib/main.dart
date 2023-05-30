import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socialapp/cubit/socialapp/cubit.dart';
import 'package:socialapp/cubit/socialapp/states.dart';
import 'package:socialapp/network/cachehelper.dart';
import 'package:socialapp/screens/homescreen.dart';
import 'package:socialapp/screens/onboardingscreen.dart';
import 'package:socialapp/screens/welcome/welcomescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Cachehelper.init();
  uId = Cachehelper.getdata(key: 'uId');
  Widget widget;
  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = const WelcomeScreen();
  }

  runApp(MyApp(
    startwidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.startwidget}) : super(key: key);
  final Widget startwidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Sociacubit()
        ..getUserData()
        ..getPosts()
        ..getusers(),
      child: BlocConsumer<Sociacubit, SocialStaes>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            title: 'Flutter Auth',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              primaryColor: kPrimaryColor,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                  elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
            ),
            home: startwidget,
          );
        },
      ),
    );
  }
}
