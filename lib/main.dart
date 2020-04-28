import 'package:flutter/material.dart';
import 'package:flutterapp/src/pages/contact_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contactos',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ContactListPage(),  // La primera pagina que mostrara sera la lista de contactos.
      ),
    );
  }
}

