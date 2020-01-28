import 'package:flutter/material.dart';
import 'package:PainterTest2/features/widgets/scrolling_four_charts.dart';

class PlacementPage extends StatefulWidget {
  @override
  _PlacementPageState createState() => _PlacementPageState();
}

class _PlacementPageState extends State<PlacementPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'This is a scrolling chart',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.0, fontWeight: FontWeight.bold, height: 2),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text('Sometimes it is not smooth',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, height: 2)),
        ),
        Expanded(
          flex: 5,
          child: Container(),
        ),
        Expanded(flex: 12, child: Charts()),
        Expanded(
            flex: 4,
            child: Container(
              child: StatusRow(),
            )),
      ],
    );
  }
}

class StatusRow extends StatelessWidget {
  const StatusRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: CustomPaint(
              painter: DrawCircle(color: 0xFFA8A8A8),
              child: SizedBox(width: 20, height: 20)),
        ),
        Text('aa'),
        Container(
          child: CustomPaint(
              painter: DrawCircle(color: 0xFFFEAB20),
              child: SizedBox(width: 20, height: 20)),
        ),
        Text('bb'),
        Container(
          child: CustomPaint(
              painter: DrawCircle(color: 0xFF3BC584),
              child: SizedBox(width: 20, height: 20)),
        ),
        Text('cc'),
      ],
    );
  }
}

class DrawCircle extends CustomPainter {
  Paint _paint;

  DrawCircle({int color}) {
    _paint = Paint()
      ..color = Color(color)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 4.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Charts extends StatelessWidget {
  const Charts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ScrollingFourChartsWidget(
                  valuesPerFill: 50, valuesOnChart: 100, bufferFillPeriod: 500),
            ),
          ],
        ),
      ],
    );
  }
}
