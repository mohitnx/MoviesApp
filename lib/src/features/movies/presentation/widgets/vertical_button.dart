import 'package:flutter/material.dart';
import 'package:movieapp/src/constants/constants.dart';

Widget verticalButton(icon, String label, onpressed) {
  return InkWell(
    onTap: onpressed,
    child: Column(
      children: [
        Icon(
          icon,
          color: mainColor,
          size: 40,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: TextStyle(color: mainColor, fontSize: 13),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
