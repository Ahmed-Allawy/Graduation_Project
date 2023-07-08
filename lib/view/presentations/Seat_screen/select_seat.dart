// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: library_private_types_in_public_api, duplicate_ignore, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation/view/presentations/Searching_Screen/pics_screen.dart';
import 'package:graduation/view/presentations/Seat_screen/cubit/seat_cubit.dart';
import 'package:graduation/view/presentations/Seat_screen/cubit/seat_state.dart';
import 'package:graduation/view/presentations/ticket/ticket.dart';
import 'package:graduation/view/shared/component/helperfunctions.dart';
import 'package:graduation/view/shared/network/local/cach_helper.dart';

import '../../shared/component/components.dart';

class SelectSeat extends StatefulWidget {
  const SelectSeat({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  State<SelectSeat> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  double _screenWidth = 0;
  double _screenHeight = 0;
  List seatsList = [
    {
      'position': '1B',
      'state': 'available',
      'id': '4722214f-f00f-46df-955a-ffb726836804'
    },
    {
      'position': '1B',
      'state': 'not available',
      'id': '4722214f-f00f-46df-955a-ffb726836804435t33'
    },
    {
      'position': '1B',
      'state': 'not available',
      'id': '4722214f-f00f-46df-955a-ffb72683'
    },
    {
      'position': '1B',
      'state': 'not available',
      'id': '4722sds214f-f00f-46df-955a-ffb726836804'
    },
    {
      'position': '2B',
      'state': 'available',
      'id': '435t4722214f-f00f-46df-955a-ffb726836804adad33'
    },
  ];
  List<String> usersID = [
    "35d84bf1-995e-435d-8221-add745525ebd",
    "cf793d93-e26f-4cc2-a806-b3d604bd5a54"
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _screenWidth = MediaQuery.of(context).size.width;
        _screenHeight = MediaQuery.of(context).size.height;
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
                  person: const [],
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
              number: usersID.length,
              seatsList: seatsList,
            ))),
            SizedBox(
              height: _screenHeight * 0.02,
            ),
            defaultButton(
                text: 'check out',
                onPressed: () {
                  print(
                    CacheHelper.getData(key: 'seletedSeats').runtimeType,
                  );

                  SeatCubit.get(context).postSeatsUsers(
                      CacheHelper.getData(key: 'seletedSeats'), usersID);
                  String s = CacheHelper.getData(key: 'seletedSeats');
                  if (s.isNotEmpty) {
                    nextScreen(context, const Ticket());
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
  final List seatsList;
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
  final List seatsList;
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
  final List seatsList;
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

  final List seatsList;
  final int peopleNumber;

  @override
  _SeatsState createState() => _SeatsState();
}

class _SeatsState extends State<Seats> {
  List<int> selectedSeatsIndexes = [];

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
  Widget build(BuildContext context) {
    List<String> AllSelectedSeats = [];
    List<String> AllSelectedSeatsName = [];
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
        final seatState = seat['state'];
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
                for (var element in selectedSeatsIndexes) {
                  print(widget.seatsList[element]['id']);
                  AllSelectedSeats.add(widget.seatsList[element]['id']);
                  AllSelectedSeatsName.add(
                      widget.seatsList[element]['position']);
                }
                CacheHelper.saveData(
                    key: 'seletedSeats',
                    value: AllSelectedSeatsName.toString());
              }
            },
            color: seatState == 'not available'
                ? const Color(0xffD9D9D9)
                : isSelected
                    ? Colors.red
                    : const Color(0xff2FE0EB),
            textColor: Colors.white,
            child: Text(
              seat['position'],
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
