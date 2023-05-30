import 'package:flutter/material.dart';

import '../../../constants.dart';

class RoundedBoutton extends StatelessWidget {
  const RoundedBoutton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textcolor = Colors.white,
  }) : super(key: key);

  final String text;
  final void Function() press;
  final Color color, textcolor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * .8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textcolor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
