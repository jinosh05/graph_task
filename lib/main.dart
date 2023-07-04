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
