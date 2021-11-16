import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_tareas/models/tarea_model.dart';
import 'package:http/http.dart' as http;

class TareasProvider{
  final String _url = "104.236.224.107:1337";

  Future<List<Tarea>> obtenerTareas() async{
    List<Tarea> lista = [];
    try {
      final url = Uri.http(_url, '/tareas');
      final resp = await http.get(url);

      //final decodedData = json.decode(resp.body);
      final decodedData = json.decode(resp.body);
      var tareas = new Tareas.fromJsonList(decodedData);
      lista = tareas.items;
    } catch (e) {
      var error = e;
    }
    return lista;
  }

  Future<Tarea> obtenerTarea(int id) async{
    Tarea tarea = Tarea();
    try {
      final url = Uri.http(_url, '/tareas/'+id.toString());
      final resp = await http.get(url);

      //final decodedData = json.decode(resp.body);
      final decodedData = json.decode(resp.body);
      tarea = new Tarea.fromJson(decodedData);
    } catch (e) {
      var error = e;
    }
    return tarea;
  }

  Future<bool> eliminarTarea(int id) async{
    try {
      final url = Uri.http(_url, '/tareas/'+id.toString());
      final resp = await http.delete(url);
      return true;
    } catch (e) {
      var error = e;
      return false;
    }
  }

  Future<bool> guardarTarea(Tarea tarea) async{
    try {
      final url = Uri.http(_url, '/tareas');
      final resp = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(tarea));

      return true;
    } catch (e) {
      var error = e;
      return false;
    }
  }

  Future<bool> actualizarTarea(Tarea tarea) async{
    try {
      final url = Uri.http(_url, '/tareas/'+tarea.id.toString());
      final resp = await http.put(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(tarea));

      return true;
    } catch (e) {
      var error = e;
      return false;
    }
  }
}