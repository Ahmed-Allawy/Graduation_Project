// ignore_for_file: void_checks, non_constant_identifier_names, avoid_print

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../model/airports.dart';
import '../../presentations/Searching_Screen/SecondSearching_Screen.dart';

import 'constants.dart';
import 'helperfunctions.dart';
import 'layout.dart';

// this widget will use it for all the pages that contains fields
Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType textInputType,
  IconData? prefix,
  IconData? suffix,
  required String hintText,
  required Function validator,
  double? width,
  Function? suffixPressed,
  //this bool not required because I will use it only one time
  bool scure = false,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 10),
    width: width ?? AppLayout.getWidth(fieldWidth + 9),
    decoration: const BoxDecoration(
        color: fontColor, borderRadius: BorderRadius.all(Radius.circular(30))),
    child: TextFormField(
        validator: (value) {
          return validator(value);
        },
        controller: controller,
        obscureText: scure,
        keyboardType: textInputType,
        decoration: InputDecoration(
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: errorColor)),
          prefixIcon: Icon(
            prefix,
            color: primarycolor,
          ),
          //here we will check if the suffixpressed is avaiable or not then pass it if it's avaiable

          suffixIcon: IconButton(
            icon: Icon(
              suffix,
              color: primarycolor,
            ),
            onPressed: () {
              suffixPressed!();
            },
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: hintColor),
          iconColor: fieldIconColor,
        )),
  );
}

Widget defaultButton({
  required String text,
  required Function onPressed,
  double circularRaduis = 20,
}) {
  return MaterialButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(circularRaduis),
    ),
    minWidth: AppLayout.getWidth(fieldWidth),
    height: AppLayout.getHeigth(logInButtonHeight),
    color: logInButtonColor,
    onPressed: () {
      return onPressed();
    },
    child: Text(
      text,
      style: TextStyle(
          fontSize: AppLayout.getWidth(logInButtonFontSize), color: fontColor),
    ),
  );
}

Widget defaultTextButton({
  required String text,
  required Function onpressed,
}) {
  return TextButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(color: errorColor)),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(space0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(space1),
            side: const BorderSide(color: errorColor),
          ),
        ),
      ),
      onPressed: () {
        return onpressed();
      },
      child: Text(text));
}

//this widget to show Snackbar if error happend and can used anywhere
void showSnackbar(
    {required BuildContext context, required Widget message, Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: message,
    backgroundColor: color ?? Theme.of(context).primaryColor,
    duration: const Duration(seconds: 5),
    action: SnackBarAction(label: "ok", onPressed: (() {})),
  ));
}

class DotedWidget extends StatelessWidget {
  final int section;
  final double? width;
  final Color? color;
  const DotedWidget({
    Key? key,
    this.color,
    required this.section,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(
                (constraints.constrainWidth() / section).floor(),
                ((index) => SizedBox(
                      width: width ?? 5,
                      height: 1,
                      child: DecoratedBox(
                          decoration:
                              BoxDecoration(color: color ?? Colors.grey)),
                    ))));
      },
    );
  }
}

class ThickContainer extends StatelessWidget {
  final bool? iscolor;
  const ThickContainer({Key? key, this.iscolor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              width: 2.5,
              color: iscolor == null
                  ? Colors.white
                  : const Color.fromARGB(255, 105, 116, 235))),
    );
  }
}

Widget airPlaneDoted() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Spacer(),
      const ThickContainer(),
      Expanded(
        child: Stack(
          children: [
            const SizedBox(
                height: 24,
                child: DotedWidget(
                  color: Colors.blue,
                  section: 6,
                  width: 4,
                )),
            Center(
              child: Transform.rotate(
                  angle: 1.5,
                  child: const Icon(Icons.airplanemode_on_outlined,
                      color: Colors.blue)),
            ),
          ],
        ),
      ),
      const ThickContainer(),
      const Spacer(),
    ],
  );
}

Widget CustomTextFieldSearch(
    {required GlobalKey<AutoCompleteTextFieldState<Airport>> autoCompleteKey,
    required TextEditingController textEditingController,
    required String selectedCountry,
    required List<Airport> countries,
    required Function sumbit,
    required Function build,
    required String hint}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), color: Colors.white),
    child: AutoCompleteTextField<Airport>(
      key: autoCompleteKey,
      controller: textEditingController,
      clearOnSubmit: false,
      suggestions: countries,
      style: const TextStyle(color: Colors.black, fontSize: 16.0),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: const Icon(
            Icons.flight_takeoff_rounded,
            color: Colors.black,
          )),
      itemFilter: (item, query) {
        return item.country.toLowerCase().startsWith(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.country.compareTo(b.country);
      },
      itemSubmitted: (item) {
        return sumbit(item);
      },
      itemBuilder: (context, item) {
        return build(context, item);
      },
    ),
  );
}

