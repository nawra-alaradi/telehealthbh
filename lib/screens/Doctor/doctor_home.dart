import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'requests_screen.dart';
import 'doctor_profile_screen.dart';

class DoctorHome extends StatefulWidget {
  static final String id = 'DoctorHomeScreen';
  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  List<Widget> _screens = [RequestsScreen(), DoctorProfileScreen()];
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          iconSize: 25.w,
          // selectedFontSize: 14.sp,
          // unselectedFontSize: 14.sp,
          selectedLabelStyle: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Work Sans',
              fontWeight: FontWeight.w300),
          unselectedLabelStyle: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Work Sans',
              fontWeight: FontWeight.w300),
          selectedItemColor: Colors.amber[10],
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
              ),
              label: "Requests",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
