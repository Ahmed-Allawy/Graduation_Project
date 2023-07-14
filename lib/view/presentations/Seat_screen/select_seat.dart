// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: library_private_types_in_public_api, duplicate_ignore, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation/model/seatsdata.dart';

import 'package:graduation/view/presentations/Searching_Screen/pics_screen.dart';
import 'package:graduation/view/presentations/Seat_screen/cubit/seat_cubit.dart';
import 'package:graduation/view/presentations/Seat_screen/cubit/seat_state.dart';

import 'package:graduation/view/shared/component/helperfunctions.dart';
import 'package:graduation/view/shared/network/local/cach_helper.dart';
import 'package:graduation/view/shared/network/payment/paypal.dart';

import '../../shared/component/components.dart';

class SelectSeat extends StatefulWidget {
  const SelectSeat({
    Key? key,
    required this.usersID,
    required this.classID,
    required this.price,
  }) : super(key: key);
  final List<String> usersID;
  final String classID;
  final double price;
  @override
  // ignore: library_private_types_in_public_api
  State<SelectSeat> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  double _screenWidth = 0;
  double _screenHeight = 0;
  List<SeatData> seatsList = [
    SeatData(
        status: 'not available',
        seatNo: '1A',
        id: '4722214f-f00f-46df-955a-ffb726836804'),
    SeatData(
        status: 'available',
        seatNo: '1B',
        id: '4722214f-f00f-46df-955a-ffb726836804'),
    SeatData(
        status: 'not available',
        seatNo: '1C',
        id: '4722214f-f00f-46df-955a-ffb726836804'),
    SeatData(
        status: 'available',
        seatNo: '1D',
        id: '4722214f-f00f-46df-955a-ffb726836804'),
    SeatData(status: 'not available', seatNo: '2A', id: ''),
    SeatData(status: 'available', seatNo: '2B', id: ''),
    SeatData(status: 'available', seatNo: '2C', id: ''),
    SeatData(status: 'not available', seatNo: '2D', id: ''),
    SeatData(status: 'not available', seatNo: '3A', id: ''),
    SeatData(status: 'available', seatNo: '3B', id: ''),
    SeatData(status: 'not available', seatNo: '3C', id: ''),
    SeatData(status: 'available', seatNo: '3D', id: ''),
    SeatData(status: 'not available', seatNo: '4A', id: ''),
    SeatData(status: 'available', seatNo: '4B', id: ''),
    SeatData(status: 'available', seatNo: '4C', id: ''),
    SeatData(status: 'not available', seatNo: '4D', id: ''),
    SeatData(status: 'not available', seatNo: '5A', id: ''),
    SeatData(status: 'available', seatNo: '5B', id: ''),
    SeatData(status: 'not available', seatNo: '5C', id: ''),
    SeatData(status: 'available', seatNo: '5D', id: ''),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _screenWidth = MediaQuery.of(context).size.width;
        _screenHeight = MediaQuery.of(context).size.height;
        // SeatCubit.get(context).fetchSeatsData(widget.classID).then((value) {
        //   SeatCubit.get(context).seats = value;
        // });
        SeatCubit.get(context).seats = seatsList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: const Color(0xc61859ba),
        centerTitle: true,
        title: const Text(
          'Select Seat',
        ),
        leading: BackButton(
          onPressed: () {
            nextScreenRep(
                context,
                PicScreen(
                  token: const [],
                  firstnames: const [],
                ));
          },
        ),
      ),
      body: BlocConsumer<SeatCubit, SeatState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
                    child: Plane(
              screenHeight: _screenHeight,
              screenWidth: _screenWidth,
              number: widget.usersID.length,
              seatsList: SeatCubit.get(context).seats,
            ))),
            SizedBox(
              height: _screenHeight * 0.02,
            ),
            defaultButton(
                text: 'check out',
                onPressed: () {
                  // print(
                  //   CacheHelper.getData(key: 'seletedSeats').runtimeType,
                  // );
                  if (SeatCubit.get(context).selectedSeatsID.isNotEmpty) {
                    SeatCubit.get(context).postSeatsUsers(
                        SeatCubit.get(context).selectedSeatsID, widget.usersID);
                    nextScreen(
                        context,
                        CheckoutPage(
                          price: widget.price,
                          quantity: widget.usersID.length,
                        ));
                  }
                }),
          ]);
        },
      ),
    );
  }
}

class Plane extends StatelessWidget {
  const Plane({
    super.key,
    required double screenHeight,
    required double screenWidth,
    required this.seatsList,
    required this.number,
  })  : _screenHeight = screenHeight,
        _screenWidth = screenWidth;

  final double _screenHeight;
  final double _screenWidth;
  final List<SeatData> seatsList;
  final int number;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: _screenHeight * 0.36,
              color: const Color(0xc61859ba),
            ),
            SizedBox(
              height: _screenHeight * 0.3,
              width: double.infinity,
              child: CustomPaint(
                painter: _HeaderWavesPainter(),
              ),
            )
          ],
        ),
        PlaneBody(
            screenHeight: _screenHeight,
            screenWidth: _screenWidth,
            number: number,
            seatsList: seatsList),
      ],
    );
  }
}

