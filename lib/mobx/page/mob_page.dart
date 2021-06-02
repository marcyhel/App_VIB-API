import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'mob_page.g.dart';

class Mob_Page = _Mob_Page with _$Mob_Page;

abstract class _Mob_Page with Store {
  _Mob_Page() {
    carregarDados();
    print('hahahahahahahahahahahhhahaha');
    print(tuto);
  }
  Box box;
  Future<void> carregarDados() async {
    box = await Hive.openBox('minhaCaixa1');

    if (await box.get('tuto') == null) {
      await box.put('tuto', 1);
      print('vish');
      settuto(1);
    } else {
      settuto(0);
    }
  }

  @observable
  int tuto = 1;
  @observable
  int data = 1;
  @observable
  List<String> titulo = [
    'Dados',
    'Grafico',
    'Tabela',
  ];

  @action
  void setData(int valor) => data = valor;
  @action
  void settuto(int valor) => tuto = valor;
}
