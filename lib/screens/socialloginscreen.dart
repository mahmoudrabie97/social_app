import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialapp/components.dart';
import 'package:socialapp/cubit/logincubit/cubit.dart';
import 'package:socialapp/cubit/logincubit/states.dart';
import 'package:socialapp/network/cachehelper.dart';
import 'package:socialapp/screens/homescreen.dart';
import 'package:socialapp/screens/registerscreen.dart';
import 'package:socialapp/screens/welcome/components/rounded_boutton.dart';
import 'package:socialapp/widgets/reusable_text_formfield.dart';

import '../constants.dart';

class SocialloginScren extends StatelessWidget {
  SocialloginScren({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
          if (state is LoginErrorState) {
            showtoat(msg: state.error, state: Toaststate.error);
          }
          if (state is LoginSucsesfulState) {
            Cachehelper.savedata(key: 'uId', value: state.uid).then((value) {
              navigationremove(context, const HomeScreen());
            });
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            body: Body(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      SvgPicture.asset(
                        'icons/login.svg',
                        height: size.height * .35,
                      ),
                      TextformfieldContainer(
                          child: Resubletextformfield(
                        controller: emailcontroller,
                        securetext: false,
                        hinttex: 'Your Email',
                        icon: Icons.person,
                        onchanged: (value) {},
                        onvalidate: (text) {
                          if (text!.isEmpty) {
                            return 'email must be not empty';
                          } else {
                            return null;
                          }
                        },
                      )),
                      TextformfieldContainer(
                          child: Resubletextformfield(
                              controller: passwordcontroller,
                              securetext: LoginCubit.get(context).securedpass,
                              suffixicon: LoginCubit.get(context).suffixicon,
                              suffixpress: () {
                                LoginCubit.get(context).changepassState();
                              },
                              hinttex: 'Password',
                              icon: Icons.lock,
                              onchanged: (value) {},
                              onvalidate: (text) {
                                if (text!.isEmpty) {
                                  return 'password must be not empty';
                                } else {
                                  return null;
                                }
                              })),
                      state is LoginLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ))
                          : RoundedBoutton(
                              text: 'LOGIN',
                              press: () {
                                if (formkey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text);
                                }
                              }),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'dont have an account ?',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'images/main_top.png',
              width: size.width * .35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'images/main_bottom.png',
              width: size.width * .4,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
