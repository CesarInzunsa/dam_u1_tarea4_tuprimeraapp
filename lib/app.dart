import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

final List<Map<String, dynamic>> imagenes = [
  {
    'url': 'assets/fondo1.png',
    'titulo': 'El mar',
    'favorito': false,
    'descripcion': 'Mucho liquido'
  },
  {
    'url': 'assets/fondo2.png',
    'titulo': 'montañas',
    'favorito': true,
    'descripcion': 'Me gustan estas montañas'
  },
  {
    'url': 'assets/fondo3.jpeg',
    'titulo': 'Una cueva',
    'favorito': false,
    'descripcion': 'Que bonita cueva'
  },
  {
    'url': 'assets/fondo4.jpeg',
    'titulo': 'El espacio',
    'favorito': false,
    'descripcion': 'Interestelar me gusto mucho'
  },
  {
    'url': 'assets/fondo5.jpeg',
    'titulo': 'Nubes',
    'favorito': true,
    'descripcion': 'Bonitas nubes'
  },
  {
    'url': 'assets/fondo6.png',
    'titulo': 'Rayos laser',
    'favorito': true,
    'descripcion': 'Laser, si cruzo me quedo'
  },
  {
    'url': 'assets/fondo7.png',
    'titulo': 'Hexagonos',
    'favorito': false,
    'descripcion': 'Hexagonos, me gustan'
  }
];

class _AppState extends State<App> {
  List<bool> favoritos = List.filled(imagenes.length, false);
  int indice = 1;
  int actual = 0;
  TextEditingController tituloControllador = TextEditingController();
  TextEditingController descripcionControllador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          centerTitle: true,
          title: const Text('Galeria'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    indice = 1;
                  });
                },
                icon: const Icon(Icons.home_outlined))
          ],
        ),
        body: Center(
            child: ListView(
          padding: const EdgeInsets.all(15),
          children: dinamico(),
        )));
  }

  dinamico() {
    switch (indice) {
      case 1:
        return galeria();
      case 2:
        return detalles();
      default:
        return galeria();
    }
  }

  List<Widget> detalles() {
    return [
      Image.asset(imagenes[actual]['url'] ?? '', width: 250, height: 250),
      TextField(
          controller: tituloControllador,
          decoration: InputDecoration(
            labelText: 'Titulo',
            hintText: imagenes[actual]['titulo'] ?? '',
            icon: const Icon(Icons.drive_file_rename_outline),
          )),
      TextField(
          controller: descripcionControllador,
          decoration: InputDecoration(
            labelText: 'Descripcion',
            hintText: imagenes[actual]['descripcion'] ?? '',
            icon: const Icon(Icons.description),
          )),
      TextButton(
          onPressed: () {
            setState(() {
              tituloControllador.clear();
              descripcionControllador.clear();
              indice = 1;
            });
          },
          child: const Text('Cancelar')),
      FilledButton(
          onPressed: () {
            setState(() {
              imagenes[actual]['titulo'] = tituloControllador.text;
              imagenes[actual]['descripcion'] = descripcionControllador.text;
              tituloControllador.clear();
              descripcionControllador.clear();
              indice = 1;
            });
          },
          child: const Text('Guardar'))
    ];
  }

  List<Widget> galeria() {
    List<Widget> rows = [];
    for (int i = 0; i < imagenes.length; i++) {
      var row = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(imagenes[i]['titulo'] ?? ''),
        Image.asset(imagenes[i]['url'] ?? '', width: 150, height: 150),
        IconButton(
            onPressed: () {
              setState(() {
                imagenes[i]['favorito'] = !(imagenes[i]['favorito'] ?? false);
              });
            },
            icon: Icon(
              imagenes[i]['favorito'] ?? false
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: imagenes[i]['favorito'] ?? false ? Colors.red : null,
            )),
        IconButton(
            onPressed: () {
              setState(() {
                indice = 2;
                actual = i;
              });
            },
            icon: const Icon(Icons.info_outline))
      ]);
      rows.add(row);
      rows.add(const SizedBox(height: 15));
    }
    return rows;
  }
}
