import 'package:flutter/material.dart';

import '../../../constants.dart';

class ReusableBoutton extends StatelessWidget {
  const ReusableBoutton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textcolor = Colors.white,
    this.width = 200,
    this.height = 50,
  }) : super(key: key);

  final String text;
  final void Function() press;
  final Color color, textcolor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: MaterialButton(
          padding: const EdgeInsets.all(10),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textcolor, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
