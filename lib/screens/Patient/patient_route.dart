import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'notifications_screen.dart';
import 'patient_profile_screen.dart';
import 'patient_home_screen.dart';

class PatientRoute extends StatefulWidget {
  static final String id = 'PatientRoute';
  @override
  _PatientRouteState createState() => _PatientRouteState();
}

class _PatientRouteState extends State<PatientRoute> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  List<Widget> _screens = [
    PatientHomeScreen(),
    PatientProfileScreen(),
    NotificationsScreen(),
  ];
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
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
              ),
              label: "Notifications",
            ),
          ],
        ),
      ),
    );
  }
}
