import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:get_it/get_it.dart';

import 'package:plan2/mobx/dados/mob_dados.dart';

class TextImputDado extends StatelessWidget {
  final String hint;

  final int id;
  final int tipo;
  final Function func;
  TextImputDado(this.hint, {this.id = 0, this.func, this.tipo});

  final Mob_dados mob_dados = GetIt.I<Mob_dados>();
  @override
  Widget build(BuildContext context) {
    final _controle = (tipo == 0)
        ? MaskedTextController(
            mask: '00:00',
            text: (mob_dados.horas[id] == '') ? null : mob_dados.horas[id])
        : (tipo == 1)
            ? TextEditingController(
                text: (mob_dados.tempoInstantaneo[id] == '')
                    ? null
                    : mob_dados.tempoInstantaneo[id])
            : TextEditingController(
                text: (mob_dados.leitura[id] == '')
                    ? null
                    : mob_dados.leitura[id]);
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: TextField(
        controller: _controle,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          border: InputBorder.none,
        ),
        onChanged: (valor) {
          func(valor, id);
        },
      ),
    );
  }
}