class TripWidget extends StatelessWidget {
  const TripWidget(
      {Key? key,
      required this.airportFrom,
      required this.airportTo,
      required this.takeOffDate,
      required this.arrivalDate,
      required this.duration,
      required this.price,
      required this.flightNumber,
      required this.takeOffTime,
      required this.people})
      : super(key: key);
  final String airportFrom;
  final String airportTo;
  final String takeOffDate;
  final String arrivalDate;
  final String duration;
  final double price;
  final String flightNumber;
  final String takeOffTime;
  final int people;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          /*this container for blue part*/
          Container(
            padding: EdgeInsets.only(
              left: AppLayout.getHeigth(16),
              right: AppLayout.getHeigth(16),
              top: AppLayout.getHeigth(16),
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.airplanemode_active),
                    const Gap(15),
                    Text(
                      flightNumber,
                      style: Styles.headLinestyle4,
                    )
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text(
                            takeOffTime,
                            style: Styles.headLinestyle3
                                .copyWith(color: Styles.textColor),
                          ),
                          const Gap(5),
                          Text(
                            airportFrom,
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
                            airportTo,
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
                      duration,
                      style: Styles.headLinestyle4
                          .copyWith(color: Styles.textColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppLayout.getHeigth(16),
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Text(
                  "$price\$",
                  style:
                      Styles.headLinestyle3.copyWith(color: Styles.textColor),
                ),
                const Gap(25),
                Text("the price", style: Styles.headLinestyle4),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    print(people);
                    nextScreen(
                        context,
                        SecondSearchingScreen(
                          people: people,
                        ));
                  },
                  child: Text(
                    "Book Now",
                    style: Styles.headLinestyle3.copyWith(
                      color: const Color.fromARGB(255, 105, 116, 235),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TicketShape extends StatelessWidget {
  final String? passengerName;
  final String? flightNumber;
  final String? departureTime;
  final String? arrivalTime;
  final String? duration;
  final String? seatNumber;
  final String? seatClass;
  final String? departure;
  final String? arrival;
  final String id;
  const TicketShape({
    super.key,
    required this.passengerName,
    required this.flightNumber,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.seatNumber,
    required this.seatClass,
    required this.departure,
    required this.arrival,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Ticket No :',
                  style: Styles.headLinestyle3,
                ),
                Expanded(
                  child: Text(
                    id,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FromToShape(
              arrival: arrival,
              departure: departure,
            ),
            const SizedBox(height: 30),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Passenger Name',
                    style: Styles.headLinestyle3,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    passengerName!,
                    style: Styles.headLinestyle2,
                  ),
                ]),
            const SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Flight No',
                          style: Styles.headLinestyle3,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          flightNumber!,
                          style: Styles.headLinestyle2,
                        ),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Duration',
                          style: Styles.headLinestyle3,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          duration!,
                          style: Styles.headLinestyle2,
                        ),
                      ]),
                ]),
            const SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Departure Time',
                          style: Styles.headLinestyle3,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          departureTime!,
                          style: Styles.headLinestyle2,
                        ),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Arrival Time',
                          style: Styles.headLinestyle3,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          arrivalTime!,
                          style: Styles.headLinestyle2,
                        ),
                      ]),
                ]),
            const SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Seat No',
                          style: Styles.headLinestyle3,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          seatNumber!,
                          style: Styles.headLinestyle2,
                        ),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Class',
                          style: Styles.headLinestyle3,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          seatClass!,
                          style: Styles.headLinestyle2,
                        ),
                      ]),
                ]),

            const SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                height: 100,
                child: Image.asset('assets/images/barcode.jpg')),

            /// after line (second part)
            const SizedBox(height: 20),
            const DotedWidget(
              color: Color.fromARGB(255, 105, 116, 235),
              section: 10,
              width: 6,
            ),

            ///airplane and frm to shape
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Ticket No :',
                  style: Styles.headLinestyle3,
                ),
                Expanded(
                  child: Text(
                    id,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FromToShape(
              arrival: arrival,
              departure: departure,
            ),
            const SizedBox(height: 20),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Passenger Name',
                    style: Styles.headLinestyle3,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    passengerName!,
                    style: Styles.headLinestyle2,
                  ),
                ]),
            const SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Flight No',
                          style: Styles.headLinestyle3,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          flightNumber!,
                          style: Styles.headLinestyle2,
                        ),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Seat No',
                          style: Styles.headLinestyle3,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          seatNumber!,
                          style: Styles.headLinestyle2,
                        ),
                      ]),
                ]),
          ],
        ),
      ),
    );
  }
}

class FromToShape extends StatelessWidget {
  final String? departure;
  final String? arrival;
  const FromToShape({
    super.key,
    required this.departure,
    required this.arrival,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            "LHD",
            style: Styles.headLinestyle2.copyWith(color: Styles.textColor),
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
          child: Text(
            "CIR",
            style: Styles.headLinestyle2.copyWith(color: Styles.textColor),
          ),
        ),
      ],
    );
  }
}