class PlaneBody extends StatelessWidget {
  const PlaneBody({
    super.key,
    required double screenHeight,
    required double screenWidth,
    required this.seatsList,
    required this.number,
  })  : _screenHeight = screenHeight,
        _screenWidth = screenWidth;

  final double _screenHeight;
  final double _screenWidth;
  final List<SeatData> seatsList;
  final int number;
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Column(
        children: <Widget>[
          SizedBox(
            height: _screenHeight * 0.1,
          ),
          Center(
            child: SizedBox(
              width: _screenWidth * 0.89,
              height: _screenHeight * 0.7,
              child: CustomPaint(
                painter: _HeaderWavesPainter2(),
              ),
            ),
          ),
        ],
      ),
      InnerPlane(
        screenHeight: _screenHeight,
        screenWidth: _screenWidth,
        number: number,
        seatsList: seatsList,
      ),
    ]);
  }
}

class InnerPlane extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final List<SeatData> seatsList;
  final int number;
  const InnerPlane({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.seatsList,
    required this.number,
  }) : super(key: key);

  @override
  _InnerPlaneState createState() => _InnerPlaneState();
}

class _InnerPlaneState extends State<InnerPlane> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        SizedBox(
          height: widget.screenHeight * 0.3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: const BoxDecoration(
                    color: Color(0xffD9D9D9),
                    shape: BoxShape.circle,
                  ),
                ),
                const Text("not available"),
              ],
            ),
            SizedBox(
              width: widget.screenWidth * 0.06,
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: const BoxDecoration(
                    color: Color(0xff2FE0EB),
                    shape: BoxShape.circle,
                  ),
                ),
                const Text("available"),
              ],
            ),
            SizedBox(
              width: widget.screenWidth * 0.08,
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: const BoxDecoration(
                    color: Color(0xffD91313),
                    shape: BoxShape.circle,
                  ),
                ),
                const Text("selected"),
              ],
            ),
          ],
        ),
        SizedBox(
          height: widget.screenHeight * 0.1,
        ),
        SizedBox(
          height: 300,
          child: Seats(
            seatsList: widget.seatsList,
            peopleNumber: widget.number,
          ),
        ),
      ]),
    );
  }
}

class Seats extends StatefulWidget {
  const Seats({
    Key? key,
    required this.seatsList,
    required this.peopleNumber,
  }) : super(key: key);

  final List<SeatData> seatsList;
  final int peopleNumber;

  @override
  _SeatsState createState() => _SeatsState();
}

class _SeatsState extends State<Seats> {
  List<int> selectedSeatsIndexes = [];
  List<String> AllSelectedSeats = [];

  void _toggleSeatSelection(int index) {
    setState(() {
      if (selectedSeatsIndexes.contains(index)) {
        selectedSeatsIndexes.remove(index);
      } else if (selectedSeatsIndexes.length < widget.peopleNumber) {
        selectedSeatsIndexes.add(index);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    AllSelectedSeats.removeRange(0, AllSelectedSeats.length);
  }

  @override
  Widget build(BuildContext context) {
    CacheHelper.init();
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
      ),
      itemCount: widget.seatsList.length,
      itemBuilder: (BuildContext context, int index) {
        final seat = widget.seatsList[index];
        final seatState = seat.status;
        final isSelected = selectedSeatsIndexes.contains(index);
        final isSelectable = seatState != 'not available' &&
            (isSelected || selectedSeatsIndexes.length < widget.peopleNumber);

        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(bottom: 20),
          child: MaterialButton(
            onPressed: () {
              isSelectable ? _toggleSeatSelection(index) : null;
              if (selectedSeatsIndexes.length == widget.peopleNumber) {
                AllSelectedSeats.removeRange(0, AllSelectedSeats.length);
                for (var element in selectedSeatsIndexes) {
                  print(widget.seatsList[element].id);
                  AllSelectedSeats.add(widget.seatsList[element].id);
                }
                SeatCubit.get(context).selectedSeatsID = AllSelectedSeats;
                print(selectedSeatsIndexes.length);
                // CacheHelper.saveData(
                //     key: 'seletedSeats',
                //     value: AllSelectedSeatsName.toString());
              }
            },
            color: seatState == 'not available'
                ? const Color(0xffD9D9D9)
                : isSelected
                    ? Colors.red
                    : const Color(0xff2FE0EB),
            textColor: Colors.white,
            child: Text(
              seat.seatNo,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isSelected ? 20 : 16,
                decoration:
                    isSelected ? TextDecoration.none : TextDecoration.underline,
                decorationColor: Colors.white,
                decorationThickness: isSelected ? 4 : 0,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HeaderWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = const Color(0xffd9d9d9);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    final path = Path();

    path.lineTo(0, size.height * 1.5);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.30, size.width, size.height * 1.5);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _HeaderWavesPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = const Color(0xffffffff);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    final path = Path();
    path.moveTo(0, size.height * 0.45);
    path.quadraticBezierTo(
        size.width * 0.5, -size.height * 0.50, size.width, size.height * 0.45);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.35);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
