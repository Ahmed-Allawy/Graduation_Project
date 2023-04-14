import 'package:flutter/material.dart';
import 'package:graduation/view/shared/component/components.dart';
import 'package:graduation/view/shared/component/device_size.dart';

class SelectSeat extends StatefulWidget {
  const SelectSeat({super.key});

  @override
  State<SelectSeat> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  @override
  Widget build(BuildContext context) {
    LayoutSize().init(context);
    return Scaffold(
      backgroundColor: const Color(0xffffffff), //const Color(0xffd9d9d9),
      appBar: AppBar(
        backgroundColor: const Color(0xc61859ba),
        centerTitle: true,
        title: const Text(
          'Seat Map',
        ),
      ),
      body: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 0.36 * LayoutSize.layoutValue!,
              color: const Color(0xc61859ba),
            ),
            SizedBox(
              height: 0.3 * LayoutSize.layoutValue!,
              width: double.infinity,
              child: CustomPaint(
                painter: _HeaderWavesPainter(),
              ),
            )
          ],
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 0.1 * LayoutSize.layoutValue!,
            ),
            Center(
              child: SizedBox(
                width: 0.89 * LayoutSize.layoutValue!,
                height: 0.95 * LayoutSize.layoutValue!,
                child: CustomPaint(
                  painter: _HeaderWavesPainter2(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Selected seat',
                ),
                SizedBox(
                  width: 0.5 * LayoutSize.layoutValue!,
                ),
                const Text(
                  '22A',
                ),
              ],
            ),
            SizedBox(
              height: 0.08 * LayoutSize.layoutValue!,
            ),
            defaultButton(text: 'check out', onPressed: () {})
          ],
        ),
        Center(
          child: Container(
            height: 30,
            width: 100,
            color: Colors.red,
          ),
        )
      ]),
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
