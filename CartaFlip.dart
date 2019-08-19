import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Carta2 extends StatefulWidget {
  final Widget frontChild;
  final Widget backChild;
  final Color frontColor;
  final Color backColor;
  final double width;
  final double height;
  final int milliseconds;

  const Carta2({
    Key key,
    this.frontChild,
    this.backChild,
    this.frontColor = Colors.amber,
    this.backColor = Colors.black38,
    this.width = 150,
    this.height = 150,
    this.milliseconds = 300,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Carta2State(
        frontChild: frontChild,
        backChild: backChild,
        frontColor: frontColor,
        backColor: backColor,
        width: width,
        height: height,
        millisecons: milliseconds);
  }
}

class Carta2State extends State<Carta2> with TickerProviderStateMixin {
  final Widget frontChild;
  final Widget backChild;
  final Color frontColor;
  final Color backColor;
  final double width;
  final double height;
  final int millisecons;

  AnimationController _controlDeGiroDeCarta;
  Animation<double> _animacionDeGiroDeCarta;
  double comienzoDeAnimacion = 3.14;
  double finDeAnimacion = 0;

  Carta2State({
      this.frontChild,
      this.backChild, 
      this.backColor,
      this.frontColor,
      this.width,
      this.height,
      this.millisecons,
      });

  @override
  void initState() {
    super.initState();

    _controlDeGiroDeCarta = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: millisecons),
    );

    _animacionDeGiroDeCarta =
        Tween<double>(begin: comienzoDeAnimacion, end: finDeAnimacion)
            .animate(_controlDeGiroDeCarta)
              ..addListener(() {
                setState(() {});
              });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _animacionDeGiroDeCarta.isCompleted
            ? _controlDeGiroDeCarta.reverse()
            : _controlDeGiroDeCarta.forward();
      },
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0006)
          ..rotateX(_animacionDeGiroDeCarta.value),
        alignment: Alignment.center,
        child: Container(
          width: width,
          height: height,
          child: Card(
            borderOnForeground: false,
            color: _animacionDeGiroDeCarta.value > (comienzoDeAnimacion / 2)
                ? frontColor
                : backColor,
            child: Center(
              child: _animacionDeGiroDeCarta.value > (comienzoDeAnimacion / 2)
                  ? frontchild(frontChild)
                  : backChild,
            ),
          ),
        ),
      ),
    );
  }

  Widget frontchild(Widget front) => Transform.rotate(
    angle: 3.14159,
    child: front,
  );
}
