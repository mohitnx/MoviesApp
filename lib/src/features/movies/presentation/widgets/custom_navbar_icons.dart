import 'package:flutter/material.dart';

import 'package:movieapp/src/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNavBarIcons extends StatelessWidget {
  final IconData icon;
  final bool selected;
  CustomNavBarIcons({super.key, required this.icon, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: selected ? mainColor : Colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 33.sp,
        fill: 0.1,
      ),
    );
  }
}
