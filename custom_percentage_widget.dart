/// This is a Custom Percentage Widget. With the help of this library
/// you can show you progress in a circular loader, with an animation.
/// @Author: Muntasir Billah Munna
/// @github: https://gitlab.com/kmmuntasir/flutter_custom_circular_loader
/// @email: kmmuntasir@gmail.com
///
/// This loader was inspired by and heavily modified from flutter pub circular_custom_loader 1.0.6
/// URL: https://pub.dev/packages/circular_custom_loader

import 'package:flutter/material.dart';
import 'dart:math';

class CustomCircularLoader extends StatefulWidget {
  CustomCircularLoader({
    @required this.coveredPercent,
    this.initVal,
    this.gap,
    this.circleStart,
    this.headerInBottom,
    this.circleContent,
    this.noHeader,
    @required this.circleSize,
    @required this.circleWidth,
    @required this.circleColor,
    @required this.coveredCircleColor,
    this.circleHeader,
    this.unit,
    this.coveredPercentStyle,
    this.circleHeaderStyle,
  })  : assert(coveredPercent != null),
        assert(circleSize != null),
        assert(circleWidth != null),
        assert(circleColor != null),
        assert(coveredCircleColor != null);

  // The percentage status of the loader
  final double coveredPercent;

  final String initVal;

  // The gap between the percentage text and the widget header text
  final double gap;

  // Denotes where the loader starts from, the top of the circle, bottom, left
  // or right
  final String circleStart;

  // If true, the header will show below the percentage text
  final bool headerInBottom;

  // If a Widget is provided explicitly as circleContent, the percentage text
  // and header will not be shown, instead the provided content will be
  // shown in the circle
  final Widget circleContent;

  // If set to true, only percentage text will be shown
  final bool noHeader;

  // Circle Widget size
  final double circleSize;

  // Width of the border of the loader arc
  final double circleWidth;

  // Color of the border of the loader arc
  final Color circleColor;

  // Color of the covered part of the border of the loader arc
  final Color coveredCircleColor;

  // The header text inside the circle
  // If noHeader is set to false (not provided), circleHeader must be provided
  final String circleHeader;

  // The unit character for percentage display (default is '%')
  final String unit;

  // Text style for Percentage Text
  final TextStyle coveredPercentStyle;

  // Text style for circle header Text
  final TextStyle circleHeaderStyle;

  @override
  _CircularLoader createState() => _CircularLoader();

}

class _CircularLoader extends State<CustomCircularLoader> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController controller;
  double percentValue = 10;


  double innerCircleRadius;
  double containerSize;
  double circleStartPoint = 1.5;

  @override
  void initState() {
    super.initState();

    innerCircleRadius = (widget.circleSize - (2 * widget.circleWidth))/2;
    containerSize = sqrt(2 * innerCircleRadius * innerCircleRadius);

    if(widget.circleStart == "top") circleStartPoint = 1.5;
    else if(widget.circleStart == "bottom") circleStartPoint = 0.5;
    else if(widget.circleStart == "right") circleStartPoint = 2;
    else if(widget.circleStart == "left") circleStartPoint = 1;
    else circleStartPoint = 1.5;

    controller = AnimationController(
        duration: Duration(milliseconds: 1000),
        vsync: this
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    _animation = Tween(begin: 0.0, end: widget.coveredPercent).animate(controller)
      ..addListener(() {
        setState(() {
          percentValue = _animation.value;
        });
      });

    return Container(
      width: widget.circleSize,
      height: widget.circleSize,
      child: Stack(
        alignment: const Alignment(0.0, 0.0),
        children: <Widget>[
          SizedBox(
            width: widget.circleSize,
            height: widget.circleSize,
            child: CustomPaint(
              painter: GenericCircle(
                circleColor: widget.circleColor,
                coveredColor: widget.coveredCircleColor,
                coveredPercent: percentValue,
                otherVal: widget.initVal,
                circleWidth: widget.circleWidth,
                variance: 0,
                circleStartPoint: circleStartPoint,
              ),
            ),
          ),
          Container(
              width: containerSize,
              height: containerSize,
              child: (widget.circleContent != null) ? widget.circleContent : defaultContent(),
          ),
        ],
      ),
    );
  }

  Widget defaultContent() {
    Widget percentageText = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          percentValue.toInt().toString(),
          style: widget.coveredPercentStyle,
        ),
        Text(
            (widget.unit != null) ? widget.unit : "%",
            style: widget.coveredPercentStyle
        ),
      ],
    );

    Widget headerText = (widget.noHeader != null && widget.noHeader != false) ? Container() : Text(
      widget.circleHeader,
      textAlign: TextAlign.center,
      style: widget.circleHeaderStyle,
    );

    Widget defaultContentWidget = Column();
    if(widget.headerInBottom != null && widget.headerInBottom != false) {
      defaultContentWidget = Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          percentageText,
          SizedBox(height: (widget.gap != null) ? widget.gap : 10),
          headerText,
        ],
      );
    }
    else {
      defaultContentWidget = Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          headerText,
          SizedBox(height: (widget.gap != null) ? widget.gap : 10),
          percentageText,
        ],
      );
    }

    return defaultContentWidget;
  }
}

class GenericCircle extends CustomPainter {
  GenericCircle({
    this.circleColor,
    this.coveredColor,
    this.coveredPercent,
    this.circleWidth,
    this.otherVal,
    this.variance,
    this.circleStartPoint,
  });

  final Color circleColor;
  final Color coveredColor;
  final double coveredPercent;
  final double circleWidth;
  final String otherVal;
  final double variance;
  final double circleStartPoint;

  @override
  void paint(Canvas canvas, Size size) {

    final circle = Paint()
      ..color = circleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth;

    final coveredPath = Paint()
      ..color = coveredColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth;

    final center = new Offset(size.width / 2, size.height / 2);

    final radius = min((size.width - circleWidth - variance) / 2,
        (size.height - circleWidth - variance) / 2);
    canvas.drawCircle(center, radius, circle); //Circle drawn.....

    final arcAngle =
    otherVal != null ? 2 * pi * 0 : 2 * pi * (coveredPercent / 100);

    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), pi * circleStartPoint,
        arcAngle, false, coveredPath);
  }

  @override
  bool shouldRepaint(GenericCircle oldDelegate) {
    return oldDelegate.coveredPercent != coveredPercent;
  }
}
