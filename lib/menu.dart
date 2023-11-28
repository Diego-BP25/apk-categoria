import 'package:acceso/apptheme.dart';
import 'package:acceso/eliminarCategoria.dart';
import 'package:acceso/listarCategoria.dart';
import 'package:acceso/registrarCategorias.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Motors Up')),
        backgroundColor: Colors.blue,
      ),
      body: ListView(children: const [
        Card(
          color: Color.fromARGB(255, 198, 205, 207),
          elevation: 500,
          child: Column(
            children: [
              Image(
                  width: 1000,
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIsO2bRxsDQtoi0YdJDvUo3Lvv8eGvgf3ytg&usqp=CAU'))
            ],
          ),
        ),
      ]),
      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(
              height: 64,
              child: DrawerHeader(
                //encabezado de drawer
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Motors Up'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.construction),
              title: const Text('Listar Categorias'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListarCategorias()));
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.point_of_sale),
              title: const Text('Insertar Categorias'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const Registrar())); //cerrar el pop
                //setstate actualiza el contenido en pantalla
                setState(() {});
              },
            ),
            const SizedBox(height: 500),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('cerrar sesion'),
              onTap: () {
                Navigator.popUntil(
                    context, ModalRoute.withName('/')); //cerrar el pop
                //setstate actualiza el contenido en pantalla
                setState(() {});
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.nights_stay),
          onPressed: () {
            AppbarTheme.theme2;
          }),
    );
  }
}
