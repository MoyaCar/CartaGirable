import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CartaFlip extends StatefulWidget {
  ///child Widget que figurará centrado en la cara frontal
  ///de la CartaFlip.(ej Text(¨Frente¨))
  final Widget frontChild;

  ///Widget que figurará centrado en la cara trasera
  ///de la CartaFlip.(ej Text(¨Trasero¨))
  final Widget backChild;

  ///Color frontal de la CartaFlip, si no se coloca
  ///usará Amber por defecto.(ej. Colors.black)
  final Color frontColor;

  ///Color trasero de la CartaFlip, si no se coloca
  ///usará Grey por defecto.(ej. Colors.white)
  final Color backColor;

  ///Valor del ancho  de  la tarjeta flip, si no se especifica
  ///utilizará por defecto 150
  final double width;

  ///Valor del alto  de  la tarjeta flip, si no se especifica
  ///utilizará por defecto 150
  final double height;

  ///Duracion de la animación en millisegundos, si no se especifica
  ///utilizará por defecto 300
  final int milliseconds;

  ///Implementa que la Flip Card gire una unica vez y quede con su
  ///lado trasero fijo. Si no se especifica utilizará false por defecto.
  final bool oneTimeOnly;

  const CartaFlip({
    Key key,
    this.frontChild,
    this.backChild,
    this.frontColor = Colors.amber,
    this.backColor = Colors.grey,
    this.width = 150,
    this.height = 150,
    this.milliseconds = 300,
    this.oneTimeOnly = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CartaFlipState(
        frontChild: frontChild,
        backChild: backChild,
        frontColor: frontColor,
        backColor: backColor,
        width: width,
        height: height,
        millisecons: milliseconds,
        oneTimeOnly: oneTimeOnly);
  }
}

class CartaFlipState extends State<CartaFlip> with TickerProviderStateMixin {
  final Widget frontChild;
  final Widget backChild;
  final Color frontColor;
  final Color backColor;
  final double width;
  final double height;
  final int millisecons;
  final bool oneTimeOnly;

  AnimationController _controlDeGiroDeCarta;
  Animation<double> _animacionDeGiroDeCarta;
  double comienzoDeAnimacion = 3.14;
  double finDeAnimacion = 0;

  CartaFlipState({
    this.oneTimeOnly, 
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
        oneTimeOnly?_controlDeGiroDeCarta.forward():
        _animacionDeGiroDeCarta.isCompleted
            ? _controlDeGiroDeCarta.reverse()
            : _controlDeGiroDeCarta.forward();
      },
      child: Transform(
        /* Matriz de transformacion que genera el giro sobre el eje X,
        de cero a pi genera un giro completo */
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
                  //utilizacion de un metodo para acomodar la posicion del Widget child.
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
        child: Transform(
          child: front,
          transform: Matrix4.identity()..setEntry(3, 2, 0.0001)..rotateY(3.1415),
          alignment:FractionalOffset.center,
        ),
      );
}
