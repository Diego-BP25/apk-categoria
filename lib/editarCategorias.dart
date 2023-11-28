import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';



class Editar extends StatefulWidget {
  final Map<String, dynamic> categoria;

  const Editar({Key? key, required this.categoria}) : super(key: key);

  @override
  State<Editar> createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  List<dynamic> data = [];
  @override
void initState() {
  super.initState();

  // Inicializar controladores con los datos de la categoría
  textidediar.text = widget.categoria['_id'];
  textid.text = widget.categoria['id'];
  textnombre.text = widget.categoria['nombre'];
  textdescripcion.text = widget.categoria['descripcion'];
  textestado.text = widget.categoria['estado'];

    putcategorias();
  }

  final textidediar = TextEditingController();
  final textid = TextEditingController();
  final textnombre = TextEditingController();
  final textdescripcion = TextEditingController();
  final textestado = TextEditingController();

  putcategorias() async {
    final response = await http.put(
      Uri.parse('https://api-categoria.onrender.com/api/categoria'),
      body: jsonEncode({
        '_id': textidediar.text,
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
                  controller: textidediar,
                  enabled: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    prefixIconColor: Colors.blue,
                    labelText: 'Id para editar',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Este campo es requerido';
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: textid,
                  enabled: false,
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
                  text: "Editar",
                  color: Colors.yellow,
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
                        desc: 'Edicion exitosa',
                        btnOkOnPress: () {
                          putcategorias();
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
