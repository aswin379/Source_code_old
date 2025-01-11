import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonPaddingZero extends StatelessWidget {
  Function? onPressed;
  Color? background;
  final text;
  ButtonPaddingZero({super.key, this.text, this.onPressed, this.background});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero, backgroundColor: background),
      onPressed: onPressed as void Function()?,
      child: text,
    );
  }
}
