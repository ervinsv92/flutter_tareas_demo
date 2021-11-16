
import 'package:flutter/material.dart';
import 'package:flutter_tareas/routes/routes.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'lista_tareas',
    routes: getApplicationRoutes(),
  )
);