import 'package:figuras/app.home.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Figuras Geometricas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 82, 248, 193)),
        useMaterial3: true,
      ),
      home: const AppHome(title: 'Figuras Geometricas'),
    );
  }
}