import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movieapp/src/constants/constants.dart';
import 'package:movieapp/src/features/movies/presentation/screens/details_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget newMovies(BuildContext context, String image, int id, String ytLink) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(
                  movieId: id,
                  ytLink: ytLink,
                )),
      );
    },
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 1.r,
              blurRadius: 10.r,
            ),
          ],
        ),
        width: 100.w,
        height: 150.h,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0.r),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: image,
            errorWidget: (context, url, error) => Image.network(
              'https://images.unsplash.com/photo-1628155930542-3c7a64e2c833?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
              fit: BoxFit.cover,
            ),
            placeholder: (context, url) => SpinKitWaveSpinner(color: mainColor),
          ),
        ),
      ),
    ),
  );
}
