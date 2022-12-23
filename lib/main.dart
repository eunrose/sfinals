import 'package:flutter/material.dart';
import 'package:sqflite1/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home:  HomePage(),
  ));
}
