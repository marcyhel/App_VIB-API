import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plan2/mobx/dados/mob_dados.dart';
import 'package:plan2/mobx/grafico/mob_grafico.dart';
import 'package:plan2/mobx/page/mob_page.dart';
import 'package:plan2/screens/grafico/grafico.dart';
import 'package:plan2/screens/principal.dart';
import 'package:plan2/screens/tabela/tabela.dart';
import 'package:plan2/screens/tutorial/slider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('minhaCaixa1');

  singletonsApp();
  runApp(MyApp());
}

void singletonsApp() {
  GetIt.I.registerSingleton(Mob_Page());
  GetIt.I.registerSingleton(Mob_dados());
  GetIt.I.registerSingleton(Mob_Grafico());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Mob_Page mob = GetIt.I<Mob_Page>();
  List<dynamic> list = [Principal(), SlideCuston()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VIB-API',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.black54,
          displayColor: Colors.orange,
        ),
      ),
      home: Observer(builder: (_) {
        return list[mob.tuto];
      }),
    );
  }
}
