import 'dart:async';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movieapp/src/common/widgets/snackbarr.dart';
import 'package:movieapp/src/constants/constants.dart';
import 'package:movieapp/src/features/downloads/presentation/screens/download_screen.dart';
import 'package:movieapp/src/features/movies/presentation/screens/details_screen.dart';
import 'package:movieapp/src/features/movies/presentation/widgets/vertical_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DescriptionBody extends StatefulWidget {
  String title;
  String link;
  List cast;
  String rating;
  String description;
  String image;
  List genre;
  String youtubeTrailerLink;
  String torrentLink;

  int releasedYear;

  DescriptionBody({
    Key? key,
    required this.title,
    required this.link,
    required this.cast,
    required this.rating,
    required this.description,
    required this.image,
    required this.torrentLink,
    required this.genre,
    required this.youtubeTrailerLink,
    required this.releasedYear,
  }) : super(key: key);

  @override
  State<DescriptionBody> createState() => _DescriptionBodyState();
}

//implement progressbar while downloading
//https://stackoverflow.com/questions/60761984/flutter-how-to-download-video-and-save-them-to-internal-storage

class _DescriptionBodyState extends State<DescriptionBody> {
  final box = Hive.box<List>('downloads');
  bool isPermission = false;
  // var checkAllPermissions = CheckPermission();
  // checkPermission() async {
  //   var permission = await checkAllPermissions.isStoragePermission();
  //   if (permission) {
  //     setState(() {
  //       isPermission = true;
  //     });
  //   }
  // }

  @override
  YoutubePlayerController? controller;
  shareFunction() {
    Share.share(widget.link.toString());
    print('share this');
  }

