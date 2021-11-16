import 'package:flutter/material.dart';
import 'package:flutter_tareas/pages/lista_tareas.dart';
import 'package:flutter_tareas/pages/mant_tarea.dart';

class Routes{
  static final String balanceDiario = "lista_tareas";
  static final String balanceRango = "mant_tarea";
}

Map<String, WidgetBuilder> getApplicationRoutes() {

  return <String, WidgetBuilder> {
      Routes.balanceDiario         : ( BuildContext context ) => ListaTareas(),
      Routes.balanceRango          : ( BuildContext context ) => MantTarea(),
  };
}