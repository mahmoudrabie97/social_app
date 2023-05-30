import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialapp/components.dart';
import 'package:socialapp/cubit/registecubit/cubit.dart';
import 'package:socialapp/cubit/registecubit/states.dart';
import 'package:socialapp/screens/homescreen.dart';
import 'package:socialapp/screens/socialloginscreen.dart';
import 'package:socialapp/screens/welcome/components/rounded_boutton.dart';
import 'package:socialapp/widgets/reusable_text_formfield.dart';

import '../constants.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (BuildContext context, state) {
          if (state is CreateUserSucessfulState) {
            navigationremove(context, const HomeScreen());
          }
        },
        builder: (BuildContext context, Object? state) {
          return Container(
            height: size.height,
            width: double.infinity,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      'images/signup_top.png',
                      width: size.width * .35,
                    )),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      'images/main_bottom.png',
                      width: size.width * .25,
                    )),
                SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'SignUp',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SvgPicture.asset(
                          'icons/signup.svg',
                          height: size.height * .25,
                        ),
                        TextformfieldContainer(
                          child: Resubletextformfield(
                              controller: namecontroller,
                              hinttex: 'name',
                              icon: Icons.person,
                              onchanged: (value) {},
                              onvalidate: (text) {
                                if (text!.isEmpty) {
                                  return 'name must not be empty';
                                } else {
                                  return null;
                                }
                              },
                              securetext: false),
                        ),
                        TextformfieldContainer(
                          child: Resubletextformfield(
                              controller: emailcontroller,
                              hinttex: 'Email',
                              icon: Icons.email,
                              onchanged: (value) {},
                              onvalidate: (text) {
                                if (text!.isEmpty) {
                                  return 'Email must not be empty';
                                } else {
                                  return null;
                                }
                              },
                              securetext: false),
                        ),
                        TextformfieldContainer(
                          child: Resubletextformfield(
                            controller: passwordcontroller,
                            hinttex: 'Password',
                            icon: Icons.lock,
                            onchanged: (value) {},
                            onvalidate: (text) {
                              if (text!.isEmpty) {
                                return 'password must not empty';
                              } else {
                                return null;
                              }
                            },
                            securetext: false,
                            suffixicon: Icons.visibility,
                            suffixpress: () {},
                          ),
                        ),
                        TextformfieldContainer(
                          child: Resubletextformfield(
                              controller: phonecontroller,
                              hinttex: 'phone',
                              icon: Icons.phone,
                              onchanged: (value) {},
                              onvalidate: (text) {
                                if (text!.isEmpty) {
                                  return 'phone  must not be empty';
                                } else {
                                  return null;
                                }
                              },
                              securetext: false),
                        ),
                        state is RegisterLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ))
                            : RoundedBoutton(
                                text: 'REGISTER',
                                press: () {
                                  if (formkey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        name: namecontroller.text,
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text,
                                        phone: phonecontroller.text);
                                  }
                                }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'don you have an account ?',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SocialloginScren()));
                              },
                              child: const Text(
                                'Sign in',
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
