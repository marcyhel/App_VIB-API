import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:plan2/mobx/dados/mob_dados.dart';

part 'mob_grafico.g.dart';

class Mob_Grafico = _Mob_Grafico with _$Mob_Grafico;

abstract class _Mob_Grafico with Store {
  final Mob_dados mob_dados = GetIt.I<Mob_dados>();
  _Mob_Grafico() {
    carrega();
  }
  @observable
  List<dynamic> graficoLewis = [];
  @observable
  List<dynamic> graficoKosacovisk = [];
  @observable
  List<dynamic> graficoAnel = [];
  @observable
  List<dynamic> laminaAcu = [];

  @observable
  List<String> coluna = [
    'T. Inst.\n (min)',
    'T.Acum\n (min)',
    'Leitura\n  (cm)',
    'L.Instânt\n   (cm)',
    'L. Acum.\n  (cm)',
    '    Anel\n(cm/min)',
    '   Anel\n(mm/h)',
    'Kostiakov\n  (mm/h)'
  ];
  @observable
  List<List<String>> linha = [];

  Future<void> carrega() async {
    //await Future.delayed(Duration(milliseconds: 200));
    print('comeca');
    graficoKosacovisk = [];
    graficoAnel = [];
    laminaAcu = [];
    graficoLewis = [];
    linha = [];

    await mob_dados.calcular();
    for (var i = 0; i < mob_dados.intervaloTempo.length - 1; i++) {
      await graficoLewis.add(_SalesData(
          mob_dados.intervaloTempo[i + 1].toString(), mob_dados.viKl[i] / 10));
      await graficoKosacovisk.add(_SalesData(
          mob_dados.intervaloTempo[i + 1].toString(), mob_dados.viK[i] / 10));

      await graficoAnel.add(_SalesData(
          mob_dados.intervaloTempo[i + 1].toString(),
          mob_dados.viAnel[i] / 10));
      await laminaAcu.add(_SalesData(mob_dados.intervaloTempo[i].toString(),
          mob_dados.laminaAcumulada[i]));
    }

    for (var i = 0; i < mob_dados.intervaloTempo.length; i++) {
      List<String> aux = [];
      if (i == 0) {
        aux = [
          (await mob_dados.tempoInstantaneo[i].toString() == '')
              ? '0'
              : await mob_dados.tempoInstantaneo[i].toString(),
          await mob_dados.intervaloTempo[i].toString(),
          await mob_dados.leitura[i].toString(),
          await mob_dados.laminaInstantanea[i].toStringAsPrecision(3),
          await mob_dados.laminaAcumulada[i].toStringAsPrecision(3),
          '-',
          '-',
          '-'
        ];
      } else {
        aux = [
          await mob_dados.tempoInstantaneo[i].toString(),
          await mob_dados.intervaloTempo[i].toString(),
          await mob_dados.leitura[i].toString(),
          await mob_dados.laminaInstantanea[i].toStringAsPrecision(3),
          await mob_dados.laminaAcumulada[i].toStringAsPrecision(3),
          await mob_dados.vi[i - 1].toStringAsPrecision(3),
          await mob_dados.viAnel[i - 1].toStringAsPrecision(3),
          await mob_dados.viK[i - 1].toStringAsPrecision(3),
        ];
      }
      linha.add(aux);
    }
    print('marcyyyekjskldjlkdfs');
    for (var i = 0; i < graficoKosacovisk.length; i++) {
      print('-');
      print(mob_dados.viK[i] / 10);
      print(graficoKosacovisk[i].sales);
    }

    print('termina');
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
