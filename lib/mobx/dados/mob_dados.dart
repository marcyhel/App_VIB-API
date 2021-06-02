import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'dart:math';
part 'mob_dados.g.dart';

class Mob_dados = _Mob_dados with _$Mob_dados;

abstract class _Mob_dados with Store {
  _Mob_dados() {
    carregarDados();
    print(horas);
    print(leitura);

    print(tempoInstantaneo);
  }
  Box box;
  @observable
  var horas = ObservableList<String>();
  var tempoInstantaneo = ObservableList<String>();

  @observable
  List<String> leitura = [];
  @observable
  int qtd = 0;
  @action
  void addDado() {
    horas.add('');
    leitura.add('');
    tempoInstantaneo.add('');
    print(horas);
    print(tempoInstantaneo);
    qtd++;
    box.put('qtd1', qtd);
  }

  @action
  void removeDado() {
    horas.removeLast();
    tempoInstantaneo.removeLast();
    leitura.removeLast();

    qtd--;
    box.put('horas1' + qtd.toString(), "");
    box.put('leitura1' + qtd.toString(), "");
    box.put('tempoInstantaneo1' + qtd.toString(), "");
    box.put('qtd1', qtd);
  }

  @action
  void escreveHora(String valor, int id) {
    horas[id] = valor;
    box.put('horas1' + id.toString(), valor);
  }

  void escreveTempo(String valor, int id) {
    tempoInstantaneo[id] = valor;
    box.put('tempoInstantaneo1' + id.toString(), valor);
  }

  void escreveLeitura(String valor, int id) {
    print(id);
    leitura[id] = valor;
    box.put('leitura1' + id.toString(), valor);
  }

  //Dispose
  //
  //
  @observable
  bool load = false;
  @observable
  List<int> intervaloTempo = [];
  @observable
  List<double> laminaInstantanea = [];
  @observable
  List<double> laminaAcumulada = [];
  @observable
  List<double> xLogT = [];
  @observable
  List<double> yLogI = [];
  @observable
  List<double> xy = [];
  @observable
  List<double> x2 = [];
  @observable
  List<double> vi = [];
  @observable
  List<double> viAnel = [];
  @observable
  List<double> viK = [];
  @observable
  double somatorioXLog = 0.0;
  @observable
  double somatorioYLog = 0.0;
  @observable
  double somatorioXY = 0.0;
  @observable
  double somatorioX2 = 0.0;
  @observable
  double mediaXLog = 0.0;
  @observable
  double mediaYLog = 0.0;
  @observable
  double x = 0.0;
  @observable
  double z = 0.0;
  @observable
  double b = 0.0;
  @observable
  double a = 0.0;
  @observable
  double k = 0.0;
  @observable
  double vit = 0.0;
  @observable
  double viRes = 0.0;

  //lewis
  @observable
  double vib = 0.0;
  @observable
  List<double> iVibT = [];
  @observable
  List<double> yLogIVibT = [];
  @observable
  double somatorioYLogIVibT = 0.0;
  @observable
  double somatorioXYLogIVibT = 0.0;
  @observable
  double mediaYLogIVibT = 0.0;
  @observable
  double c18Lewis = 0.0;
  @observable
  double c19Lewis = 0.0;
  @observable
  double bLewis = 0.0;
  @observable
  double aLewis = 0.0;
  @observable
  double kLewis = 0.0;
  @observable
  double viLewis = 0.0;
  @observable
  double tLewis = 0.0;
  @observable
  List<double> viKl = [];

  @observable
  List<double> xYLogIVibT = [];

  @observable
  List<_SalesData> graficoKosacovisk = [];

  @action
  void calcIntervaloTempo() {
    intervaloTempo = [];
    var aux = 0;
    for (var i = 0; i < tempoInstantaneo.length; i++) {
      if (tempoInstantaneo[i] == '') {
        aux += 0;
      } else {
        aux += int.parse(tempoInstantaneo[i]);
      }

      intervaloTempo.add(aux);
    }
  }

  @action
  void calcularLaminaInstantanea() {
    double resp = 0.0;
    double aux;
    laminaInstantanea = [];
    if (leitura[0] == '') {
      aux = 0.0;
    }
    aux = double.parse(leitura[0]);

    for (var i = 0; i < leitura.length; i++) {
      double agr = 0.0;
      if (leitura[i] == '') {
        agr = 0.0;
      } else {
        agr = double.parse(leitura[i]);
      }

      resp = aux - agr;
      laminaInstantanea.add(resp);
    }
  }

  @action
  void calcLaminaAcumulada() {
    laminaAcumulada = [];
    var aux = 0.0;
    for (var i = 0; i < laminaInstantanea.length; i++) {
      aux += laminaInstantanea[i];

      laminaAcumulada.add(aux);
    }
  }

  @action
  void calcularXLogT() {
    xLogT = [];
    for (var i = 1; i < intervaloTempo.length; i++) {
      var aux = log(intervaloTempo[i]) / log(10);

      xLogT.add(aux);
    }
  }

  @action
  void calcularYLogI() {
    yLogI = [];
    for (var i = 1; i < laminaAcumulada.length; i++) {
      var aux = log(laminaAcumulada[i]) / log(10);

      yLogI.add(aux);
    }
  }

  @action
  void calcularXY() {
    xy = [];
    for (var i = 0; i < xLogT.length; i++) {
      var aux = xLogT[i] * yLogI[i];

      xy.add(aux);
    }
  }

