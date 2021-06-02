import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:plan2/mobx/dados/mob_dados.dart';
import 'package:plan2/screens/dados/elementos/imput.dart';

class ImputDado extends StatelessWidget {
  int dado;
  ImputDado(this.dado);
  final Mob_dados mob_dados = GetIt.I<Mob_dados>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black45, offset: Offset(2, 3), blurRadius: 10)
          ]),
      margin: EdgeInsets.only(top: 4, left: 10, right: 10, bottom: 4),
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: TextImputDado(
            '00:00',
            id: dado,
            func: mob_dados.escreveHora,
            tipo: 0,
          )),
          Expanded(
              child: TextImputDado(
            '0',
            id: dado,
            func: mob_dados.escreveTempo,
            tipo: 1,
          )),
          Expanded(
              child: TextImputDado(
            '0.0',
            id: dado,
            func: mob_dados.escreveLeitura,
            tipo: 2,
          ))
        ],
      ),
    );
  }
}
