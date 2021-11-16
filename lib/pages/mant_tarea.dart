import 'package:flutter/material.dart';
import 'package:flutter_tareas/models/tarea_model.dart';
import 'package:flutter_tareas/provider/http_provider.dart';

class MantTarea extends StatefulWidget {
  int id = 0;
  MantTarea({ Key? key, this.id = 0 }) : super(key: key);

  @override
  _MantTareaState createState() => _MantTareaState();
}

class _MantTareaState extends State<MantTarea> {
  TareasProvider _tareasProvider = TareasProvider();
  final _txtDescripcionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _txtDescripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    if(widget.id >0){
      _tareasProvider.obtenerTarea(widget.id).then((value){
        _txtDescripcionController.text = value.descripcion;
      });
    }

    return ScaffoldMessenger(
      key:scaffoldMessengerKey, 
      child:
        Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Mant Tarea: "+widget.id.toString()),
        actions: [
          widget.id != 0?IconButton(
            icon: Icon(Icons.delete, color: Colors.black,),
            onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Eliminar"),
                    content: Text("¿Desea eliminar la tarea?"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Si"),
                        onPressed: (){    
                          
                          _tareasProvider.eliminarTarea(widget.id).then((value){
                            setState(() {
                              Navigator.of(context).pop();
                              Navigator.pop(context);
                            });
                          });
                        },
                      ),
                      FlatButton(
                        child: Text("No"),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                }
              );
            },
          ):Container()
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Descripcion"),
                keyboardType: TextInputType.text,
                validator: (value){
                  if(value!.isEmpty || value.trim() == ""){
                    return "Debe ingresar una descripción";
                  }
                },
                controller: _txtDescripcionController,
              ),
              Divider(
                  height: 10.0,
                ),
              MaterialButton(
                child: Text(widget.id == 0?"Guardar":"Actualizar"),
                color: Colors.blue,
                onPressed: (){
                  
                  if(_txtDescripcionController.value.text.trim() == ""){

                    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
                      content: const Text('Debe ingresar una descripción'),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: '',
                        onPressed: () { },
                      ),
                    ));
                    return;
                  }

                  Tarea tarea = new Tarea(id: widget.id, descripcion: _txtDescripcionController.value.text.trim());
                  if(widget.id == 0){
                    _tareasProvider.guardarTarea(tarea).then((value) {
                      Navigator.of(context).pop();
                    });
                  }else{
                    _tareasProvider.actualizarTarea(tarea).then((value) {
                      Navigator.of(context).pop();
                    });
                  }
                },
              )
            ],
          ),
        ),
        ),
    ) 
    ); 
  }
}