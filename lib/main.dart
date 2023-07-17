import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation/view/presentations/Searching_Screen/cubit/search_cubit.dart';
import 'package:graduation/view/presentations/Seat_screen/cubit/seat_cubit.dart';

import 'package:graduation/view/presentations/auth/cubit/auth_cubit.dart';

import 'package:graduation/view/presentations/find_ticket/cubit/find_ticket_cubit.dart';

import 'package:graduation/view/presentations/ticket/cubit/ticket_cubit.dart';
import 'package:graduation/view/presentations/ticket/ticket.dart';

import 'package:graduation/view/shared/component/constants.dart';
import 'package:graduation/view/shared/network/payment/cubit/paypal_cubit.dart';

import 'view/presentations/auth/login/login_screen.dart';
import 'view/shared/network/local/cach_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => SearchCubit())),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: ((context) => FlightTicketCubit())),
        BlocProvider(create: ((context) => FindTicketCubit())),
        BlocProvider(create: ((context) => SeatCubit())),
        BlocProvider(create: ((context) => PaypalPaymentCubit())),
      ],
      child: MaterialApp(
          theme: ThemeData(
            primaryColor: primarycolor,
          ),
          // builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          home:
              //const CheckoutPage(
              //   price: 7,
              //   quantity: 1,
              //   superUserId: 'sdsds',
              // )
              // const Ticket(superSuerID: "bf5c50c9-2a6c-4b86-8d47-7b52b5f90c8a")
              const LoginHome()
          // SelectSeat(
          //   classID: 'cscss',
          //   price: 2,
          //   usersID: ['scfscs', 'sfsdcced', 'sfsafafsaf', 'dfdsfsdf'],
          // )
          ),
    );
  }
}
