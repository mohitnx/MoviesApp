// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:movieapp/src/constants/constants.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;

  final Color? color;
  final VoidCallback onTap;
  const CustomPrimaryButton(
      {super.key, this.color, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 42,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: mainColor, // Background color
        ),
        icon: Icon(
          Icons.play_arrow,
          color: color,
          size: 24.0,
        ),
        label: Text(
          text + ' ',
          style: TextStyle(fontSize: 14),
        ),
        onPressed: () {},
      ),
    );
  }
}

class CustomSecondaryButton extends StatelessWidget {
  final String text;

  final Color? color;
  final Color? textColor;
  final VoidCallback onTap;
  const CustomSecondaryButton(
      {super.key,
      this.textColor,
      this.color,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 110,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0,
            side: BorderSide(
              width: 2.0,
              color: Colors.white.withOpacity(0.5),
            )),
        icon: Icon(
          Icons.desktop_windows_outlined,
          color: color,
          size: 24.0,
        ),
        label: Text(
          text,
          style: TextStyle(color: color, fontSize: 14),
        ),
        onPressed: () {},
      ),
    );
  }
}
