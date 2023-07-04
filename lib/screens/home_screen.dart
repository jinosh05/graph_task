import 'dart:async';
import 'dart:math';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:graph_task/constants/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer_pro/sizer.dart';

part 'components/desktop.dart';
part 'components/mobile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) {
        return const _HomeMobile();
      },
      desktop: (BuildContext context) {
        return const _HomeDesktop();
      },
    );
  }
}

class _HomeDesktop extends StatefulWidget {
  const _HomeDesktop();

  @override
  State<_HomeDesktop> createState() => __HomeDesktopState();
}

class __HomeDesktopState extends State<_HomeDesktop> {
  final ValueNotifier<int> _tabSelected = ValueNotifier(1);
  // final List<Widget> _widgets = [];
  final List<String> _brands = ["INFY", "TATAMOTORS", 'SBIN'],
      priIndicators = ["Open", "High", "Low", "Close"];
  final List<Color> _brandColors = [
    Colors.green,
    Colors.orange,
    Colors.orangeAccent
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0.75.h, bottom: 0.75.h),
            child: const _Header(),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: Card(
                  child: ValueListenableBuilder(
                    valueListenable: _tabSelected,
                    builder: (context, int index, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var i = 1; i <= 5; i++)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 5.f,
                                horizontal: 2.f,
                              ),
                              child: Material(
                                color: Colors.white,
                                elevation: 3,
                                borderRadius: BorderRadius.circular(3.sp),
                                child: InkWell(
                                  onTap: () {
                                    _tabSelected.value = i;
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 2.f,
                                      horizontal: 3.f,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Watchlist $i",
                                      style: TextStyle(
                                        color: i == index
                                            ? Colors.blue
                                            : Colors.grey,
                                        fontSize: 7.f,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: ValueListenableBuilder(
                  valueListenable: _tabSelected,
                  builder: (context, int index, child) {
                    if (index <= 2) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Card(
                              margin: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  for (var i = 0; i < 3; i++)
                                    _CurrencyDetailsRow(
                                        brandColors: _brandColors,
                                        i: i,
                                        brands: _brands)
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Card(
                              color: Colors.white.withOpacity(0.95),
                              margin: EdgeInsets.only(right: 2.w),
                              child: SingleChildScrollView(
                                padding: EdgeInsets.all(15.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: "INFOSYS LTD",
                                        style: TextStyle(
                                          color: AppColors.text,
                                          fontSize: 9.f,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "\nINFY | NSE",
                                            style: TextStyle(
                                              fontSize: 6.f,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.h),
                                      child: _streamingChart(),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          children: [
                                            const _BuySellCard(),
                                            const _QtyText(),
                                            _PriceIndicatorCard(
                                                priIndicators: priIndicators)
                                          ],
                                        )),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            const _VolumeCard(),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            const _TradeWidget()
                                          ],
                                        )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Center(
                          child: Text(
                        "Under Development",
                        style: TextStyle(fontSize: 10.f),
                      ));
                    }
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Card _streamingChart() {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: StreamBuilder<List<double>>(
        stream: generateNumbers,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<double>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              List<double> data = snapshot.data ?? [];
              return Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 2,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceBetween,
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        gridData: const FlGridData(show: false),
                        barGroups: [
                          BarChartGroupData(x: 0),
                          for (var i = 1; i < data.length; i++)
                            BarChartGroupData(
                              x: i,
                              barRods: [
                                BarChartRodData(
                                  borderRadius: BorderRadius.zero,
                                  width: 2.5.w,
                                  rodStackItems: [
                                    BarChartRodStackItem(
                                      0,
                                      (data[i] * i).toDouble(),
                                      Colors.deepPurple.withOpacity(0.25),
                                    ),
                                    BarChartRodStackItem(
                                      (data[i] * i).toDouble(),
                                      (data[i] * i).toDouble() + 1.h,
                                      Colors.white,
                                    ),
                                    BarChartRodStackItem(
                                      (data[i] * i).toDouble() + 1.h,
                                      (data[i] * i).toDouble() + 2.h,
                                      Colors.deepPurple.withOpacity(0.75),
                                    ),
                                  ],
                                  toY: (data[i] * i).toDouble() + 2.h,
                                  color: Colors.deepPurple.withOpacity(0.25),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 2,
                    child: LineChart(
                      LineChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        titlesData: const FlTitlesData(show: false),
                        gridData: const FlGridData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(colors: [
                                Colors.deepPurple.withOpacity(0.25),
                                Colors.deepPurple.withOpacity(0.2),
                              ]),
                            ),
                            gradient: const LinearGradient(colors: [
                              Colors.deepPurple,
                              Colors.deepPurpleAccent,
                            ]),
                            isStrokeCapRound: true,
                            barWidth: 1.f,
                            spots: [
                              const FlSpot(0, 0),
                              for (var i = 1; i < data.length; i++)
                                FlSpot(
                                  (i).toDouble(),
                                  (data[i] * i).toDouble(),
                                )
                            ],
                            isCurved: true,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }

  Stream<List<double>> generateNumbers = (() async* {
    List<double> graphPoints = [];
    var rand = Random();

    while (true) {
      await Future<void>.delayed(const Duration(seconds: 2));
      if (graphPoints.isEmpty) {
        for (var i = 0; i < 25; i++) {
          graphPoints.add(rand.nextDouble() * 100);
        }
      } else {
        graphPoints.removeAt(0);
        graphPoints.add(rand.nextDouble() * 100);
      }
      debugPrint("Working");
      yield graphPoints;
    }
  })();
}
