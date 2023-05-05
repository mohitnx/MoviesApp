import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movieapp/src/constants/constants.dart';
import 'package:movieapp/src/features/downloads/presentation/widgets/download_list.dart';

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
        padding: const EdgeInsets.only(
          right: 20.0,
          left: 20.0,
          bottom: 10.0,
          top: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Downloads',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 32),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  'Sort:',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: secondaryTextColor,
                      fontSize: 18),
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
                        fontSize: 14),
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
                        const SizedBox(
                      height: 15,
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
