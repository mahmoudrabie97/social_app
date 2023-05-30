import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigationremove(BuildContext context, Widget widget) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => widget));
}

void navigationto(BuildContext context, Widget widget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
}

enum Toaststate {
  sucsesful,
  error,
  warning,
}
Color? color;
Color? toastchoose(Toaststate state) {
  switch (state) {
    case Toaststate.sucsesful:
      color = Colors.green;
      break;
    case Toaststate.error:
      color = Colors.red;
      break;
    case Toaststate.warning:
      color = Colors.amber;
  }
  return color;
}

void showtoat({required String msg, required Toaststate state}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: toastchoose(state),
    textColor: Colors.white,
    fontSize: 16,
  );
}

AppBar defaultAppbar(
    {required BuildContext context, String? title, List<Widget>? actions}) {
  return AppBar(
    elevation: 0,
    titleSpacing: 0,
    backgroundColor: Colors.white,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        )),
    title: Text(
      title!,
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w900),
    ),
    actions: actions,
  );
}
