part of '../home_screen.dart';

class _CurrencyDetailsRow extends StatelessWidget {
  const _CurrencyDetailsRow({
    required List<Color> brandColors,
    required this.i,
    required List<String> brands,
  })  : _brandColors = brandColors,
        _brands = brands;

  final List<Color> _brandColors;
  final int i;
  final List<String> _brands;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              3.sp,
            ),
          ),
          margin: EdgeInsets.only(bottom: 1.h, left: 2.w, right: 1.w),
          child: Builder(builder: (context) {
            List<double> data = [];
            var rand = Random();
            for (var i = 0; i < 10; i++) {
              data.add(rand.nextDouble());
            }
            return Container(
              height: 10.w,
              padding: EdgeInsets.symmetric(vertical: 2.w),
              child: Sparkline(
                data: data,
                fillMode: FillMode.below,
                useCubicSmoothing: true,
                lineWidth: 1.0,
                averageLine: false,
                pointSize: 1.sp,
                fallbackWidth: 10.w,
                lineColor: _brandColors[i].withOpacity(0.25),
                fillGradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [_brandColors[i], Colors.white],
                ),
              ),
            );
          }),
        ),
        Expanded(
          child: Text(
            _brands[i],
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 6.f,
            ),
          ),
        ),
        Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.5.f, horizontal: 1.f),
              decoration: BoxDecoration(
                color: _brandColors[i].withOpacity(0.75),
                borderRadius: BorderRadius.circular(2.sp),
              ),
              child: Text(
                "+0.75% +1.345",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 4.5.f,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              "212.85",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 7.f,
                color: _brandColors[i],
              ),
            ),
          ],
        ),
        SizedBox(
          width: 1.w,
        )
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Spacer(),
      Expanded(
        flex: 8,
        child: Row(
          children: [
            const _MiniCurrencyCard(
              "BSE Ltd",
            ),
            SizedBox(
              width: 1.5.w,
            ),
            const _MiniCurrencyCard(
              "Nifty 50",
            ),
            const Spacer(),
            Icon(
              Icons.search_outlined,
              color: Colors.black54,
              size: 12.f,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 2.w,
                right: 5.w,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 2.f,
                horizontal: 5.f,
              ),
              decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purpleAccent,
                    Colors.purple.shade400,
                  ],
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesome.tree,
                    color: Colors.white,
                    size: 7.f,
                  ),
                  Text(
                    " 11",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 7.f,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ]);
  }
}

class _MiniCurrencyCard extends StatelessWidget {
  const _MiniCurrencyCard(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    List<double> data = [];
    var rand = Random();
    for (var i = 0; i < 10; i++) {
      data.add(rand.nextDouble());
    }
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(3.sp),
      elevation: 2,
      child: SizedBox(
        height: 12.5.w,
        width: 20.w,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.w),
              child: Sparkline(
                data: data,
                fillMode: FillMode.below,
                useCubicSmoothing: true,
                lineWidth: 1.0,
                averageLine: false,
                pointSize: 1.sp,
                fallbackWidth: 10.w,
                lineColor: Colors.green.withOpacity(0.25),
                fillGradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.green, Colors.white],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(1.w),
              child: Text.rich(
                TextSpan(
                    text: title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 7.f,
                    ),
                    children: [
                      TextSpan(
                        text: "\nUSD 20",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 4.f,
                          color: Colors.green,
                        ),
                      )
                    ]),
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

class _VolumeCard extends StatelessWidget {
  const _VolumeCard();

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
              "Volume",
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
                  Text(
                    "28,98,053\n",
                    style: TextStyle(
                      fontSize: 9.f,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Last Trated Qty",
                      children: [
                        TextSpan(
                          text: "\n500\n",
                          style: TextStyle(
                            fontSize: 6.f,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 5.f,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lower circuit",
                        style: TextStyle(
                          fontSize: 5.f,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "936.46",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 8.f,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Upper circuit",
                        style: TextStyle(
                          fontSize: 5.f,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "984.20",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 8.f,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
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

class _TradeWidget extends StatelessWidget {
  const _TradeWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 3.h),
        child: Column(
          children: [
            Text(
              "Looks like a good time to trade!",
              style: TextStyle(
                color: AppColors.blue,
                fontSize: 7.f,
              ),
            ),
            Text(
              "Options",
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 7.f,
                decoration: TextDecoration.underline,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(top: 1.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 3.f,
                ),
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.purpleAccent],
                  ),
                  shape: StadiumBorder(),
                ),
                child: Text(
                  "Trade",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.f,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StreamingCard extends StatefulWidget {
  const _StreamingCard();

  @override
  State<_StreamingCard> createState() => _StreamingCardState();
}

class _StreamingCardState extends State<_StreamingCard> {
  @override
  Widget build(BuildContext context) {
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
