import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:plan2/mobx/dados/mob_dados.dart';
import 'package:plan2/mobx/grafico/mob_grafico.dart';
import 'package:plan2/screens/dados/elementos/cardCabecalho.dart';
import 'package:plan2/screens/grafico/grafico.dart';

import 'elementos/card_imput.dart';

class Dados extends StatefulWidget {
  @override
  _DadosState createState() => _DadosState();
}

class _DadosState extends State<Dados> {
  final Mob_dados mob_dados = GetIt.I<Mob_dados>();
  final Mob_Grafico mob_grafico = GetIt.I<Mob_Grafico>();
  Future<void> carregaa() async {
    await mob_grafico.carrega();
  }

  Future<void> carregaadados() async {
    await mob_dados.calcular();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    carregaadados();
    carregaa();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Cabecalho(),
        /*
        Observer(builder: (_) {
          return Container(
            height: mob_dados.qtd * 100 + 0.0,
            child: Expanded(
              child: ListView.builder(
                  itemCount: mob_dados.horas.length,
                  itemBuilder: (context, index) {
                    return ImputDado('mob_dados.horas[0]');
                  }),
            ),
          );
        }),
        */
        Observer(builder: (_) {
          return Expanded(
            child: ListView.builder(
                itemCount: mob_dados.qtd,
                itemBuilder: (context, index) {
                  return ImputDado(index);
                }),
          );
        }),
      ]),
    );
  }
}
