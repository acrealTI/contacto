
import 'package:flutter/material.dart';
import 'package:flutterapp/src/clases/Persona.dart';


// ignore: must_be_immutable
class ContactAddPage extends StatefulWidget {
  List<Persona> contactos;
  bool isEdit=false;
  int position;


  ContactAddPage(List<Persona> contactos, bool isEdit,int position) {
    this.contactos = contactos;
    this.position = position;
    this.isEdit = isEdit;
  }


  @override
  _ContactAddPage createState() => _ContactAddPage(this.contactos,isEdit,position);
}

class _ContactAddPage extends State<ContactAddPage> {
  // Se declaran variables para controlar el comportamiento de la aplicacion y obtención de datos.
  // Esta parte del codigo esta mas legible que la otra vista.
  String _nom = "",
      _ape = "",
      _tel = "";

  List<Persona> contactos = new List<Persona>();
  Persona contact;
  String _title = "Agregar Contacto",
      _labelButton = 'Añadir Contacto';
  bool isEdit = false;
  int position;
  TextEditingController contNombre, contApellido, contTelefono;

  _ContactAddPage(List<Persona> contactos, bool isEdit, int position) {
    this.contactos = contactos;
    this.position = position;
    this.isEdit = isEdit;

    _validaData();
  }

  void _validaData() {
    contNombre = new TextEditingController();
    contApellido= new TextEditingController();
    contTelefono = new TextEditingController();
    if (isEdit) {


      contact = contactos[position];

      contNombre = new TextEditingController(text: contact.nombre);
      contApellido= new TextEditingController(text: contact.apellidos);
      contTelefono = new TextEditingController(text: contact.telefono);
      _title = "Editar Contacto";
      _labelButton = "Actualizar Contacto";
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:
        Text(_title),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        children: <Widget>[
          // Se crea una vista de Widgets, siendo estos entradas de datos y un boton de verificación.
          Divider(),
          _nombre(),
          Divider(),
          _apellidos(),
          Divider(),
          _telefono(),
          Divider(),
          _btnAdd(context),
        ],
      ),
    );
  }

  Widget _nombre() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        hintText: "Ingrese su nombre",
        labelText: 'Nombres:',

        icon: Icon(Icons.account_box),
      ),
      controller: contNombre,
//      onChanged: (valor) =>
//          setState(() {
//            _nom = valor;
//          }),

    );
  }

  Widget _apellidos() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        hintText: "Ingrese sus apellidos",
        labelText: 'Apellidos:',
        icon: Icon(Icons.account_box),
      ),
      controller: contApellido,
//      onChanged: (valor) =>
//          setState(() {
//            _ape = valor;
//          }),


    );
  }

  Widget _telefono() {
    return TextField(
      keyboardType: TextInputType.phone,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        hintText: "Ingrese su número de telefono",
        labelText: 'Telefono:',
        icon: Icon(Icons.call),
      ),
      controller: contTelefono,
//      onChanged: (valor) =>
//          setState(() {
//            _tel = valor;
//          }),

    );
  }

  Widget _btnAdd(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text(_labelButton),
        color: Colors.blue,
        textColor: Colors.white,
        shape: StadiumBorder(),
        onPressed: () {
          _registrarPersona(context);
        },
      ),
    );
  }

  void _registrarPersona(BuildContext context) {
    // Si todo esta bien, muestra un mensaje de agregado, caso contrario, una advertencia.
   _nom = contNombre.text;
   _ape = contApellido.text;
   _tel = contTelefono.text;
    if (!isEdit) {

      if (_nom != "" && _ape != "" && _tel != "") {
        if (_isValExist()) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  title: Text('¡Alerta!'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('El contacto ' + _nom + ' ' + _ape + ' ya existe.')
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
          );
        }else{
        contactos.add(
            new Persona(nombre: _nom, apellidos: _ape, telefono: _tel));
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                title: Text('¡Contacto Agregado!'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Se ha registrado a ' + _nom + ' ' + _ape + '.')
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            }
        );
      }
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                title: Text('Ha ocurrido un Error'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Revise todos los campos antes de continuar.')
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
        );
      }
    } else {
      if (_nom != "" && _ape != "" && _tel != "") {
        if (_isValExist()) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  title: Text('¡Alerta!'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('El contacto ' + _nom + ' ' + _ape + ' ya existe.')
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
          );
        } else {
          contactos.removeAt(position);
          contactos.add(
              new Persona(nombre: _nom, apellidos: _ape, telefono: _tel));
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  title: Text('¡Contacto Actualizado!'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Se ha Actualizado a ' + _nom + ' ' + _ape + '.')
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              }
          );
        }
      }
      else{
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                title: Text('Ha ocurrido un Error'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Revise todos los campos antes de continuar.')
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
        );
      }
    }
  }

  bool _isValExist() {
    bool isval= false;
    if(contactos.isNotEmpty){
      for(Persona c in contactos){
        if(c.nombre == _nom && c.apellidos == _ape && c.telefono == _tel){
          isval = true;
        }
      }
    }
    return isval;
  }
}