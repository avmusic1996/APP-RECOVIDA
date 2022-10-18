import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:game_template/sql_helper.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../player_progress/player_progress.dart';
import '../../style/palette.dart';
import '../../style/responsive_screen.dart';
import '../../level_selection/levels.dart';
import '../panel_level.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const LevelUno());
}

class LevelUno extends StatefulWidget {
  const LevelUno({super.key});
  // const ({Key? key, required this.nombre}) : super(key: key);

  // final String nombre;
  // final String nombre;
  // final String edad;
  @override
  State<LevelUno> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LevelUno> {
  final TextEditingController nomcontroller = TextEditingController();
  TextEditingController edcontroller = TextEditingController();
  Future<Album>? _futureAlbum;

  // TextEditingController nombreController = new TextEditingController();
  // TextEditingController edadController = new TextEditingController();
  // TextEditingController authorController = TextEditingController();
  // TextEditingController yearController = TextEditingController();

  @override
  void initState() {
    refreshBooks();
    super.initState();
  }

  List<Map<String, dynamic>> books = [];
  void refreshBooks() async {
    final data = await SQLHelper.getBooks();
    setState(() {
      books = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(books);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/nature1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ResponsiveScreen(
          topMessageArea: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  //alignment: Alignment.bottomCenter,
                  child: Image(
                height: 40,
                image: AssetImage('assets/images/selec.png'),
              )),
              GestureDetector(
                  // onTap: () {
                  //   audioController.playSfx(SfxType.buttonTap);
                  //   GoRouter.of(context).go('/settings');
                  // },
                  child: Center(
                      //alignment: Alignment.bottomCenter,
                      child: Image(
                height: 40,
                image: AssetImage('assets/images/puntaje.png'),
              ))),
            ],
          ),
          squarishMainArea: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push('/jugar');
                  },
                  child: Image(
                    height: 50,
                    image: AssetImage('assets/images/atras.png'),
                  )),
              // GestureDetector(
              //     //alignment: Alignment.bottomCenter,
              //     child: Image(
              //   height: 200,
              //   image: AssetImage('assets/images/container.png'),
              // )),
              const Padding(
                padding: EdgeInsets.all(09),
                child: Text(
                  'Selecciona el nivel',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'arial',
                      fontSize: 30),
                ),
              ),
              const SizedBox(height: 0),
              const Padding(
                padding: EdgeInsets.all(09),
                child: TextField(
                  // controller: nomController,
                  decoration: const InputDecoration(hintText: 'Nombre'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(09),
                child: TextField(
                  // controller: edController,
                  decoration: const InputDecoration(hintText: 'edad'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(09),
                child: TextField(
                  decoration: const InputDecoration(hintText: 'celular'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _futureAlbum = createAlbum(nomcontroller.text);
                  });
                },
                child: const Text('Create Data'),
              ),
              const SizedBox(height: 0),

              TextField(
                controller: _controller,
                decoration: const InputDecoration(hintText: 'Enter Title'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _futureAlbum = createAlbum(_controller.text);
                  });
                },
                child: const Text('Create Data'),
              ),

              // GestureDetector(
              //     onTap: () {
              //       GoRouter.of(context).go('/select/level');
              //     },
              //     child: Image(
              //       height: 50,
              //       image: AssetImage('assets/images/jugar.png'),
              //     )),
            ],
          ),
          rectangularMenuArea: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pop();
                  },
                  child: Image(
                    height: 50,
                    image: AssetImage('assets/images/atras.png'),
                  )),
              GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go('/');
                  },
                  child: Image(
                    height: 50,
                    image: AssetImage('assets/images/home.png'),
                  )),
              GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push('/settings');
                  },
                  //alignment: Alignment.bottomCenter,
                  child: Image(
                    height: 50,
                    image: AssetImage('assets/images/siguiente.png'),
                  )),
            ],
          ),
        ),
      ),
      // rectangularMenuArea: ElevatedButton(
      //   onPressed: () {
      //     GoRouter.of(context).pop();
      //   },
      //   child: const Text('Back'),
      // ),
    );
  }
}

final TextEditingController _controller = TextEditingController();

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('http://app-juegos.epizy.com/planificacion/nivel1.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nombre': title,
      'fecha_hora': title,
      'dias_año': title,
      'continente': title,
      'pais': title,
      'ciudad': title,
      'barrio': title,
      'presidente': title,
      'gobernador': title,
      'celebramos': title,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum(_controller.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
// REVISEN BIEN, FALTA........ FALTA TODO JAJAJAJAJAAJJAAJ