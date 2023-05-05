import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:movieapp/src/common/widgets/snackbarr.dart';
import 'package:movieapp/src/constants/constants.dart';
import 'package:movieapp/src/features/account/data/models/user_model.dart';
import 'package:movieapp/src/features/account/presentation/screens/signup_screen.dart';
import 'package:movieapp/src/features/movies/presentation/screens/bottomNavBar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Box box = Hive.box('users2');
  TextEditingController nameController = TextEditingController();

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

  Widget buildCard(Size size, BuildContext contex) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: dropdownAreaColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome back',
              style: TextStyle(
                fontSize: 30.0,
                color: mainColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              'Please enter your credentials',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.04,
            ),

            logo(size.height / 8, size.height / 8),
            SizedBox(
              height: size.height * 0.03,
            ),

            SizedBox(
              height: size.height * 0.05,
            ),

            Container(
              alignment: Alignment.center,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1.0,
                  color: const Color(0xFFEFEFEF),
                ),
              ),
              child: TextFormField(
                controller: nameController,
                style: TextStyle(color: secondaryTextColor),
                maxLines: 1,
                decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF969AA8),
                    ),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),

            SizedBox(
              height: size.height * 0.03,
            ),

            GestureDetector(
              onTap: () {
                print(nameController.text);

                final user = box.get('user');
                if (user == null) {
                  showSnackBar(
                      context, 'Opps! No account exists with that Name');
                } else {
                  if (user.name == nameController.text.trim()) {
                    showSnackBar(
                        context, 'Welcome back ${nameController.text}');

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => BottomBar()),
                      (route) => false,
                    );
                  } else {
                    // print(nameController.text.toString());
                    // print(box.keys);
                    // print(box.containsKey('Q1'));
                    // print(box.length);
                    showSnackBar(
                        context, 'Opps! No account exists with that Name');
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: backgroundColor,
                ),
                child: const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),

            //footer section. sign up text here
            footerText(contex),
          ],
        ),
      ),
    );
  }

  Widget logo(double height_, double width_) {
    return SvgPicture.asset(
      'assets/svgs/registerScreen2.svg',
      height: height_,
      width: width_,
    );
  }

  Widget footerText(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Dont have an account?  ',
          style: TextStyle(color: secondaryTextColor, fontSize: 14),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SigninScreen()),
            );
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
                color: mainColor, fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
