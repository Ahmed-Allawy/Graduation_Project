// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation/view/shared/component/constants.dart';

import 'cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return (BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body:
                HomeCubit.get(context).pages[HomeCubit.get(context).pageIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: HomeCubit.get(context).pageIndex,
              backgroundColor: primarycolor,
              fixedColor: Colors.blue,
              selectedFontSize: 17,
              unselectedItemColor: const Color.fromARGB(255, 105, 116, 235),
              items: const [
                BottomNavigationBarItem(
                    label: 'Booking', icon: Icon(Icons.flight)),
                BottomNavigationBarItem(
                    label: 'Searching', icon: Icon(Icons.search)),
                BottomNavigationBarItem(
                    label: 'Check In', icon: Icon(Icons.fact_check)),
                BottomNavigationBarItem(
                    label: 'My Trips', icon: Icon(Icons.flight_land_sharp)),
                BottomNavigationBarItem(
                    label: 'Profile', icon: Icon(Icons.person)),
              ],
              onTap: (int val) {
                return HomeCubit.get(context).updateIndex(val);
              },
            ));
      },
    ));
  }
}
