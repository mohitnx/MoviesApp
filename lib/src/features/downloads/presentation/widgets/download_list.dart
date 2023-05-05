import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movieapp/src/constants/constants.dart';
import 'package:open_file/open_file.dart';

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
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: dropdownAreaColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: shadowColor,
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 6)),
          ],
        ),
        height: 65,
        child: Row(
          children: [
            Icon(
              Icons.filter_b_and_w_outlined,
              color: mainColor,
              size: 40,
            ),
            SizedBox(
              width: 16,
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
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      '12:09.   ',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '12.3 KB,   ',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'TORRENT file',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 10,
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
