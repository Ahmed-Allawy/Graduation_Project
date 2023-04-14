import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Booking_screen/booking_screen.dart';
import '../../Check_In/check_in.dart';
import '../../My_Trips/my_trips.dart';
import '../../Searching_Screen/Searching_Screen.dart';
import '../../User_profile/user_profile.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  int pageIndex = 0;

  List<Widget> pages = [
    const BookingScreen(),
    SearchingScreen(),
    const CheckIn(),
    const MyTrips(),
    const UserProfile(),
  ];

  void updateIndex(int value) {
    pageIndex = value;
    emit(ChangePage());
  }
}
