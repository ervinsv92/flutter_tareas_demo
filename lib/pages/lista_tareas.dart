import 'package:flutter/material.dart';
import 'package:flutter_tareas/models/tarea_model.dart';
import 'package:flutter_tareas/pages/mant_tarea.dart';
import 'package:flutter_tareas/provider/http_provider.dart';

class ListaTareas extends StatefulWidget {
  ListaTareas({ Key? key }) : super(key: key);

  @override
  _ListaTareasState createState() => _ListaTareasState();
}

class _ListaTareasState extends State<ListaTareas> {

  TareasProvider _tareasProvider = TareasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista Tareas"),
        ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _tareasProvider.obtenerTareas(),
              builder: (BuildContext context, AsyncSnapshot<List<Tarea>> snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final tareas = snapshot.data;
                if(tareas == null || tareas.isEmpty){
                  return mensajeNoHayDatos();
                }

                return ListView.builder(
                  itemCount: tareas.length,
                  itemBuilder: (context, i) =>  Column(
                    children: [
                      ListTile(
                        title: Text(tareas[i].descripcion),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) =>
                              MantTarea(id: tareas[i].id))).then((value) => setState((){}));
                        },
                      ),
                      Divider(
                        height: 2.0,
                      )
                    ],
                  ),
                );
              },
            ) 
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btnNuevo",
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: (){
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MantTarea(id: 0))).then((value) => setState((){}));
            },
          )
        ],
      ),
    );
  }
}

Widget mensajeNoHayDatos(){
  return Center(
    child: Text("No hay tareas para mostrar"),
  );
}