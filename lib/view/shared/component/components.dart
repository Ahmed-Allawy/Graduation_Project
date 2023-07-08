// ignore_for_file: void_checks, non_constant_identifier_names

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

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
    width: width ?? AppLayout.getWidth(fieldWidth),
    decoration: const BoxDecoration(
        color: fontColor, borderRadius: BorderRadius.all(Radius.circular(5))),
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

Widget buildPersonFields() {
  var formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passportController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  return Form(
    key: formKey,
    child: Column(
      children: [
        defaultTextField(
          width: double.infinity,
          prefix: Icons.person,
          controller: firstNameController,
          textInputType: TextInputType.name,
          hintText: "Full Name",
          validator: (val) {
            if (val.isEmpty) {
              return "First Name shouldn't be empty";
            }
          },
        ),
        const Gap(25),
        defaultTextField(
          width: double.infinity,
          prefix: Icons.person,
          controller: lastNameController,
          textInputType: TextInputType.name,
          hintText: "LastName",
          validator: (val) {
            if (val.isEmpty) {
              return "Last Name shouldn't be empty";
            }
          },
        ),
        const Gap(25),
        defaultTextField(
          width: double.infinity,
          prefix: Icons.numbers,
          controller: passportController,
          textInputType: TextInputType.number,
          hintText: "Passport",
          validator: (val) {
            if (val.isEmpty) {
              return "Passport shouldn't be empty";
            }
          },
        ),
        const Gap(25),
        defaultTextField(
          width: double.infinity,
          prefix: Icons.flag,
          controller: nationalityController,
          textInputType: TextInputType.name,
          hintText: "Nationality",
          validator: (val) {
            if (val.isEmpty) {
              return "Nationality shouldn't be empty";
            }
          },
        ),
        const Gap(25),
        defaultTextField(
          width: double.infinity,
          controller: emailController,
          textInputType: TextInputType.emailAddress,
          prefix: Icons.email,
          hintText: "Email",
          validator: (val) {
            return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(val!)
                ? null
                : "Please enter a valid email";
          },
        ),
        const Gap(25),
        defaultTextField(
          width: double.infinity,
          prefix: Icons.visibility,
          controller: passwordController,
          textInputType: TextInputType.name,
          hintText: "password",
          validator: (val) {
            if (val.isEmpty) {
              return "Password shouldn't be empty";
            }
          },
        ),
        const Gap(25),
        SizedBox(
          width: double.infinity,
          child: IntlPhoneField(
            controller: phoneNumberController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            onChanged: (s) {},
            initialCountryCode: 'EG',
          ),
        ),
        defaultTextField(
          width: double.infinity,
          prefix: Icons.date_range,
          controller: ageController,
          textInputType: TextInputType.number,
          hintText: "AGE",
          validator: (val) {
            if (val.isEmpty) {
              return "AGE shouldn't be empty";
            }
          },
        ),
        const Gap(25),
        defaultTextField(
          width: double.infinity,
          prefix: Icons.male,
          controller: genderController,
          textInputType: TextInputType.name,
          hintText: "Gender",
          validator: (val) {
            if (val.isEmpty) {
              return "Gender should be either male or female";
            }
          },
        ),
        const Gap(25),
        const SizedBox(
          height: 24,
          child: DotedWidget(
            color: Color.fromARGB(255, 67, 79, 210),
            section: 10,
            width: 4,
          ),
        ),
        const Gap(25),
      ],
    ),
  );
}

class TripWidget extends StatelessWidget {
  const TripWidget(
      {Key? key,
      required this.departureCity,
      required this.arrivalCity,
      required this.departureDate,
      required this.arrivalDate,
      required this.tripTime,
      required this.price,
      required this.planeID,
      required this.People})
      : super(key: key);
  final String departureCity;
  final String arrivalCity;
  final String departureDate;
  final String arrivalDate;
  final String tripTime;
  final String price;
  final String planeID;
  final int People;

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
                      "Plane ID",
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
                  "510 \$",
                  style:
                      Styles.headLinestyle3.copyWith(color: Styles.textColor),
                ),
                const Gap(25),
                Text("the price", style: Styles.headLinestyle4),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    print(People);
                    nextScreen(
                        context,
                        SecondSearchingScreen(
                          people: People,
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
