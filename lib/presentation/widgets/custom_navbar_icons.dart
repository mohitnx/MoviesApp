import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movieapp/constants.dart';

class CustomNavBarIcons extends StatelessWidget {
  final IconData icon;
  final bool selected;
  CustomNavBarIcons({super.key, required this.icon, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: selected ? mainColor : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 33,
        fill: 0.1,
      ),
    );
  }
}
