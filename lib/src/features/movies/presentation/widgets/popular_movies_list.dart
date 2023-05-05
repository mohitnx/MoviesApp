import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movieapp/src/constants/constants.dart';
import 'package:movieapp/src/features/movies/presentation/screens/details_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget popularMovies(
  BuildContext context,
  String title,
  String description,
  String image,
  int id,
  String ytLink,
) {
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
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          width: 160.w,
          child: Stack(
            children: [
              Container(
                height: 100.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      spreadRadius: 1.r,
                      blurRadius: 10.r,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0.r),
                  child: CachedNetworkImage(
                    width: 170.w,
                    fit: BoxFit.cover,
                    imageUrl: image,
                    errorWidget: (context, url, error) => Image.network(
                      'https://images.unsplash.com/photo-1628155930542-3c7a64e2c833?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
                      fit: BoxFit.fill,
                    ),
                    placeholder: (context, url) =>
                        SpinKitWaveSpinner(color: mainColor),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    color: mainColor,
                    padding: const EdgeInsets.all(3),
                    child: const Text(
                      'HD',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          width: 160.w,
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        SizedBox(
          width: 160.w,
          child: Text(
            description,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(color: secondaryTextColor, fontSize: 12.sp),
          ),
        ),
      ],
    ),
  );
}

Widget popularMoviesVertical(BuildContext context, String title,
    String description, String image, List genre, int id, String ytLink) {
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
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160.w,
          child: Stack(
            children: [
              Container(
                height: 100.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      spreadRadius: 1.r,
                      blurRadius: 10.r,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0.r),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    width: 160.w,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Image.network(
                      'https://images.unsplash.com/photo-1628155930542-3c7a64e2c833?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bm8lMjBpbWFnZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60',
                      fit: BoxFit.cover,
                    ),
                    placeholder: (context, url) =>
                        SpinKitWaveSpinner(color: mainColor),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    color: mainColor,
                    padding: const EdgeInsets.all(3),
                    child: const Text(
                      'HD',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        Column(
          children: [
            SizedBox(
              width: 180.w,
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              width: 180.w,
              child: Text(
                description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: secondaryTextColor, fontSize: 11.sp),
              ),
            ),
            SizedBox(
              height: 38.h,
            ),

            //taking each item of list genre and returing a Text widget
            SizedBox(
              width: 180.w,
              //using row we got overflow...and didn't want to make such a tiny scrollable row here..not good ui i think
              child: Wrap(
                children: genre.map((var item) {
                  return Text(
                    item + ', ',
                    style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


//1
//after 'popular search' text, there is  extra space at the top befoer the list view items start 
//why?...
//ans: due to deafult padding in list veiw...to hatayechi extra space is gone


//2
//movie photo ko side ma top ma title and descirotpion...spacing then bottom ma genre list
//cant use flxe due to page layout...uta listview.builder cha...so renderbox error shown
//using two columns parent column with mainaxis aloigntmetn space betwee. 
//parent col ma chai title and descripn as one column item and anterh item chai genre
//esari title descipn top ma bascha ani genre bottom ma aucha....tara yo ni kaam garena...so aile lai manually garya cha
