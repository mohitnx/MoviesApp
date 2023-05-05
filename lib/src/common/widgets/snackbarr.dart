import 'package:flutter/material.dart';
import 'package:movieapp/src/constants/constants.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    duration: const Duration(milliseconds: 1200),
    elevation: 12,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5),
      topRight: Radius.circular(5),
    )),
    backgroundColor: mainColor,
    content: Text(
      message,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
