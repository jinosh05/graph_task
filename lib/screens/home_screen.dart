import 'dart:math';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
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
  final List<Widget> _widgets = [];

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 5; i++) {}
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          const _Header(),
          Row(children: [
            Expanded(
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
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 2.f,
                                  horizontal: 5.f,
                                ),
                                child: Text(
                                  "Watchlist $i ",
                                  style: TextStyle(
                                    color:
                                        i == index ? Colors.blue : Colors.grey,
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
            Expanded(
              flex: 9,
              child: ValueListenableBuilder(
                valueListenable: _tabSelected,
                builder: (context, int index, child) {
                  return const Column();
                },
              ),
            ),
          ]),
        ],
      ),
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
        flex: 9,
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
              size: 18.f,
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
