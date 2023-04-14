// ignore_for_file: void_checks

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'layout.dart';

// this widget will use it for all the pages that contains fields
Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType textInputType,
  IconData? prefix,
  IconData? suffix,
  required String hintText,
  required Function validator,
  Function? suffixPressed,
  //this bool not required because I will use it only one time
  bool scure = false,
}) {
  return Container(
    width: AppLayout.getWidth(fieldWidth),
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

Widget customTextFieldSerach(
    {required GlobalKey<AutoCompleteTextFieldState<String>> autoCompleteKey,
    required TextEditingController textEditingController,
    required String selectedCountry,
    required List<String> countries,
    required Function sumbit,
    required Function build,
    required String hint}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), color: Colors.white),
    child: AutoCompleteTextField<String>(
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
        return item.toLowerCase().startsWith(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.compareTo(b);
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
