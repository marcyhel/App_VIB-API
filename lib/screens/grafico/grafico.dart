import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:plan2/mobx/dados/mob_dados.dart';
import 'package:plan2/mobx/grafico/mob_grafico.dart';
import 'package:plan2/screens/grafico/componentes/load.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final Mob_dados mob_dados = GetIt.I<Mob_dados>();

final Mob_Grafico mob_grafico = GetIt.I<Mob_Grafico>();

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

Future<List<_SalesData>> carrega() async {
  var aux = mob_grafico.graficoKosacovisk[0].year;
  mob_grafico.graficoKosacovisk[0].year = aux;

  var aux2 = mob_grafico.graficoAnel[0].year;
  mob_grafico.graficoAnel[0].year = aux2;
}

Future<void> carregaa() async {
  await mob_dados.calcular();
  await mob_grafico.carrega();
}

class Grafico extends StatefulWidget {
  @override
  _GraficoState createState() => _GraficoState();
}

class _GraficoState extends State<Grafico> {
  List<dynamic> data = [];

  List<dynamic> data2 = [];

  @override
  void initState() {
    carregaa();
    super.initState();
  }

  List<dynamic> data3 = [
    _SalesData('3', 30),
    _SalesData('Feb2', 20),
    _SalesData('Mar2', 30),
    _SalesData('Apr2', 28),
    _SalesData('May2', 30),
    _SalesData('Jan1', 30),
    _SalesData('Feb1', 20),
    _SalesData('Mar1', 30),
    _SalesData('Apr1', 28),
    _SalesData('May1', 30)
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.amber,
      child: Observer(builder: (_) {
        return (mob_dados.load)
            ? Load()
            : ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Observer(builder: (_) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45,
                                offset: Offset(2, 3),
                                blurRadius: 10)
                          ]),
                      margin: EdgeInsets.all(10),
                      child: Observer(builder: (_) {
                        return SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                                title: AxisTitle(text: 'Tempo (min)')),
                            primaryYAxis: NumericAxis(
                                title: AxisTitle(
                                    text: 'Velocidade de Infiltração (mm/h)')),
                            // Chart title
                            title:
                                ChartTitle(text: 'Velocidade de Infiltração'),
                            // Enable legend
                            legend: Legend(
                                isVisible: true,
                                orientation: LegendItemOrientation.horizontal,
                                position: LegendPosition.bottom),

                            // Enable tooltip
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <ChartSeries<dynamic, String>>[
                              ScatterSeries<dynamic, String>(
                                dataSource: mob_grafico.graficoKosacovisk
                                    .cast<dynamic>(),
                                xValueMapper: (dynamic sales, _) => sales.year,
                                yValueMapper: (dynamic sales, _) => sales.sales,
                                name: 'Kostiakov',
                                // Enable data label
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: false),
                              ),
                              ScatterSeries<dynamic, String>(
                                dataSource:
                                    mob_grafico.graficoLewis.cast<dynamic>(),
                                xValueMapper: (dynamic sales, _) => sales.year,
                                yValueMapper: (dynamic sales, _) => sales.sales,
                                color: Colors.green,
                                name: 'Lewis',
                                // Enable data label
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: false),
                              ),
                              ScatterSeries<dynamic, String>(
                                dataSource:
                                    mob_grafico.graficoAnel.cast<dynamic>(),
                                xValueMapper: (dynamic sales, _) => sales.year,
                                yValueMapper: (dynamic sales, _) => sales.sales,
                                name: 'Anéis \nConcêntricos',
                                // Enable data label
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: false),
                              ),
                            ]);
                      }),
                    );
                  }),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45,
                              offset: Offset(2, 3),
                              blurRadius: 10)
                        ]),
                    margin: EdgeInsets.all(10),
                    child: Observer(builder: (_) {
                      return SfCartesianChart(
                          primaryXAxis: CategoryAxis(
                              title: AxisTitle(text: 'Tempo (min)')),
                          primaryYAxis: NumericAxis(
                              title: AxisTitle(
                                  text: 'Infiltração acumulada (mm)')),
                          // Chart title
                          title: ChartTitle(text: 'Velocidade de Infiltração'),
                          // Enable legend
                          legend: Legend(
                              isVisible: true,
                              orientation: LegendItemOrientation.horizontal,
                              position: LegendPosition.bottom),

                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<dynamic, String>>[
                            SplineSeries<dynamic, String>(
                              dataSource: mob_grafico.laminaAcu.cast<dynamic>(),
                              xValueMapper: (dynamic sales, _) => sales.year,
                              yValueMapper: (dynamic sales, _) => sales.sales,
                              name: 'Lamina Acumulada',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: false),
                            ),
                          ]);
                    }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              );
      }),
      onRefresh: carregaa,
    );
  }
}

/*ScatterSeries<_SalesData, String>(
                      dataSource: data2,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'dado2',

                      // Enable data label
                      dataLabelSettings: DataLabelSettings(
                        isVisible: false,
                      )),
                  LineSeries<_SalesData, String>(
                      dataSource: data3,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'dado3',
                      color: Colors.black54,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(
                        isVisible: false,
                      ))*/
