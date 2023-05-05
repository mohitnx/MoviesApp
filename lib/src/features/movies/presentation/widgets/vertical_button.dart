import 'package:flutter/material.dart';
import 'package:movieapp/src/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget verticalButton(icon, String label, onpressed) {
  return InkWell(
    onTap: onpressed,
    child: Column(
      children: [
        Icon(
          icon,
          color: mainColor,
          size: 40.sp,
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          label,
          style: TextStyle(color: mainColor, fontSize: 13),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    ),
  );
}
