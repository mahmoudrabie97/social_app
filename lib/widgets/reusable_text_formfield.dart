import 'package:flutter/material.dart';

import '../constants.dart';

//المفروض الكونينر الاول والزرار يكون طفل ليه
class Resubletextformfield extends StatelessWidget {
  Resubletextformfield({
    Key? key,
    required this.hinttex,
    required this.icon,
    required this.onchanged,
    this.suffixicon,
    this.suffixpress,
    required this.onvalidate,
    required this.securetext,
    required this.controller,
  }) : super(key: key);
  final String hinttex;
  final IconData icon;
  final ValueChanged<String> onchanged;
  String? Function(String? text)? onvalidate;
  final TextEditingController controller;

  IconData? suffixicon;
  final bool securetext;
  Function()? suffixpress;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hinttex,
        suffixIcon: IconButton(
            onPressed: suffixpress,
            icon: Icon(
              suffixicon,
              color: kPrimaryColor,
            )),
        icon: Icon(
          icon,
          color: kPrimaryColor,
        ),
        border: InputBorder.none,
      ),
      onChanged: onchanged,
      obscureText: securetext,
      validator: onvalidate,
    );
  }
}

class TextformfieldContainer extends StatelessWidget {
  const TextformfieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * .8,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
