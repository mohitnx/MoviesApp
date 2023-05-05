import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:movieapp/src/common/widgets/snackbarr.dart';
import 'package:movieapp/src/constants/constants.dart';
import 'package:movieapp/src/features/account/presentation/screens/signin_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mainColor,
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: Center(),
            ),
            Expanded(
              flex: 5,
              child: buildCard(size, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(Size size, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
        color: dropdownAreaColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nice to meet you!',
              style: TextStyle(
                fontSize: 30.sp,
                color: mainColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: size.height.h * 0.01,
            ),
            Text(
              'This only takes a few moments',
              style: TextStyle(
                fontSize: 18.sp,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height.h * 0.04,
            ),

            SvgPicture.asset(
              'assets/svgs/registerScreen1.svg',
              height: 180.h,
            ),
            SizedBox(
              height: size.height.h * 0.03,
            ),

            SizedBox(
              height: size.height.h * 0.05,
            ),

            nameTextField(size),
            SizedBox(
              height: size.height.h * 0.02,
            ),

            SizedBox(
              height: size.height.h * 0.03,
            ),

            signInButton(size),
            SizedBox(
              height: size.height.h * 0.04,
            ),

            //footer section. sign up text here
            footerText(context),
          ],
        ),
      ),
    );
  }

  Widget nameTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          width: 1.w,
          color: const Color(0xFFEFEFEF),
        ),
      ),
      child: TextFormField(
        controller: nameController,
        style: TextStyle(color: secondaryTextColor),
        maxLines: 1,
        decoration: InputDecoration(
            labelText: 'name',
            labelStyle: TextStyle(
              fontSize: 12.sp,
              color: Color(0xFF969AA8),
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget signInButton(Size size) {
    return InkWell(
      onTap: () async {
        Box box = Hive.box('users2');
        final userModelExists = box.values
            .any((element) => element.name == nameController.text.trim());
        if (userModelExists) {
          nameController.clear();
          addressController.clear();
          showSnackBar(context, 'Opps! A user with that name already exists');
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignupScreen()),
            (route) => false,
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0.r),
          color: mainColor,
        ),
        child: Text(
          "Let's Go",
          style: TextStyle(
            fontSize: 20.0.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.5.h,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget footerText(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'Already have an account?   ',
        style: TextStyle(color: secondaryTextColor, fontSize: 14.sp),
      ),
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignupScreen()),
          );
        },
        child: Text(
          'Sign In',
          style: TextStyle(
              color: mainColor, fontWeight: FontWeight.w700, fontSize: 14.sp),
        ),
      ),
    ]);
  }
}
