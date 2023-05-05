import 'package:flutter/material.dart';
import 'package:movieapp/src/constants/constants.dart';
import 'package:movieapp/src/features/downloads/presentation/screens/download_screen.dart';
import 'package:movieapp/src/features/movies/presentation/screens/home_screen.dart';
import 'package:movieapp/src/features/account/presentation/screens/profile_screen.dart';
import 'package:movieapp/src/features/movies/presentation/screens/search_screen.dart';
import 'package:movieapp/src/features/movies/presentation/widgets/custom_navbar_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = <Widget>[
      const HomeScreen(),
      const SearchScreen(),
      const DownloadScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
        body: screens[selectedIndex],
        backgroundColor: backgroundColor,
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.09,
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color.fromARGB(211, 0, 0, 0),
                blurRadius: 20,
              ),
            ],
          ),
          child: BottomNavigationBar(
            //wihotu being fixed we can't change the color
            type: BottomNavigationBarType.fixed,

            backgroundColor: backgroundColor,
            currentIndex: selectedIndex,

            elevation: 8,
            onTap: onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: CustomNavBarIcons(
                  icon: Icons.home_outlined,
                  selected: selectedIndex == 0,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: CustomNavBarIcons(
                  icon: Icons.search,
                  selected: selectedIndex == 1,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: CustomNavBarIcons(
                  icon: Icons.folder_outlined,
                  selected: selectedIndex == 2,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: CustomNavBarIcons(
                  icon: Icons.person_outline,
                  selected: selectedIndex == 3,
                ),
                label: '',
              ),
            ],
          ),
        ));
  }
}
