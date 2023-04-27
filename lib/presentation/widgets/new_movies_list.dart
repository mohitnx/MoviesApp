import 'package:flutter/material.dart';

import '../../constants.dart';
import '../screens/details_screen.dart';

Widget newMovies(BuildContext context, String image, int id) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(
                  movieId: id,
                )),
      );
    },
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        width: 100,
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
