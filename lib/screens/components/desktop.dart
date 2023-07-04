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
