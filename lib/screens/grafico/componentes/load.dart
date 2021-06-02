import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Load extends StatefulWidget {
  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load> {
  AnimationController animationController;

  List<Widget> lista = [
    SpinKitDualRing(
      color: Colors.white,
    ),
    SpinKitCircle(color: Colors.white),
    SpinKitChasingDots(
      color: Colors.white,
    ),
    SpinKitDoubleBounce(color: Colors.white),
    SpinKitFadingCube(
      color: Colors.white,
    ),
    SpinKitThreeBounce(
      color: Colors.white,
    ),
    SpinKitSquareCircle(
      duration: Duration(seconds: 1),
      color: Colors.white,
    ),
  ];
  int index = 0;
  @override
  void initState() {
    var random = Random();
    index = random.nextInt(lista.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: lista[index],
          height: 100,
        ),
        Text(
          "Falta alguns dados\nPrencha todos os campos da pagina dados.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            shadows: [
              BoxShadow(
                  offset: Offset(2, 2), blurRadius: 5, color: Colors.black54),
            ],
          ),
        ),
        SizedBox(height: 20),
        SizedBox(height: 20),
        SizedBox(height: 20),
      ],
    );
  }
}
