import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Funcionalidades extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<Funcionalidades> {
  String _nombre;
  String _edad;
  String _puesto;
  String _tipoSanguineo;
  String _telefono;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNombre() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Nombre Completo', border: OutlineInputBorder()),
      //maxLength: 100,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingrese el Nombre Completo ';
        }

        return null;
      },
      onSaved: (String value) {
        _nombre = value;
      },
    );
  }

  Widget _buildEdad() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Edad', border: OutlineInputBorder()),
      //maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingrese su edad';
        }

        return null;
      },
      onSaved: (String value) {
        _edad = value;
      },
    );
  }

  Widget _buildPuesto() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Puesto', border: OutlineInputBorder()),
      //maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingrese el Puesto';
        }

        return null;
      },
      onSaved: (String value) {
        _puesto = value;
      },
    );
  }

  Widget _buildTipoSangre() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Tipo Sanguineo', border: OutlineInputBorder()),
      //maxLength: 10,
      keyboardType: TextInputType.url,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingrese el Tipo Sanguineo';
        }

        return null;
      },
      onSaved: (String value) {
        _tipoSanguineo = value;
      },
    );
  }

  Widget _buildTelefono() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Telefono de Contacto',
        border: OutlineInputBorder(),
      ),
      //maxLength: 10,
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingrese numero de telefono';
        }

        return null;
      },
      onSaved: (String value) {
        _telefono = value;
      },
    );
  }

  final image = ImagePicker();
  String pathImage;
  Widget _buildFotografia(BuildContext context) {
    var img = pathImage != null
        ? ClipOval(
            child: Image.file(
            File(pathImage),
            fit: BoxFit.contain,
            height: 200,
            width: 200,
          ))
        : CircleAvatar(
            radius: 80.0,
            backgroundImage: NetworkImage(
                'https://www.muycomputer.com/wp-content/uploads/2019/12/android.jpg'),
          );
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 10.0,
      child: ListTile(
        title: Text(
          'Tomar Fotografía',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Text('Lanzar aplicación de la Cámara'),
            Icon(
              Icons.touch_app,
              color: Colors.brown,
              size: 18.0,
            )
          ],
        ),
        leading: Container(
          height: 38,
          padding: EdgeInsets.only(right: 15.0),
          child: Icon(Icons.camera),
          decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.black))),
        ),
        trailing: Icon(Icons.chevron_right),
        onTap: () => abrirCamara(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Datos Generales"), backgroundColor: Colors.grey),
      backgroundColor: Colors.orangeAccent[100],
      body: Container(
        margin: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildNombre(),
              _buildEdad(),
              _buildPuesto(),
              _buildTipoSangre(),
              _buildTelefono(),
              SizedBox(height: 100),
              RaisedButton(
                child: Text(
                  'GUARDAR',
                  style: TextStyle(color: Colors.green, fontSize: 14),
                ),
                onPressed: () {
                  showDialog(
                    barrierColor: Colors.green,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Credencial'),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Nombre:$_nombre'),
                            Text('Edad:$_edad'),
                            Text('Puesto:$_puesto'),
                            Text('Tipo Sanguineo:$_tipoSanguineo'),
                            Text('Telefono:$_telefono'),
                          ],
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('CERRAR'),
                          )
                        ],
                      );
                    },
                  );

                  _formKey.currentState.save();

                  //Send to API
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  abrirCamara() async {
    final archivo = await image.getImage(source: ImageSource.camera);
    pathImage = archivo.path;
    setState(() {});
  }
}