  @action
  void calcularX2() {
    x2 = [];
    for (var i = 0; i < xLogT.length; i++) {
      var aux = pow(xLogT[i], 2);

      x2.add(aux);
    }
  }

  @action
  void calcularvi() {
    vi = [];
    viAnel = [];
    for (var i = 1; i < laminaInstantanea.length; i++) {
      var au = double.parse(tempoInstantaneo[i]);
      if (tempoInstantaneo[i] == '') {
        au = 0.0;
      }
      var aux = laminaInstantanea[i] / au;
      if (aux == double.nan) {
        aux = 0.0;
      }
      viAnel.add(aux * 600);
      vi.add(aux);
    }
  }

  void calcularSomatorio() {
    var auxx = 0.0;
    var auxy = 0.0;
    var auxxy = 0.0;
    var auxx2 = 0.0;
    for (var i = 0; i < xLogT.length; i++) {
      auxx += xLogT[i];
      auxy += yLogI[i];
      auxxy += xy[i];
      auxx2 += x2[i];
    }
    somatorioXLog = auxx;
    somatorioYLog = auxy;
    somatorioXY = auxxy;
    somatorioX2 = auxx2;

    mediaXLog = somatorioXLog / xLogT.length;
    mediaYLog = somatorioYLog / xLogT.length;
  }

  void calcularABK() {
    x = somatorioXY - (somatorioXLog * somatorioYLog) / xLogT.length;
    z = somatorioX2 - (pow(somatorioXLog, 2)) / xLogT.length;
    b = x / z;
    a = mediaYLog - (b * mediaXLog);
    k = pow(10, a);

    vit = b - 1;
    viRes = 600 * k * b;
  }

  void calcularViK() {
    viK = [];
    for (var i = 1; i < intervaloTempo.length; i++) {
      viK.add(viRes * pow(intervaloTempo[i], vit));
    }
  }

  void calcularVib() {
    iVibT = [];
    vib = laminaInstantanea[laminaInstantanea.length - 1] /
        double.parse(tempoInstantaneo[tempoInstantaneo.length - 1]);

    for (var i = 1; i < laminaAcumulada.length; i++) {
      iVibT.add(laminaAcumulada[i] - (vib * intervaloTempo[i]));
    }
  }

  void calcularYLogIVibT() {
    yLogIVibT = [];
    for (var i = 0; i < iVibT.length; i++) {
      var aux = log(iVibT[i]) / log(10);
      print(aux);
      yLogIVibT.add(aux);
    }
  }

  void calcularSomatorioYLogIVibT() {
    var aux = 0.0;

    for (var i = 0; i < yLogIVibT.length; i++) {
      aux += yLogIVibT[i];
    }
    somatorioYLogIVibT = aux;
  }

  void calcularMediaYLogIVibT() {
    mediaYLogIVibT = somatorioYLogIVibT / yLogIVibT.length;
    xYLogIVibT = [];
    var aux = 0.0;
    for (var i = 0; i < yLogIVibT.length; i++) {
      xYLogIVibT.add((xLogT[i] * yLogIVibT[i]));
      aux += xYLogIVibT[i];
    }
    somatorioXYLogIVibT = aux;
  }

  void calcularLewis() {
    c18Lewis = somatorioXYLogIVibT - (somatorioXLog * somatorioYLogIVibT) / 12;
    c19Lewis = somatorioX2 - (pow(somatorioXLog, 2)) / 12;
    bLewis = c18Lewis / c19Lewis;
    aLewis = mediaYLogIVibT - (bLewis * mediaXLog);
    kLewis = pow(10, aLewis);

    viLewis = 600 * kLewis * bLewis;
    tLewis = bLewis - 1;
    viKl = [];
    for (var i = 0; i < yLogIVibT.length; i++) {
      viKl.add(viLewis * pow(intervaloTempo[i + 1], tLewis));
    }
  }

  @action
  Future<void> calcular() async {
    try {
      load = true;
      await Future.delayed(Duration(milliseconds: 200));
      print('object');
      calcIntervaloTempo();
      calcularLaminaInstantanea();
      calcLaminaAcumulada();
      calcularXLogT();
      calcularYLogI();
      calcularXY();
      calcularX2();
      calcularvi();
      calcularSomatorio();
      calcularABK();
      calcularViK();

      //carrega();
      calcularVib();
      print('dddfsdgadh');
      calcularYLogIVibT();
      calcularSomatorioYLogIVibT();
      calcularMediaYLogIVibT();
      calcularLewis();

      print('****');
      print(viK);

      load = false;
    } catch (e) {
      load = true;
      print(e);
    }

    //load = false;
  }

  void carregarDados() async {
    box = await Hive.openBox('minhaCaixa1');

    if (await box.get('qtd1') == null) {
      await box.put('qtd1', 0);
    }
    qtd = await box.get('qtd1');
    await inicia();
    calcular();
  }

  void inicia() async {
    for (var i = 0; i < qtd; i++) {
      horas.add(box.get('horas1' + i.toString()));
      leitura.add(box.get('leitura1' + i.toString()));

      tempoInstantaneo.add(box.get('tempoInstantaneo1' + i.toString()));
      //addTensiometro();
    }
  }

  void carrega() async {
    for (var i = 0; i < intervaloTempo.length; i++) {
      graficoKosacovisk.add(_SalesData(intervaloTempo[i].toString(), viK[i]));
    }
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
