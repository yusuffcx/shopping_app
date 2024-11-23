import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/groceries_list.dart';

final theme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 147, 229, 250),
      brightness: Brightness.dark,
      surface: const Color.fromARGB(255, 42, 51, 59),
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const GroceriesList(),
      theme: theme,
    );
  }
}
