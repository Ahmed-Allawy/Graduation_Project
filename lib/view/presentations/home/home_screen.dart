// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:graduation/view/presentations/Check_In/check_in.dart';
import 'package:graduation/view/presentations/My_Trips/my_trips.dart';
import 'package:graduation/view/presentations/User_profile/user_profile.dart';
import 'package:graduation/view/shared/component/constants.dart';
import '../Searching_Screen/Searching_Screen.dart';
import '../Booking_screen/booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [
    const BookingScreen(),
    const SearchingScreen(),
    const CheckIn(),
    const MyTrips(),
    const UserProfile(),
  ];
  int _pageIndex = 0;
  void _updateIndex(int value) {
    setState(() {
      _pageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: pages[_pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _pageIndex,
          backgroundColor: primarycolor,
          fixedColor: Colors.blue,
          selectedFontSize: 17,
          unselectedItemColor: const Color.fromARGB(255, 105, 116, 235),
          items: const [
            BottomNavigationBarItem(label: 'Booking', icon: Icon(Icons.flight)),
            BottomNavigationBarItem(
                label: 'Searching', icon: Icon(Icons.search)),
            BottomNavigationBarItem(
                label: 'Check In', icon: Icon(Icons.fact_check)),
            BottomNavigationBarItem(
                label: 'My Trips', icon: Icon(Icons.flight_land_sharp)),
            BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
          ],
          onTap: _updateIndex,
        )));
  }
}
