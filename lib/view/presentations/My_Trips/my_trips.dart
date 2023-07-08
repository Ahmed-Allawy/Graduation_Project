// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:graduation/view/presentations/My_Trips/cubit/mytirps_state.dart';
import 'package:graduation/view/presentations/My_Trips/cubit/mytrips_cubit.dart';

import 'package:graduation/view/presentations/ticket/ticket.dart';

import '../../shared/component/components.dart';
import '../../shared/component/constants.dart';
import '../../shared/component/helperfunctions.dart';
import '../../shared/component/layout.dart';

class MyTrips extends StatelessWidget {
  const MyTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xc61859ba),
        appBar: AppBar(
          backgroundColor: const Color(0xc61859ba),
          centerTitle: true,
          title: const Text("My Trips"),
          leading: BackButton(
            onPressed: () => nextScreenRep(context, const Ticket()),
          ),
        ),
        body: BlocConsumer<PersonTripsCubit, PersonTripsState>(
            listener: (context, state) {},
            builder: (context, state) {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return const PersonTripCard(
                    departureCity: 'lux',
                    arrivalCity: 'gred',
                    departureDate: 'departureDate',
                    arrivalDate: 'arrivalDate',
                    tripTime: 'tripTime',
                    price: 'price',
                    planeID: 'planeID',
                    passengerName: '',
                    seatNo: '',
                  );
                },
              );
            }));
  }
}

class PersonTripCard extends StatelessWidget {
  const PersonTripCard(
      {Key? key,
      required this.departureCity,
      required this.arrivalCity,
      required this.departureDate,
      required this.arrivalDate,
      required this.tripTime,
      required this.price,
      required this.planeID,
      required this.seatNo,
      required this.passengerName})
      : super(key: key);
  final String departureCity;
  final String arrivalCity;
  final String departureDate;
  final String arrivalDate;
  final String tripTime;
  final String price;
  final String planeID;
  final String seatNo;
  final String passengerName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(50)),
                color: Colors.white,
              ),
              child: Text(
                'Ahmed Mousa Abdullaha',
                style: Styles.headLinestyle2,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          /*this container for blue part*/
          Container(
            padding: EdgeInsets.only(
              left: AppLayout.getHeigth(16),
              right: AppLayout.getHeigth(16),
              top: AppLayout.getHeigth(16),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Text(
                          "11:00",
                          style: Styles.headLinestyle3
                              .copyWith(color: Styles.textColor),
                        ),
                        const Gap(5),
                        Text(
                          "LHD",
                          style: Styles.headLinestyle4
                              .copyWith(color: Styles.textColor),
                        ),
                      ],
                    ),
                  ),
                  const ThickContainer(
                    iscolor: true,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        const SizedBox(
                          height: 24,
                          child: DotedWidget(
                            color: Color.fromARGB(255, 105, 116, 235),
                            section: 6,
                            width: 4,
                          ),
                        ),
                        Center(
                          child: Transform.rotate(
                            angle: 1.5,
                            child: const Icon(
                              Icons.airplanemode_on_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const ThickContainer(
                    iscolor: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Text(
                          "13:00",
                          style: Styles.headLinestyle3
                              .copyWith(color: Styles.textColor),
                        ),
                        const Gap(5),
                        Text(
                          "CIR",
                          style: Styles.headLinestyle4
                              .copyWith(color: Styles.textColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "0h 15m",
                    style:
                        Styles.headLinestyle4.copyWith(color: Styles.textColor),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.airplanemode_active),
                          const Gap(15),
                          Text(
                            "Flight No",
                            style: Styles.headLinestyle3,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '34A',
                        style: Styles.headLinestyle2,
                      ),
                    ]),
                    Column(children: <Widget>[
                      Row(
                        children: [
                          const Icon(Icons.chair),
                          const Gap(15),
                          Text(
                            "Seat No",
                            style: Styles.headLinestyle3,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '34A',
                        style: Styles.headLinestyle2,
                      ),
                    ]),
                    //
                  ]),
              const Gap(15),

              Row(
                children: [
                  Text(
                    "510 \$",
                    style:
                        Styles.headLinestyle3.copyWith(color: Styles.textColor),
                  ),
                  const Gap(25),
                  Text("the price", style: Styles.headLinestyle4),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Set Alarm",
                      style: Styles.headLinestyle3.copyWith(
                        color: const Color.fromARGB(255, 105, 116, 235),
                      ),
                    ),
                  ),
                ],
              ),
              //
            ]),
          ),
        ],
      ),
    );
  }
}
