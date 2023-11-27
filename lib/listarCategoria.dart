import 'dart:async';
import 'dart:convert';
import 'package:acceso/editarCategorias.dart';
import 'package:acceso/eliminarCategoria.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class ListarCategorias extends StatefulWidget {
  const ListarCategorias({Key? key}) : super(key: key);

  @override
  State<ListarCategorias> createState() => ListarUsuariosState();
}

class ListarUsuariosState extends State<ListarCategorias> {
  List<dynamic> data = [];

  final textBuscador = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCategorias();
  }

  void limpiarLista() {
    setState(() {
      data = [];
    });
  }

  Future<void> getCategorias({String nombre = ''}) async {
    final response = await http.get(
      Uri.parse('https://api-categoria.onrender.com/api/categoria'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body);

      setState(() {
        // Filtrar la lista por nombre
        data = (decodedData['categoria'] ?? []).where((item) {
          // Cambia 'nombre' por la propiedad real que estás comparando en tu API
          String nombreItem = item['nombre'].toString().toLowerCase();
          String nombreBuscado = nombre.toLowerCase();
          return nombreItem.contains(nombreBuscado);
        }).toList();
      });
    } else {
      print('Revisar el código: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listar categorias'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: textBuscador,
                      decoration: const InputDecoration(
                        labelText: 'Buscador',
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  getCategorias(nombre: textBuscador.text);
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(children: [
                      Expanded(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(data[index]['id']),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(data[index]['nombre']),
                      ),
                      Expanded(
                        child: Text(data[index]['descripcion']),
                      ),
                      Expanded(
                        child: Text(data[index]['estado']),
                      ),
                      Expanded(
                          child: ListTile(
                        leading: const Icon(Icons.edit),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Editar())); //cerrar el pop
                          //setstate actualiza el contenido en pantalla
                          setState(() {});
                        },
                      )),
                      Expanded(
                          child: ListTile(
                        leading: const Icon(Icons.delete),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Eliminar())); //cerrar el pop
                          //setstate actualiza el contenido en pantalla
                          setState(() {});
                        },
                      ))
                    ])
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
