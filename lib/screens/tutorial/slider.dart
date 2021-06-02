import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:plan2/mobx/page/mob_page.dart';

class SlideCuston extends StatefulWidget {
  @override
  _SlideCustonState createState() => _SlideCustonState();
}

class _SlideCustonState extends State<SlideCuston> {
  final Mob_Page mob = GetIt.I<Mob_Page>();

  @override
  void initState() {
    super.initState();
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.amber[300],
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.amber[300],
      size: 35.0,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.amber[300],
      size: 30.0,
    );
  }

  void onDonePress() {
    mob.tuto = 0;
  }

  @override
  Widget build(BuildContext context) {
    List<Slide> slide = [
      Slide(
        backgroundColor: Colors.white,
        title: 'Barra de tarefas',
        styleTitle: TextStyle(
          color: Colors.orange,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        centerWidget: Image.asset(
          'image/tuto1.png',
          height: MediaQuery.of(context).size.height / 3,
        ),
        description: 'Permitira ter acesso rapido as funções do aplicativo.',
        styleDescription: TextStyle(color: Colors.black87, fontSize: 17),
        foregroundImageFit: BoxFit.scaleDown,
        //pathImage: 'image/tuto2.png',
      ),
      Slide(
        centerWidget: Image.asset(
          'image/tuto2.png',
          height: MediaQuery.of(context).size.height / 2.4,
        ),
        backgroundColor: Colors.orange,
        title: 'Graficos',
        styleTitle: TextStyle(
            color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
        description: 'Para uma melhor representação grafica dos dados.',
        styleDescription: TextStyle(color: Colors.black87, fontSize: 17),
      ),
      Slide(
        backgroundColor: Colors.white,
        title: 'Dados',
        styleTitle: TextStyle(
          color: Colors.orange,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        centerWidget: Image.asset(
          'image/tuto3.png',
          height: MediaQuery.of(context).size.height / 2.5,
        ),
        description:
            'Local onde iria inserir todos os dados coletados, podendo adicionar e diminuir linhas de dados na barra superior. ',
        styleDescription: TextStyle(color: Colors.black87, fontSize: 17),
        foregroundImageFit: BoxFit.scaleDown,
        //pathImage: 'image/tuto2.png',
      ),
      Slide(
        centerWidget: Image.asset(
          'image/tuto4.png',
          height: MediaQuery.of(context).size.height / 2.4,
        ),
        backgroundColor: Colors.orange,
        title: 'Tabela',
        styleTitle: TextStyle(
            color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
        description: 'Para uma melhor representação grafica dos dados.',
        styleDescription: TextStyle(color: Colors.black87, fontSize: 17),
      ),
      Slide(
        backgroundColor: Colors.white,
        //title: 'Aproveite',
        styleTitle: TextStyle(
          color: Colors.orange,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        centerWidget: Image.asset(
          'image/tuto5.png',
          height: MediaQuery.of(context).size.height / 3,
        ),
        description:
            'Se tiver alguma duvida lembre-se que pode voltar a esse tutorial sempre que desejar.',
        styleDescription: TextStyle(color: Colors.black87, fontSize: 17),
        foregroundImageFit: BoxFit.scaleDown,
        //pathImage: 'image/tuto2.png',
      ),
    ];
    return Scaffold(
      body: IntroSlider(
        slides: slide,
        colorDot: Colors.amber[300],
        sizeDot: 10,
        typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

        renderSkipBtn: this.renderSkipBtn(),

        //colorSkipBtn: Color(0x33ffcc5c),
        //highlightColorSkipBtn: Color(0xffffcc5c),

        // Next button
        renderNextBtn: this.renderNextBtn(),
        onTabChangeCompleted: (e) {
          //print(mob.indexTuto);
          //mob.setIndexTuto(!mob.indexTuto);
          setState(() {});
        },
        // Done button
        renderDoneBtn: this.renderDoneBtn(),
        onDonePress: this.onDonePress,
        //  colorDoneBtn: Color(0x33ffcc5c),
        //highlightColorDoneBtn: Color(0xffffcc5c),
      ),
    );
  }
}
