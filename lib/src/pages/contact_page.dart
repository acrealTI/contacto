
import 'package:flutter/material.dart';
import 'package:flutterapp/src/clases/Persona.dart';

import 'contact_add_page.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPage createState() => _ContactListPage();
}

class _ContactListPage extends State<ContactListPage>{

  //final List<Persona> contactos = [new Persona(nombre: 'Juan Carlos', apellidos: 'Ulloa Vasquez', telefono: '+59178419585'), new Persona(nombre: 'Jose Eduardo', apellidos: 'Ulloa Vasquez', telefono: '+59177341303')];
  final List<Persona> contactos = new List<Persona>();  // Datos almacenados en una Lista Temporal


  // Se utilizaran Metodos y Funciones para crear el contenido y sea mas comprensible.
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de contactos:'),
      ),
      body: ListView(  // ListView donde se mostrara la información de los Contactos.
        padding: EdgeInsets.all(10),
        children: _listarContactos(context),  // Método que muestra los contactos
      ),
      floatingActionButton: FloatingActionButton(  // Este es el boton que esta en la parte inferior derecha para agregar un nuevo contacto
          child: Icon(Icons.person_add),
          onPressed: (){
            final route = MaterialPageRoute(
              builder: (context) => ContactAddPage(this.contactos,false,0)  // El boton para agregar contacto, cuando se pulsa cambia de pagina a la otra vista, enviado como parametro la Lista, para agregar un nuevo contacto.
            );
        Navigator.push(context, route);  // Flutter realiza el cambio de pagina
      }),
    );
  }

  List<Widget> _listarContactos(BuildContext context) {  // Metodo que devuelve una serie de Card que contiene la informacion de los contactos, se vuelca la Lista en una ListView
    var widgets = List<Widget>();
    for (var i = 0; i < contactos.length; i++) {  // Utilizo un for para recorrer los contactos en la Lista Temporal.
      widgets.add(Column(
        children: <Widget>[
          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(contactos[i].nombre+' ' +contactos[i].apellidos),
                  subtitle: Text(contactos[i].telefono),
                  leading: Icon(Icons.account_box, color: Colors.blue,),
                  trailing:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                  IconButton(onPressed: (){_eliminarContacto(context, i);},
                    icon: Icon(Icons.delete, color: Colors.red,),),
                        IconButton(onPressed: (){_editarContacto(context, i);},
                          icon: Icon(Icons.edit, color: Colors.green,),),
]),
                   // Cada Vista de usuario se instancia con un metodo, enviando como parametro su posicion en la lista, este valor cambia cada vez que se Redibuja.
                  onTap: (){

                  },
                ),
              ],
            ),
          ),
          Divider(),
        ],
      )
      );
    }
    return widgets;  // Devuelve la lista con todos los Widgets cargados con información.
  }

  void _eliminarContacto(BuildContext context, int position){  // Método para eliminar un contacto desde la lista, presionando en el boton Rojo (Eliminar)
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(  // Se consulta si al usuario si desea eliminar el Contacto "x".
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text('Borrar Contacto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('¿Realmente quieres eliminar a '+contactos[position].nombre+' '+contactos[position].apellidos+'?')
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Eliminar'),
              onPressed: (){
                setState((){
                  contactos.removeAt(position);  // En caso de aceptar, se elimina el contacto desde la lista de los Contactos.
                });
                Navigator.of(context).pop();  // Se cierra el mensaje de consulta.
              },
            )
          ],
        );
      }
    );
  }

  void _editarContacto(BuildContext context, int position) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Text('Editar Contacto'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('¿Realmente quieres Editar a '+contactos[position].nombre+' '+contactos[position].apellidos+'?')
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Editar'),
                onPressed: (){
                  Navigator.of(context).pop();
                  setState((){
                    final route = MaterialPageRoute(
                        builder: (context) =>  ContactAddPage(this.contactos,true,position)
                      // El boton para agregar contacto, cuando se pulsa cambia de pagina a la otra vista, enviado como parametro la Lista, para agregar un nuevo contacto.
                    );

                    Navigator.push(context, route);
          });


                },
              )
            ],
          );
        }
    );
  }

}