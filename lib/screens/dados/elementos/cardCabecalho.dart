import 'package:flutter/material.dart';

class Cabecalho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black45, offset: Offset(2, 3), blurRadius: 10)
      ]),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Horas (hh:mm)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              color: Colors.black38,
              width: 1,
              height: 30,
            ),
            Text(
              "Tempo Inst. (min)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              color: Colors.black38,
              width: 1,
              height: 30,
            ),
            Text(
              "Leitura (cm)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ]),
    );
  }
}