  Future downloadFunction() async {
    var status = await Permission.manageExternalStorage.request();
    if (status.isDenied) {
      throw Exception('Permission to access storage denied');
    }
    Dio dio = Dio();

    final response = await dio.get(widget.torrentLink,
        options: Options(responseType: ResponseType.bytes));

    if (response.statusCode == 200) {
      final bytes = response.data;
      final directory = await getExternalStorageDirectory();
      final folderPath = '${directory!.path}/com.example.movies';
      await Directory(folderPath)
          .create(recursive: true); // create the directory if it doesn't exist
      final filePath = '$folderPath/${widget.title}.torrent';

      final file = File(filePath);
      await file.writeAsBytes(bytes);
      List myList = box.get('myKey') ?? [];
      myList.add(widget.title);
      box.put('myKey', myList);
      showSnackBar(context, 'downlaod successful');
      //so that the user can see teh snackbar before being taken to downloads page
      Timer(Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DownloadScreen()),
        );
      });
    } else {
      showSnackBar(context, 'Error! Could not download torrent');
      throw Exception('Failed to download file');
    }
  }

  // Future<File?> pickFile() async {
  //   final result = await FilePicker.platform.pickFiles();
  //   if (result == null) throw 'error in file pciker';
  //   return File(result.files.first.path!);
  // }

  // Future<File?> downloadFile() async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final file = File('${appStorage.path}/${widget.title}.torrent');
  //   try {
  //     final response = await Dio().get(
  //       'https://images.unsplash.com/photo-1534644107580-3a4dbd494a95?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  //       options: Options(
  //         responseType: ResponseType.bytes,
  //         followRedirects: false,
  //         receiveTimeout: Duration(minutes: 1),
  //       ),
  //     );

  //     //first we take teh donloed 'file' , then open it and write its contents to local storage and then return the file
  //     final raf = file.openSync(mode: FileMode.write);
  //     raf.writeFromSync(response.data);
  //     await raf.close();
  //     return file;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  trailerFunction() async {
    await launchUrl(
      Uri.parse('https://www.youtube.com/watch?v=${widget.youtubeTrailerLink}'),
      mode: LaunchMode.externalApplication,
    );
  }

  // testDownload() async {
  //   await launchUrl(
  //     Uri.parse(
  //         'magnet:?xt=urn:btih:${widget.torrentLink}&dn=&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Fopentor.org%3A2710&tr=udp%3A%2F%2Ftracker.ccc.de%3A80&tr=udp%3A%2F%2Ftracker.blackunicorn.xyz%3A6969&tr=udp%3A%2F%2Ftracker.coppersurfer.tk%3A6969&tr=udp%3A%2F%2Ftracker.leechers-paradise.org%3A6969'),
  //     mode: LaunchMode.externalApplication,
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkPermission();
    controller = YoutubePlayerController(
      initialVideoId: widget
          .youtubeTrailerLink, // https://www.youtube.com/watch?v=Tb9k9_Bo-G4
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        isLive: false,
        loop: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //cast is a list<map> at first extracting the strings from the map and
    //putting them into a new list<String>
    //then mappign throught the new list to generate text widget with cast members
    List tempValues = [];
    widget.cast.forEach((element) {
      tempValues.add(element['name'].toString());
    });

    return Scaffold(
      backgroundColor: backgroundColor,
      body: YoutubePlayerBuilder(
        builder: (context, player) {
          return Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.52,
                    child: player,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 60.h, horizontal: 15.w),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: mainColor,
                        size: 28.sp,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.width * 0.64,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.symmetric(
                          vertical: 60.h, horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title +
                                ' [${widget.releasedYear.toString()}]',
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 33.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //runtime is not given in api call so static data
                              Text(
                                '1h 20m',
                                style: TextStyle(
                                    color: secondaryTextColor, fontSize: 14.sp),
                              ),
                              SizedBox(
                                width: 9.w,
                              ),
                              Container(
                                color: mainColor,
                                padding: const EdgeInsets.all(3),
                                child: const Text(
                                  ' HD ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          /////
                          SizedBox(
                            child: Row(
                              children: widget.genre.map((var item) {
                                return Row(
                                  children: [
                                    Text(
                                      item + ' ',
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: secondaryTextColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Center(
                                      child: Icon(
                                        Icons.circle,
                                        color: mainColor,
                                        size: 5.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 10.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color.fromARGB(204, 0, 0, 0),
                      const Color.fromARGB(255, 46, 29, 29).withOpacity(0.0),
                    ],
                    stops: const [0.0, 2.0],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.0.w),
                child: Divider(
                  thickness: 0.14,
                  color: mainColor,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  verticalButton(
                      Icons.date_range_outlined, 'Trailer', trailerFunction),
                  //Vertical divider didn't show by default so had to wrap it in contaier

                  SizedBox(
                    height: 80.h,
                    child: Row(
                      children: [
                        VerticalDivider(
                          color: mainColor,
                          thickness: 0.14,
                        ),
                      ],
                    ),
                  ),
                  verticalButton(
                      Icons.file_download, 'Download', downloadFunction),

                  SizedBox(
                    height: 80.h,
                    child: Row(
                      children: [
                        VerticalDivider(
                          color: mainColor,
                          thickness: 0.14,
                        ),
                      ],
                    ),
                  ),
                  verticalButton(Icons.share, 'Share', shareFunction),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.0.w),
                child: Divider(
                  thickness: 0.14,
                  color: mainColor,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print(widget.cast);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.h),
                          child: Text(
                            widget.description,
                            style: TextStyle(
                                color: secondaryTextColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Text(
                              'Cast:  ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .80,
                              child: Wrap(
                                children: tempValues.map((var item) {
                                  return Text(
                                    item + ', ',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //director name not provided so used static data
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Text(
                              'Director:  ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Martin Tarantino',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        player: YoutubePlayer(
          controller: controller!,
          bottomActions: [
            CurrentPosition(
              controller: controller,
            ),
            ProgressBar(
              colors: ProgressBarColors(
                backgroundColor: mainColor,
                playedColor: mainColor,
                handleColor: mainColor,
              ),
              isExpanded: true,
            ),
            PlaybackSpeedButton(
              controller: controller,
              icon: Icon(
                Icons.speed_sharp,
                color: mainColor,
              ),
            ),
            FullScreenButton(
              color: mainColor,
            ),
          ],

          //shadwo couldn't be displayed over the videoplayer,, so the shadwo is displyed over the thumbnail property of the vidoe player
          //when the vido is paused, this stack is shwn giving the thumbnai a good shadow...when video is playing
          //due to the aspect ratio of trailsers,,,there is alwyas a black bar at the top and bottom of screen so no need for a shadow
          thumbnail: Stack(children: [
            SizedBox(
              width: double.infinity,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.image,
                errorWidget: (context, url, error) => Image.network(
                  'https://images.unsplash.com/photo-1628155930542-3c7a64e2c833?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
                  fit: BoxFit.cover,
                ),
                placeholder: (context, url) =>
                    SpinKitWaveSpinner(color: mainColor),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 158, 158, 158).withOpacity(0.0),
                    Color.fromARGB(242, 0, 0, 0),
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
