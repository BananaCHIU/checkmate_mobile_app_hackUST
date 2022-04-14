import 'package:checkmate_mobile_app/Core/UserInfo.dart';
import 'package:checkmate_mobile_app/Entities/BookingRecord.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'MainPage.dart';
import 'Schedule.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedPageIndex = 0;
  int _selectedNavBarItemIndex = 0;
  List<BookingRecord> bookings = [];

  @override
  void initState() {
    bookings = BookingRecord.getBooking();
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      if (_selectedPageIndex < 2)
      {
        _selectedNavBarItemIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> _navBarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.nfc_rounded),
        label: "check_in_tab",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "info_tab",
      ),
    ];
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: IndexedStack(
          index: _selectedPageIndex,
          children: [
            MainPage(showSchedulePage: showSchedulePage,),
            UserInfo(),
            Schedule(showSchedulePage: showSchedulePage,)
          ],
        ),
        bottomNavigationBar: Container(
          child: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: _selectPage,
            elevation: 0,
            backgroundColor: Colors.blue,
            unselectedItemColor: Color(0x88FFFFFF),
            selectedItemColor: Color(0xFFFFFFFF),
            currentIndex: _selectedNavBarItemIndex,
            type: BottomNavigationBarType.fixed,
            items: _navBarItems,
          ),
        ),
      ),
    );
  }

  void showSchedulePage(bool shouldScheduleShow) {
    if (shouldScheduleShow) {
      _selectPage(2); //index of hidden Schedule page == 3
    } else {
      _selectPage(0); //back button pressed, go back to original page
    }
  }
}
