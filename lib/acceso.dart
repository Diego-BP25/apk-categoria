import 'dart:convert';

import 'package:acceso/menu.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Accesos());
}

List<dynamic> data = [];

class Accesos extends StatefulWidget {
  const Accesos({super.key});

  @override
  State<Accesos> createState() => AccesosState();
}

class AccesosState extends State<Accesos> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    getUsuarios();
  }

  Future<void> getUsuarios() async {
    final response = await http
        .get(Uri.parse('https://api-usuario-2oqx.onrender.com/api/usuario'));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body);

      setState(() {
        data = decodedData['usuarios'] ?? [];
      });
    } else {
      print('revisar el codigo ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formContacto = GlobalKey<FormState>();
    final textUsuario = TextEditingController();
    final textContrasena = TextEditingController();
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Acceso'),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Form(
              key: formContacto,
              child: Column(
                children: [
                  TextFormField(
                    controller: textUsuario,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      prefixIconColor: Colors.blue,
                      labelText: 'Usuario',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Este campo es requerido';
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: textContrasena,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.key),
                      prefixIconColor: Colors.blue,
                      labelText: 'Documento',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Este campo es requerido';
                      return value.length < 3 ? 'Minimo 3 digitos' : null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedButton(
                      text: "Acceder",
                      color: Colors.blue,
                      pressEvent: () {
                        if (!formContacto.currentState!.validate()) {
                          print('Formulario no valido');
                          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            title: 'Error',
            desc: 'No se reconocio el nombre o el documento en la api',
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red
            ).show();
                          return;
                          
                        }else{
                          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: 'Bienvenido',
            desc: 'Usuario y documento correctos',
            btnOkOnPress: () {for (var usuario in data) {
                          if (usuario["nombre"] == textUsuario.text &&
                              usuario["documento"] == textContrasena.text)
                        
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Menu()),
                          );
                        }
                        }},
            ).show();
                        }
                        
                        
                        
                      },
                      
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        
      ),
    );
  }
}
