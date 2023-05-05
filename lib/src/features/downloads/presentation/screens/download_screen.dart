import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movieapp/src/constants/constants.dart';
import 'package:movieapp/src/features/downloads/presentation/widgets/download_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  bool sort = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
          right: 20.w,
          left: 20.w,
          bottom: 10.h,
          top: 80.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Downloads',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 32.sp),
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              children: [
                Text(
                  'Sort:',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: secondaryTextColor,
                      fontSize: 18.sp),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      sort = !sort;
                    });
                  },
                  child: Text(
                    sort ? 'ascending' : 'descending',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: mainColor.withOpacity(0.8),
                        fontSize: 14.sp),
                  ),
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: Hive.box<List>('downloads').listenable(),
              builder: (context, box, _) {
                List myStrings = box.get('myKey') ?? [];
                return Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: myStrings.length,
                    itemBuilder: (context, index) {
                      return downloadList(myStrings[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: 15.h,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
