import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todowithapi/ViewModel/pi_view_model.dart';

import 'View/mainscreen/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (context) => ApiViewModel(),),
       /* ChangeNotifierProvider(create: (context) => CheckBoxProvider(),),*/
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xffF5F2E8)),
        home: const MainScreen(
        ),
      ),
    );
  }
}

