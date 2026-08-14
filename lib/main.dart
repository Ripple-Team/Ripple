import 'package:flutter/material.dart';
import 'package:messager/screens/home.dart';

void main() async {
  runApp(const Messager());
}

class Messager extends StatelessWidget {
  const Messager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messager',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF1A1A1D),
        iconTheme: IconThemeData(color: Colors.white),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF1A1A1D),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      themeMode: ThemeMode.dark,
      home: const Home(),
    );
  }
}
