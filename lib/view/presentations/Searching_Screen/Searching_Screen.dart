// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graduation/view/shared/component/constants.dart';

import '../../shared/component/layout.dart';

class SearchingScreen extends StatelessWidget {
  const SearchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: AppLayout.getWidth(20),
            vertical: AppLayout.getHeigth(40)),
        children: [
          Text(
            "What are \nyou looking for?",
            style: Styles.headLinestyle1,
          ),
          Gap(AppLayout.getHeigth(25)),
          Gap(AppLayout.getHeigth(25)),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: const TextField(
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Departure",
                    prefixIcon: Icon(
                      Icons.flight_takeoff_rounded,
                      color: Colors.black,
                    ))),
          ),
          Gap(AppLayout.getHeigth(15)),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: const TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Arrival",
                    prefixIcon: Icon(
                      Icons.flight_land_rounded,
                      color: Colors.black,
                    ))),
          ),
          Gap(AppLayout.getHeigth(25)),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blueAccent),
            child: TextButton(
              child: Text(
                "Find tickets",
                style: Styles.headLinestyle4.copyWith(color: Colors.white),
              ),
              onPressed: () {},
            ),
          ),
          Gap(AppLayout.getHeigth(35)),
          Gap(AppLayout.getHeigth(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: AppLayout.getHeigth(400),
                width: AppLayout.getSize(context).width * 0.42,
                padding: EdgeInsets.symmetric(
                    horizontal: AppLayout.getHeigth(15),
                    vertical: AppLayout.getWidth(15)),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 1,
                        spreadRadius: 1)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppLayout.getHeigth(20)),
                ),
                child: Column(
                  children: [
                    Container(
                      height: AppLayout.getHeigth(190),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppLayout.getHeigth(12)),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/one.jpg")),
                      ),
                    ),
                    Gap(AppLayout.getHeigth(15)),
                    Text(
                      "20% discount on the early booking flight.Don't miss.",
                      style: Styles.headLinestyle2,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppLayout.getHeigth(15),
                            vertical: AppLayout.getHeigth(15)),
                        height: AppLayout.getHeigth(200),
                        width: AppLayout.getSize(context).width * 0.44,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppLayout.getHeigth(15)),
                          color: const Color(0xFF3AB8BB),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Discount\nfor servey",
                                style: Styles.headLinestyle2.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Gap(AppLayout.getHeigth(10)),
                            Text(
                                "Take the servey of our services and get discount.",
                                style: Styles.headLinestyle3.copyWith(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                      Positioned(
                        right: -45,
                        top: -40,
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: const Color(0xFF189999), width: 18)),
                        ),
                      ),
                    ],
                  ),
                  Gap(AppLayout.getHeigth(15)),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppLayout.getHeigth(15),
                        vertical: AppLayout.getHeigth(15)),
                    height: AppLayout.getHeigth(170),
                    width: AppLayout.getSize(context).width * 0.44,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppLayout.getHeigth(15)),
                      color: const Color(0xFFEC6545),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Take Love",
                            style: Styles.headLinestyle2.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Gap(AppLayout.getHeigth(10)),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '😍',
                                style: TextStyle(fontSize: 30),
                              ),
                              TextSpan(
                                  text: '😘', style: TextStyle(fontSize: 40)),
                              TextSpan(
                                  text: '❤', style: TextStyle(fontSize: 30))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
