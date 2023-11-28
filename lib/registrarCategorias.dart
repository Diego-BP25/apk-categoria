import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

void main() {
  runApp(const Registrar());
}

class Registrar extends StatefulWidget {
  const Registrar({super.key});

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  List<dynamic> data = [];
  @override
  void initState() {
    super.initState();
    postcategorias();
  }

  final textid = TextEditingController();
  final textnombre = TextEditingController();
  final textdescripcion = TextEditingController();
  final textestado = TextEditingController();

  postcategorias() async {
    final response = await http.post(
      Uri.parse('https://api-categoria.onrender.com/api/categoria'),
      body: jsonEncode({
        'id': textid.text,
        'nombre': textnombre.text,
        'descripcion': textdescripcion.text,
        'estado': textestado.text
      }),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
      });
    } else {
      print('revisar el codigo ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formContacto = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar categorias'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: formContacto,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: textid,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.tag),
                    prefixIconColor: Colors.blue,
                    labelText: 'Id',
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
                  keyboardType: TextInputType.text,
                  controller: textnombre,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Colors.blue,
                    labelText: 'Nombre',
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
                  keyboardType: TextInputType.text,
                  controller: textdescripcion,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.notes),
                    prefixIconColor: Colors.blue,
                    labelText: 'Descripcion',
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
                  keyboardType: TextInputType.text,
                  controller: textestado,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.toggle_on),
                    prefixIconColor: Colors.blue,
                    labelText: 'Estado',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Este campo es requerido';
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedButton(
                  text: "Registrar",
                  color: Colors.blue,
                  pressEvent: () {
                    if (!formContacto.currentState!.validate()) {
                      print('Formulario no valido');
                      return;
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.bottomSlide,
                        title: 'Correcto',
                        desc: 'Registro exitoso',
                        btnOkOnPress: () {
                          postcategorias();
                        },
                      ).show();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
