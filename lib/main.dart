import 'package:flutter/material.dart';

import 'package:flutter_peliculas/src/pages/home_page.dart';
import 'package:flutter_peliculas/src/pages/pelicula_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => PeliculaDetallePage(),
      },
    );
  }
}
