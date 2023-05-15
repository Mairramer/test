import 'package:flutter/material.dart';
import 'package:test/screens/home_screen.dart';

///
class StartScreen extends StatefulWidget {
  ///
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        fontFamily: 'Roboto',
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        canvasColor: Colors.transparent,
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange)
          ..copyWith(
            background: Colors.amber,
          ),
      ),
      home: const HomeScreen(),
    );
  }
}
