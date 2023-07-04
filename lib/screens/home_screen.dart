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
    for (var i = 0; i < 5; i++) {}

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
                                  // Padding(
                                  //   padding:
                                  //       EdgeInsets.symmetric(vertical: 1.h),
                                  //   child: _streamingChart(),
                                  // ),
                                  Row(
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
                                      const Expanded(child: Column()),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
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
}

class _PriceIndicatorCard extends StatelessWidget {
  const _PriceIndicatorCard({
    required this.priIndicators,
  });

  final List<String> priIndicators;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(5.f),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Price Indicators",
              style: TextStyle(
                color: AppColors.text,
                fontSize: 8.f,
                fontWeight: FontWeight.w800,
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 5.f,
              ),
              padding: EdgeInsets.all(10.f),
              decoration: BoxDecoration(
                color: AppColors.text.withOpacity(0.25),
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 0; i < priIndicators.length; i++)
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: "925.67",
                            children: [
                              TextSpan(
                                text: "\n${priIndicators[i]}".toUpperCase(),
                                style: TextStyle(
                                  color: AppColors.text.withOpacity(0.75),
                                  fontSize: 5.f,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8.f,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text.rich(
                    TextSpan(
                      text: "\nAverage Trade Price",
                      children: [
                        TextSpan(
                          text: "\n925.67",
                          style: TextStyle(
                            fontSize: 7.f,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 6.f,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _QtyText extends StatelessWidget {
  const _QtyText();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              text: "16,11,023",
              style: TextStyle(
                color: Colors.black,
                fontSize: 5.f,
                fontWeight: FontWeight.bold,
              ),
              children: const [
                TextSpan(
                  text: "\nTotal Qty",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: "16,11,023",
              style: TextStyle(
                color: Colors.black,
                fontSize: 5.f,
                fontWeight: FontWeight.bold,
              ),
              children: const [
                TextSpan(
                  text: "\nTotal Qty",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BuySellCard extends StatelessWidget {
  const _BuySellCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0.5.h) +
                EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Qty | Orders",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 7.f,
                        ),
                      ),
                      Text(
                        "BUY",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 7.f,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SELL",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 7.f,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "Qty | Orders",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 7.f,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          for (var i = 0; i < 5; i++)
            Row(
              children: [
                Expanded(
                  child: _DualColoredBox(
                    color1: Colors.grey.shade200,
                    color2: Colors.green,
                    fillPercent: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "   195 | 1.1k",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 7.f,
                          ),
                        ),
                        Text(
                          "950.15",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 7.f,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: _DualColoredBox(
                    color1: Colors.deepPurple.withOpacity(0.75),
                    color2: Colors.deepPurple.withOpacity(0.25),
                    fillPercent: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "950.15",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 7.f,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "195 | 1.1k   ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 7.f,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

Stream<List<double>> generateNumbers = (() async* {
  List<double> graphPoints = [];
  var rand = Random();

  while (true) {
    await Future<void>.delayed(const Duration(seconds: 5));
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

class _DualColoredBox extends StatelessWidget {
  const _DualColoredBox(
      {required this.child,
      required this.color1,
      required this.color2,
      required this.fillPercent});

  final Widget child;
  final Color color1, color2;
  final double fillPercent;

  @override
  Widget build(BuildContext context) {
    final List<Color> gradient = [
      color1,
      color1,
      color2,
      color2,
    ];
    double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];

    return Container(
      padding: EdgeInsets.all(2.5.f),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          stops: stops,
          end: Alignment.centerRight,
          begin: Alignment.centerLeft,
        ),
      ),
      child: child,
    );
  }
}
