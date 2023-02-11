import 'package:flutter/material.dart';
import 'package:graduation/modules/login/screen_size.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = ScreenSize(context);

    return Scaffold(
      backgroundColor: const Color(0xff2B42FB),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                // height: height,
                color: Colors.red,
                child: Image.asset(
                  'assets/images/3ef2582ea94414801edc3f61e80ee4c5.gif',
                  height: screenSize.getHeigth(428),
                  fit: BoxFit.fill,
                ),
                // child: Text(
                //   currentWidth.toString(),
                //   style: TextStyle(color: Colors.green, fontSize: 30),
                // ),
              ),
              SizedBox(
                height: screenSize.getHeigth(22),
              ),
              Text(
                'Welcome',
                style: TextStyle(
                    color: const Color(0xffFFFFFF),
                    fontSize: screenSize.getWidth(24)),
              ),
              SizedBox(
                height: screenSize.getHeigth(35),
              ),
              Container(
                width: screenSize.getWidth(256),
                color: const Color(0xffFFFFFF),
                child: const TextField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.personal_injury_rounded),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Color(0xff727171)),
                        iconColor: Color(0xffA4A4A4))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
