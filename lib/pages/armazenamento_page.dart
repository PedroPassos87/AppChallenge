import 'package:challenge_app/repository/conta_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repository/spender_repository.dart';

class ArmazenamentoPage extends StatefulWidget {
  const ArmazenamentoPage({Key? key}) : super(key: key);

  @override
  State<ArmazenamentoPage> createState() => _ArmazenamentoPageState();
}

class _ArmazenamentoPageState extends State<ArmazenamentoPage> {
  int index = 0;
  double totalConsumido = 0;
  double capacidade = 0;
  late ContaRepository conta;
  final tabela = SpenderRepository.tabela;

  bool get isMB => totalConsumido <= 1000;

  String graficoLabel = '';
  double graficoValor = 0;

  @override
  Widget build(BuildContext context) {
    conta = context.watch<ContaRepository>();
    capacidade = conta.capacidade;

    setTotalConsumido();

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.withOpacity(0.7),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 48, bottom: 8),
              child: Text(
                'Total Consumido',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              isMB
                  ? '${totalConsumido}Mb'
                  : '${((totalConsumido / 1000).toStringAsFixed(2))}Gb',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 35,
                letterSpacing: -1.5,
              ),
            ),
            loadGrafico(),

          ],
        ),
      ),
    );
  }

  setTotalConsumido() {
    setState(() {
      totalConsumido = 0;
      for (var spender in tabela) {
        totalConsumido += spender.spent;
      }
    });
  }

  setGraficoDados(int index){
    if(index<0) return;

    if(index == tabela.length){
      graficoLabel = 'Uso de Dados';
      graficoValor = conta.armazenamento as double;
    }else{
      graficoLabel = tabela[index].name;
      graficoValor = tabela[index].spent;
    }
  }

   loadApps(){
    setGraficoDados(index);
    final tamanhoLista = tabela.length;

    return List.generate(tamanhoLista, (i) {
      final isTouched = i ==index;
      final isMax = i == tamanhoLista ;
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      final color = isTouched ? Colors.deepPurple : Colors.deepPurple[400];

      double porcentagem = 0;
      if (i == tabela.length) {
        porcentagem = totalConsumido / capacidade * 100;
      } else {
        porcentagem = tabela[i].spent / totalConsumido * 100;
      }

      return PieChartSectionData(
        color: Colors.deepPurple.withOpacity(1),
        value:  porcentagem,
        title: '${porcentagem.toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

    });
  }

  loadGrafico() {
    return (totalConsumido <= 0)
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      sectionsSpace: 3,
                      centerSpaceColor: Colors.purple.withOpacity(0.3),
                      centerSpaceRadius: 120,
                      sections: loadApps(),
                      pieTouchData: PieTouchData(
                        touchCallback: (touch) => setState(
                          () {
                            index = touch.touchedSection!.touchedSectionIndex;
                            setGraficoDados(index);
                          },
                        ),
                      ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    graficoLabel,
                    style:
                        TextStyle(fontSize: 32,fontWeight: FontWeight.bold,letterSpacing: 1.8, color: Colors.white,),
                  ),
                  Text(
                    '${graficoValor} Mb',
                    style: TextStyle(
                      fontSize: 28,fontWeight: FontWeight.bold,letterSpacing: 1.8, color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
