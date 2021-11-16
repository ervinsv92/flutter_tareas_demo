import 'dart:convert';

class Tareas{
  List<Tarea> items = [];
  Tareas();

  Tareas.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;

    for(var item in jsonList){
      final tarea = new Tarea.fromJson(item);
      items.add(tarea);
    }
  }
}

class Tarea {
    Tarea({
        this.id = 0,
        this.descripcion = "",
    });

    int id;
    String descripcion;

    factory Tarea.fromJson(Map<String, dynamic> json) => Tarea(
        id: json["id"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
    };
}