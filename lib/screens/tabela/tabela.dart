import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:plan2/mobx/grafico/mob_grafico.dart';
import 'package:plan2/screens/grafico/componentes/load.dart';
import 'package:plan2/screens/grafico/grafico.dart';

final Mob_Grafico mob_grafico = GetIt.I<Mob_Grafico>();

class Tabela extends StatefulWidget {
  @override
  _TabelaState createState() => _TabelaState();
}

Future<void> carregaa() async {
  await mob_grafico.carrega();
}

class _TabelaState extends State<Tabela> {
  int conta = 0;

  int index = 0;

  int indeCo = 0;

  @override
  void initState() {
    carregaa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.amber,
      child: Observer(builder: (_) {
        return (mob_dados.load)
            ? Load()
            : SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Observer(builder: (_) {
                    return Padding(
                      padding: EdgeInsets.all(5),
                      child: DataTable(
                        columnSpacing: 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45,
                                offset: Offset(2, 3),
                                blurRadius: 10)
                          ],
                        ),
                        columns: mob_grafico.coluna.map((data) {
                          return DataColumn(
                            label: Center(child: Text(data)),
                          );
                        }).toList(),
                        rows: mob_grafico.linha.map((data) {
                          conta = 0;
                          index++;
                          return DataRow(
                            color: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              indeCo++;

                              if (indeCo % 2 == 0) {
                                return Colors.blueGrey.withOpacity(0.1);
                              }
                            }),
                            cells: data.map((dat) {
                              return DataCell(
                                  Center(child: Text(dat.toString())));
                            }).toList(),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                ),
              );
      }),
      onRefresh: mob_grafico.carrega,
    );
  }
}
