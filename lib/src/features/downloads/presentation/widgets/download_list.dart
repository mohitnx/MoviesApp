import 'package:flutter/material.dart';

import 'package:movieapp/src/constants/constants.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget downloadList(String title) {
  String filePath =
      '/storage/emulated/0/Android/data/com.example.movieapp/files/com.example.movies/repeater.torrent';
  return InkWell(
    onTap: () async {
      print(filePath);
      try {
        final result = await OpenFile.open(filePath);
        print('success' + result.message);
      } catch (e) {
        print('error ' + e.toString());
      }
    },
    child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: dropdownAreaColor,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
                color: shadowColor,
                spreadRadius: 2.r,
                blurRadius: 10,
                offset: Offset(0.w, 6.h)),
          ],
        ),
        height: 65.h,
        child: Row(
          children: [
            Icon(
              Icons.filter_b_and_w_outlined,
              color: mainColor,
              size: 40.sp,
            ),
            SizedBox(
              width: 16.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    Text(
                      '12:09.   ',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      '12.3 KB,   ',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      'TORRENT file',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )),
  );
}
