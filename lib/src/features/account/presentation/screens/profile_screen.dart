import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movieapp/src/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/src/features/account/presentation/screens/edit_info_screen.dart';
import 'package:movieapp/src/features/account/presentation/screens/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 300.h,
                  decoration: BoxDecoration(color: dropdownAreaColor),
                ),
                Opacity(
                  opacity: 0.1,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1600009723489-027195d6b3d3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300.h,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'My Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 26.sp,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50.h),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                100.r), // adjust the radius as per your needs
                            border: Border.all(
                              color: mainColor,
                              width: 4.w,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://images.unsplash.com/photo-1546743962-62ed8b1597ca?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80',
                              width: 120.w,
                              height: 120.h,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  SpinKitWaveSpinner(color: mainColor),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 210.w,
                        top: 105.h,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_alt,
                            color: mainColor,
                            size: 30.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 270.h,
                  left: 20.w,
                  child: Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      infoTiles('28', Icons.thumb_up_off_alt_sharp),
                      SizedBox(
                        width: 30,
                      ),
                      infoTiles('30', Icons.bookmark_add_outlined),
                      SizedBox(
                        width: 30,
                      ),
                      infoTiles('10', Icons.download_outlined),
                    ],
                  ),
                ),
                Positioned(
                  top: 210.h,
                  left: 165.w,
                  child: Row(
                    children: [
                      Text(
                        'joined: ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '2023 ',
                        style: TextStyle(
                            color: mainColor, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 60.h,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditInfoScreen()),
                      );
                    },
                    child: Text(
                      'edit info',
                      style: TextStyle(
                          color: secondaryTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: 400.w,
                    height: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0.r),
                      border: Border.all(
                        width: 1.w,
                        color: mainColor,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        profileInfo(
                          'Name',
                          'boxValue',
                        ),
                        profileInfo(
                          'Email',
                          'm1@gmail.com',
                        ),
                        profileInfo(
                          'Payment',
                          'eSewa',
                        ),
                        profileInfo(
                          'Limit',
                          '120',
                        ),
                        profileInfo(
                          'Path',
                          'storage/emulated/0/app/data/downloads',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Container(
                height: 50.h,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      side: BorderSide(
                        width: 2.w,
                        color: Colors.white.withOpacity(0.5),
                      )),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 14.sp),
                  ),
                  onPressed: () async {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (route) => false,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
profileInfo(String label, String value) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: '$label:    ',
          style: TextStyle(
            color: secondaryTextColor,
          ),
        ),
        TextSpan(
          text: value,
          style: TextStyle(
            color: mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget infoTiles(String text, IconData symbol) {
  return Container(
    width: 95,
    height: 75,
    decoration: BoxDecoration(
      color: mainColor,
      borderRadius: BorderRadius.circular(10.r),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 0, 0, 0),
          spreadRadius: 1,
          blurRadius: 15.r,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          symbol,
          size: 34.sp,
          color: Colors.white,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
          ),
        ),
      ],
    ),
  );
}
