import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:movieapp/src/constants/constants.dart';
import 'package:movieapp/src/features/account/presentation/screens/signin_screen.dart';
import 'package:movieapp/src/features/account/presentation/screens/signup_screen.dart';
import 'package:movieapp/src/features/account/presentation/widgets/delayed_animations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 10;
  double? _scale;
  AnimationController? _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: backgroundColor,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 12.0.h, horizontal: 40.w),
                    child: SvgPicture.asset(
                      'assets/svgs/welcomeScreen1.svg',
                    ),
                  ),
                  DelayedAnimation(
                    delay: delayedAmount + 500,
                    child: Text(
                      "Welcome to YTS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 38.sp,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  DelayedAnimation(
                    delay: delayedAmount + 1000,
                    child: Text(
                      "Your one step destination",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  DelayedAnimation(
                    delay: delayedAmount + 1000,
                    child: Text(
                      "for all things movie",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  DelayedAnimation(
                    delay: delayedAmount + 2000,
                    child: GestureDetector(
                      child: Transform.scale(
                        scale: _scale,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SigninScreen()),
                          );
                        },
                        child: DelayedAnimation(
                          delay: delayedAmount + 2000,
                          child: AvatarGlow(
                            endRadius: 80.r,
                            duration: const Duration(seconds: 2),
                            glowColor: mainColor,
                            repeat: true,
                            repeatPauseDuration: const Duration(seconds: 2),
                            startDelay: const Duration(seconds: 1),
                            child: _animatedButtonUI,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()),
                          );
                        },
                        child: DelayedAnimation(
                          delay: delayedAmount + 2000,
                          child: const Text(
                            "I HAVE AN ACCOUNT",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 50.h,
        width: 200.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0.r),
          color: mainColor,
        ),
        child: Center(
          child: Text(
            'Get Started',
            style: TextStyle(
              fontSize: 20.0.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
}
