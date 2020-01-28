import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math' as math;


const int RESTART_SCROLL_MUL = 200;

class ScrollingFourChartsWidget extends StatefulWidget {
  /// @param dataStreamSpeed means sample numbers per second
  /// @param valuesOnChart means how many samples are visible at once on a chart
  /// @param bufferFillPeriod means how often in millisecondsbuffer is asked to be filled
  ScrollingFourChartsWidget(
      {Key key, this.valuesPerFill, this.valuesOnChart, this.bufferFillPeriod})
      : super(key: key);

  final int valuesPerFill;
  final double valuesOnChart;
  final int bufferFillPeriod;

  @override
  _ScrollingFourChartsWidgetState createState() =>
      _ScrollingFourChartsWidgetState();
}

class _ScrollingFourChartsWidgetState extends State<ScrollingFourChartsWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  Tween<double> _tween;
  AnimationController _animationController;
  math.Random _random = math.Random();

  List<List<double>> valuesArr = List<List<double>>();

  final ValueNotifier<double> ch = new ValueNotifier(0);

  int offset = 0;


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void fuelBufferWithData(int samplesCount) {
    for (int nb = 0; nb < 4; nb++) {
      List<double> values = valuesArr[nb];

      int l = values.length - samplesCount;
      int x = 0;
      // move content of our values buffer first
      while (x < l) {
        values[x] = values[x + samplesCount];
        x++;
      }

      l = values.length;
      // if no data - fill with zeros
      while (x < l) {
        values[x] = _random.nextDouble() / 2 + 0.25;
        x++;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print("scrollingfourcharts.initState called");
    // buffer must be big enough so we won't see values being added in groups
    int cnt = widget.valuesOnChart.round() + widget.valuesPerFill;
    for (int nb = 0; nb < 4; nb++) {
      valuesArr.add(List<double>());
      for (int x = 0; x < cnt; x++) {
        valuesArr[nb].add(0);
      }
    }

    _animationController = AnimationController(
        duration: Duration(
            milliseconds: (widget.bufferFillPeriod * RESTART_SCROLL_MUL)),
        vsync: this);
    _tween = Tween(
        begin: 0.0, end: widget.valuesPerFill * RESTART_SCROLL_MUL.toDouble());
    _animation = _tween.animate(_animationController)
      ..addListener(() {
        if (_animation.value - offset > widget.valuesPerFill) {
          offset += widget.valuesPerFill;
          fuelBufferWithData(widget.valuesPerFill);
        }
        ch.value = _animation.value - offset;
        //ch.notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          restartScroll();
        }
      });
    restartScroll();

    
  }

  void restartScroll() {
    offset = 0;
    _tween.begin = 0;
    _animationController.reset();
    _tween.end = widget.valuesPerFill * RESTART_SCROLL_MUL.toDouble();
    _animationController.forward();
    fuelBufferWithData(widget.valuesPerFill);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Row(children: <Widget>[
        Expanded(
          child: Container(
            child: RepaintBoundary(
              child: CustomPaint(
                  child: Container(),
                  isComplex: false,
                  willChange: false,
                  foregroundPainter: ShapesPainter(
                      ch,
                      _animation.value - offset,
                      valuesArr,
                      widget.valuesOnChart)),
            ),
          ),
        ),
      ]),
    );
  }
}

class ShapesPainter extends CustomPainter {
  final double scrollValue;
  final List<List<double>> valuesArr;
  final double valuesOnChart;

  ValueNotifier vn;

  ShapesPainter(this.vn, this.scrollValue, this.valuesArr, this.valuesOnChart)
      : super(repaint: vn);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade600
      ..isAntiAlias = !true
      ..strokeWidth = 0.9
      ..style = PaintingStyle.stroke;
    //..strokeCap = StrokeCap.square;

    double scrollValue = vn.value;

    double x = 0 - scrollValue; // * 1/xtmp;

    double ftmp = size.width / this.valuesOnChart;

    int i = 0;
    if (x < -ftmp) {
      int skip = -x ~/ ftmp;
      i += skip;
      x += skip;
    }

    if (Platform.isIOS) {
      double xcopy = x;
      int icopy = i;

      for (int q = 0; q < 4; q++) {
        x = xcopy;
        i = icopy;

        double ypos = (q + 1) * size.height / 4;
        double sizeHeight = size.height / 4;

        for (; i < valuesArr[q].length - 1; i++) {
          double x0 = x * ftmp;
          double y0 = ypos - valuesArr[q][i] * sizeHeight;

          double x1 = (x + 1) * ftmp;
          double y1 = ypos - valuesArr[q][i + 1] * sizeHeight;

          if ((x1 >= 0) &&
              (x0 >= 0) &&
              (x0 < size.width) &&
              (x1 < size.width)) {
            final p1 = Offset(x0, y0);
            final p2 = Offset(x1, y1);
            canvas.drawLine(p1, p2, paint);
          }
          if (x0 >= size.width) break;

          x += 1;
        }
      }
    } else {
      int point_cnt = 0;
      Path path = Path();

      double xcopy = x;
      int icopy = i;

      for (int q = 0; q < 4; q++) {
        x = xcopy;
        i = icopy;

        double ypos = (q + 1) * size.height / 4;
        double sizeHeight = size.height / 4;
        bool isPathEmpty = true;

        for (; i < valuesArr[q].length; i++) {
          double x0 = x * ftmp;
          double y0 = ypos - valuesArr[q][i] * sizeHeight;

          if ((x0 >= 0) && (x0 < size.width)) {
            if (isPathEmpty) {
              path.moveTo(x0, y0);
              isPathEmpty = false;
            } else {
              path.lineTo(x0, y0);
              point_cnt++;
            }
          }
          if (x0 >= size.width) break;

          x += 1;
        }
      }
      canvas.drawPath(path, paint);
      //print("draw point_cnt="+point_cnt.toString());
    }
  }

  @override
  bool shouldRepaint(ShapesPainter oldDelegate) {
    return true; //(oldDelegate.scrollValue != scrollValue);
  }
}
