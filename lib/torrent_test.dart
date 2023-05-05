import 'package:movieapp/src/common/widgets/snackbarr.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TorrentTest extends StatefulWidget {
  const TorrentTest({super.key});

  @override
  State<TorrentTest> createState() => _TorrentTestState();
}

class _TorrentTestState extends State<TorrentTest> {
  String? filepattt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          TextButton(
            child: Text('download url'),
            onPressed: () async {
              var status = await Permission.manageExternalStorage.request();
              if (status.isDenied) {
                throw Exception('Permission to access storage denied');
              }
              Dio dio = Dio();

              final response = await dio.get(
                  'https://yts.mx/torrent/download/15230DC0B7D4752E9E68FF5AB40530B1D42FBD04',
                  options: Options(responseType: ResponseType.bytes));

              if (response.statusCode == 200) {
                final bytes = response.data;
                final directory = await getExternalStorageDirectory();
                final folderPath = '${directory!.path}/com.example.movies';
                await Directory(folderPath).create(
                    recursive:
                        true); // create the directory if it doesn't exist
                final filePath = '$folderPath/my_file1.torrent';
                filepattt = filePath;
                final file = File(filePath);
                await file.writeAsBytes(bytes);

                print('File downloaded successfully to $filePath');
                showSnackBar(context, 'downlaoded');
              } else {
                throw Exception('Failed to download file');
              }
            },
          ),
          openButton(
              '/storage/emulated/0/Android/data/com.example.movieapp/files/com.example.movies/my_file1.torrent'),
        ],
      )),
    );
  }
}

Widget openButton(String filePath) {
  return TextButton(
      onPressed: () async {
        print(filePath);
        try {
          final result = await OpenFile.open(filePath);
          print('ssssssssssssssssssss' + result.message);
        } catch (e) {
          print('error' + e.toString());
        }
      },
      child: Text('open'));
}
