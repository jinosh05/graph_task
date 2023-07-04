import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:graph_task/constants/colors.dart';
import 'package:graph_task/screens/home_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer_pro/sizer.dart';

void main(List<String> args) {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(builder: (context) {
      return Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              cardTheme: const CardTheme(
                color: Colors.white,
                surfaceTintColor: Colors.white,
              ),
              scaffoldBackgroundColor: AppColors.bg,
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.bg,
                elevation: 0,
              ),
            ),
            home: const HomeScreen(),
          );
        },
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<double> graphPoints = [];
  @override
  void initState() {
    super.initState();
    var rand = Random();
    for (var i = 0; i < 10; i++) {
      graphPoints.add(rand.nextDouble() * 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const LineChartSample2(),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceBetween,
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(
                          show: true,
                        ),
                        gridData: const FlGridData(show: false),
                        barGroups: [
                          BarChartGroupData(x: 0),
                          for (var i = 1; i < graphPoints.length; i++)
                            BarChartGroupData(
                              x: i,
                              barRods: [
                                BarChartRodData(
                                  borderRadius: BorderRadius.zero,
                                  width: 25,
                                  rodStackItems: [
                                    BarChartRodStackItem(
                                      0,
                                      (graphPoints[i] * i).toDouble(),
                                      Colors.red,
                                    ),
                                    BarChartRodStackItem(
                                      (graphPoints[i] * i).toDouble(),
                                      (graphPoints[i] * i).toDouble() + 0.5,
                                      Colors.white,
                                    ),
                                  ],
                                  toY: (graphPoints[i] * i).toDouble() + 1,
                                  color: Colors.red,
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: LineChart(
                      LineChartData(
                        // maxX: 6,
                        // minX: 1,
                        // minY: 2,
                        titlesData: const FlTitlesData(show: false),
                        gridData: const FlGridData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(colors: [
                                Colors.purple.withOpacity(0.25),
                                Colors.purpleAccent.withOpacity(0.2),
                              ]),
                            ),
                            gradient: const LinearGradient(colors: [
                              Colors.purple,
                              Colors.purpleAccent,
                            ]),
                            isStrokeCapRound: true,
                            barWidth: 3,
                            spots: [
                              const FlSpot(0, 0),
                              for (var i = 1; i < graphPoints.length; i++)
                                FlSpot(
                                  (i).toDouble(),
                                  (graphPoints[i] * i).toDouble(),
                                )
                            ],
                            isCurved: true,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
