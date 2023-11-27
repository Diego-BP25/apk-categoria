import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

void main() {
  runApp(const Eliminar());
}

class Eliminar extends StatefulWidget {
  const Eliminar({super.key});

  @override
  State<Eliminar> createState() => _EliminarState();
}

class _EliminarState extends State<Eliminar> {
  List<dynamic> data = [];
  @override
  void initState() {
    super.initState();
    deletecategorias();
  }

  final textidediar = TextEditingController();

  deletecategorias() async {
    final response = await http.delete(
      Uri.parse('https://api-categoria.onrender.com/api/categoria'),
      body: jsonEncode({
        '_id': textidediar.text,
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
        title: const Text('Eliminar categorias'),
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
                  keyboardType: TextInputType.text,
                  controller: textidediar,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    prefixIconColor: Colors.blue,
                    labelText: 'Id para Eliminar',
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
                  text: "Eliminar",
                  color: Colors.red,
                  pressEvent: () {
                    if (!formContacto.currentState!.validate()) {
                      print('Formulario no valido');
                      return;
                    }
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.topSlide,
                        title: 'Alerta!',
                        desc: 'Estas seguro que quieres eliminar el registro',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          deletecategorias();
                        }).show();
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
