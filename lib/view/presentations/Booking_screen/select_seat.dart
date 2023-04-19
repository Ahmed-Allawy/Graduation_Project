import 'package:flutter/material.dart';
import '../../shared/component/components.dart';

class SelectSeat extends StatefulWidget {
  const SelectSeat({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  State<SelectSeat> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  double _screenWidth = 0;
  double _screenHeight = 0;

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
          'Seat Map',
        ),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child:
                Plane(screenHeight: _screenHeight, screenWidth: _screenWidth),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Selected seat',
            ),
            SizedBox(
              width: _screenWidth * 0.28,
            ),
            const Text(
              '22A',
            ),
          ],
        ),
        SizedBox(
          height: _screenHeight * 0.02,
        ),
        defaultButton(text: 'check out', onPressed: () {}),
      ]),
    );
  }
}

class Plane extends StatelessWidget {
  const Plane({
    super.key,
    required double screenHeight,
    required double screenWidth,
  })  : _screenHeight = screenHeight,
        _screenWidth = screenWidth;

  final double _screenHeight;
  final double _screenWidth;

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
        PlaneBody(screenHeight: _screenHeight, screenWidth: _screenWidth),
      ],
    );
  }
}

class PlaneBody extends StatelessWidget {
  const PlaneBody({
    super.key,
    required double screenHeight,
    required double screenWidth,
  })  : _screenHeight = screenHeight,
        _screenWidth = screenWidth;

  final double _screenHeight;
  final double _screenWidth;

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
      InnerPlane(screenHeight: _screenHeight, screenWidth: _screenWidth),
    ]);
  }
}

class InnerPlane extends StatelessWidget {
  const InnerPlane({
    super.key,
    required double screenHeight,
    required double screenWidth,
  })  : _screenHeight = screenHeight,
        _screenWidth = screenWidth;

  final double _screenHeight;
  final double _screenWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: _screenHeight * 0.15,
          ),
          const Text("Economy"),
          SizedBox(
            height: _screenHeight * 0.05,
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
                width: _screenWidth * 0.08,
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
                width: _screenWidth * 0.08,
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
          /////// this part will removed and replaced dynamicaly from database
          SizedBox(
            height: _screenHeight * 0.1,
          ),
          Seats(screenHeight: _screenHeight, screenWidth: _screenWidth),
          SizedBox(
            height: _screenHeight * 0.1,
          ),
          Seats(screenHeight: _screenHeight, screenWidth: _screenWidth),
          SizedBox(
            height: _screenHeight * 0.1,
          ),
          Seats(screenHeight: _screenHeight, screenWidth: _screenWidth),
          SizedBox(
            height: _screenHeight * 0.1,
          ),
          Seats(screenHeight: _screenHeight, screenWidth: _screenWidth),
          SizedBox(
            height: _screenHeight * 0.1,
          ),
          Seats(screenHeight: _screenHeight, screenWidth: _screenWidth),
          SizedBox(
            height: _screenHeight * 0.1,
          ),
          Seats(screenHeight: _screenHeight, screenWidth: _screenWidth),
          SizedBox(
            height: _screenHeight * 0.1,
          ),
          Seats(screenHeight: _screenHeight, screenWidth: _screenWidth),
        ],
      ),
    );
  }
}

/////// and this class also will removed
class Seats extends StatelessWidget {
  const Seats({
    super.key,
    required double screenHeight,
    required double screenWidth,
  })  : _screenHeight = screenHeight,
        _screenWidth = screenWidth;

  final double _screenHeight;
  final double _screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 30,
          color: Colors.red,
        ),
        SizedBox(
          width: _screenWidth * 0.03,
        ),
        Container(
          width: 30,
          height: 30,
          color: Colors.orange,
        ),
        SizedBox(
          width: _screenWidth * 0.03,
        ),
        Container(
          width: 30,
          height: 30,
          color: Colors.yellow,
        ),
        SizedBox(
          width: _screenWidth * 0.2,
        ),
        Container(
          width: 30,
          height: 30,
          color: Colors.green,
        ),
        SizedBox(
          width: _screenWidth * 0.03,
        ),
        Container(
          width: 30,
          height: 30,
          color: Colors.blue,
        ),
        SizedBox(
          width: _screenWidth * 0.03,
        ),
        Container(
          width: 30,
          height: 30,
          color: Colors.purple,
        ),
      ],
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
