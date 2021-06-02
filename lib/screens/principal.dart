import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:plan2/mobx/dados/mob_dados.dart';
import 'package:plan2/mobx/grafico/mob_grafico.dart';
import 'package:plan2/mobx/page/mob_page.dart';
import 'package:plan2/screens/dados/dados.dart';
import 'package:plan2/screens/grafico/grafico.dart';
import 'package:plan2/screens/tabela/tabela.dart';
import 'package:plan2/screens/tutorial/slider.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int contindex = 1;
  PageController _controle = PageController(initialPage: 1);
  final Mob_Page mob = GetIt.I<Mob_Page>();
  final Mob_dados mob_dados = GetIt.I<Mob_dados>();
  final Mob_Grafico mob_grafico = GetIt.I<Mob_Grafico>();
  Future<void> carregaa() async {
    await mob_grafico.carrega();
  }

  @override
  void initState() {
    // TODO: implement initState
    reaction<int>(
      (fn) => mob.data,
      (valor) => _controle.animateToPage(valor,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOutQuart),
    );
    carregaa();
    super.initState();
  }

  /*
  child: Text(
              mob.titulo[mob.data],
              style: TextStyle(color: Colors.green),
            ),

*/

  bool _first = true;

  double _fontSize = 30;
  double _space = 0;
  Color _color = Colors.orange;
/*AnimatedDefaultTextStyle(
            curve: Curves.elasticOut,
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: _fontSize,
              color: _color,
              fontWeight: FontWeight.bold,
            ),
            child: Text(
              mob.titulo[mob.data],
              //  style: TextStyle(color: Colors.orange),
            ),
          );*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[400],
      appBar: AppBar(
        actions: [
          Observer(
              builder: (_) => (mob.data == 0)
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.add_rounded,
                          color: Colors.amber,
                        ),
                        onPressed: mob_dados.addDado,
                      ),
                    )
                  : (mob.data == 1)
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.help_outline_rounded,
                              color: Colors.amber,
                            ),
                            onPressed: () {
                              mob.settuto(1);
                              print("ajudaaa");
                              print(mob.tuto);
                            },
                          ),
                        )
                      : Icon(
                          Icons.ac_unit_outlined,
                          size: 0,
                        ))
        ],
        leading: Observer(
          builder: (_) => (mob.data == 0)
              ? IconButton(
                  icon: Icon(
                    Icons.remove_rounded,
                    color: Colors.amber,
                  ),
                  onPressed: mob_dados.removeDado,
                )
              : Icon(
                  Icons.ac_unit_outlined,
                  size: 0,
                ),
        ),
        centerTitle: true,
        title: Observer(builder: (_) {
          //print('fffff');

          return AnimatedDefaultTextStyle(
            curve: Curves.elasticOut,
            duration: const Duration(milliseconds: 900),
            style: TextStyle(
              fontSize: _fontSize,
              color: _color,
              letterSpacing: _space,
              fontWeight: FontWeight.bold,
            ),
            child: Text(
              mob.titulo[mob.data],
              //  style: TextStyle(color: Colors.orange),
            ),
          );
        }),
        backgroundColor: Colors.white,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controle,
        children: [
          Dados(),
          Grafico(),
          Tabela(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOutQuart,
        height: 55,
        color: Colors.white,
        // buttonBackgroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        index: contindex,
        items: [
          Icon(Icons.table_rows_outlined),
          Icon(Icons.stacked_line_chart_rounded),
          Icon(Icons.table_chart_outlined),
        ],
        onTap: (index) async {
          if (index != mob.data) {
            setState(() {});
            //_fontSize = _first ? 50 : 30;
            _fontSize = 0;
            _space = 20;
            _color = Colors.white;
            await Future.delayed(Duration(milliseconds: 100));
            mob.setData(index);
            //print('d');
            _color = Colors.orange;
            _space = 0;
            _fontSize = 30;

            //_color = _first ? Colors.blue : Colors.red;
            //_first = !_first;
            //print(index);
          }
        },
      ),
    );
  }
}
/*
CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )*/
