import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasked_app/theme/color.dart';
import 'providers/task_provider.dart';
import 'screens/task_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskScreen(),
        theme: ThemeData.dark().copyWith(
          primaryColor: tdBGColor,
          hintColor: Colors.red,
        ),
      ),
    );
  }
}
