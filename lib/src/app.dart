import 'package:credenciales/src/screens/funcionalidades.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'funcion': (context) => Funcionalidades()},
      home: Funcionalidades(),
    );
  }
}
