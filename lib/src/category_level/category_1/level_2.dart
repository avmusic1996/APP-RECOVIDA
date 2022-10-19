// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game_template/src/category_level/category_1/category_level1.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../player_progress/player_progress.dart';
import '../../style/palette.dart';
import '../../style/responsive_screen.dart';
import '../../level_selection/levels.dart';
import '../panel_level.dart';
import 'usuarios.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LevelDos extends StatefulWidget {
  const LevelDos({super.key});
  @override
  State<LevelDos> createState() => _LevelDosState();
}

class _LevelDosState extends State<LevelDos> {
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();
    final audioController = context.watch<AudioController>();
    final nombre = TextEditingController();

    final fecha_hora = TextEditingController();
    final dias_ano = TextEditingController();
    final continente = TextEditingController();
    final pais = TextEditingController();
    final ciudad = TextEditingController();
    final barrio = TextEditingController();
    final presidente = TextEditingController();
    final gobernador = TextEditingController();
    final celebramos = TextEditingController();
    bool isVisible1 = true;
    bool isVisible2 = false;
    bool isVisible3 = false;
    bool isVisible4 = false;
    bool isVisible5 = false;
    bool isVisible6 = false;
    bool isVisible7 = false;
    bool isVisible8 = false;
    bool isVisible9 = false;
    bool isVisible10 = false;
    int variable = 0;

    String texto = "hola";
    final url = ("http://app-juegos.epizy.com/planificacion/nivel1.php");
    // final url =
    // Uri.parse("http://app-juegos.epizy.com/planificacion/nivel1.php");

    final headers = {"Content-Type": "application/json;charset=UTF-8"};
    void showSnackBar(String msg) {
      final snack = SnackBar(content: Text(msg));
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }

    Future<void> register() async {
      final user = {
        "nombre": nombre.text,
        "fecha_hora": fecha_hora.text,
        "dias_año": dias_ano.text,
        "continente": continente.text,
        "pais": pais.text,
        "ciudad": ciudad.text,
        "barrio": barrio.text,
        "presidente": presidente.text,
        "gobernador": gobernador.text,
        "celebramos": celebramos.text
      };
      //final res = await http.post(url, headers: headers, body: jsonEncode(user));
      final res = await http.post(Uri.parse(url), body: {
        "nombre": nombre.text,
        "fecha_hora": fecha_hora.text,
        "dias_año": dias_ano.text,
        "continente": continente.text,
        "pais": pais.text,
        "ciudad": ciudad.text,
        "barrio": barrio.text,
        "presidente": presidente.text,
        "gobernador": gobernador.text,
        "celebramos": celebramos.text
      });

      if (res.statusCode == 401) {
        final data = Map.from((jsonDecode(res.body)));
        showSnackBar(data["error"]);
        return;
      }

      if (res.statusCode != 200) {
        showSnackBar("Ups hubo un error, intente de nuevo");
        return;
      }
      // final data = Map.from(jsonDecode(res.body));
      // final usuario = Usuario.fromJson(data);

      Navigator.of(context).pushNamed('play');
    }

    void verify(int variable) {}
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
            // children: [
            //   GestureDetector(
            //       //alignment: Alignment.bottomCenter,
            //       child: Image(
            //     height: 40,
            //     image: AssetImage('assets/images/selec.png'),
            //   )),
            //   GestureDetector(
            //       // onTap: () {
            //       //   audioController.playSfx(SfxType.buttonTap);
            //       //   GoRouter.of(context).go('/settings');
            //       // },
            //       child: Center(
            //           //alignment: Alignment.bottomCenter,
            //           child: Image(
            //     height: 40,
            //     image: AssetImage('assets/images/puntaje.png'),
            //   ))),
            // ],
          ),
          squarishMainArea: Column(
            children: [
              // GestureDetector(
              //     onTap: () {
              //       GoRouter.of(context).push('/jugar');
              //     },
              //     child: Image(
              //       height: 50,
              //       image: AssetImage('assets/images/atras.png'),
              //     )),
              // GestureDetector(
              //     //alignment: Alignment.bottomCenter,
              //     child: Image(
              //   height: 200,
              //   image: AssetImage('assets/images/container.png'),
              // )),

              const SizedBox(height: 0),
              Container(
                child: TextField(
                  controller: nombre,
                  decoration: const InputDecoration(
                      hintText: "Nombre", border: InputBorder.none),
                ),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: fecha_hora,
                  decoration: const InputDecoration(
                      hintText: "fecha_hora", border: InputBorder.none),
                ),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: dias_ano,
                  decoration: const InputDecoration(
                      hintText: "dias_año", border: InputBorder.none),
                ),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: continente,
                  decoration: const InputDecoration(
                      hintText: "continente", border: InputBorder.none),
                ),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: pais,
                  decoration: const InputDecoration(
                      hintText: "pais", border: InputBorder.none),
                ),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: ciudad,
                  decoration: const InputDecoration(
                      hintText: "ciudad", border: InputBorder.none),
                ),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: barrio,
                  decoration: const InputDecoration(
                      hintText: "barrio", border: InputBorder.none),
                ),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: presidente,
                  decoration: const InputDecoration(
                      hintText: "presidente", border: InputBorder.none),
                ),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: gobernador,
                  decoration: const InputDecoration(
                      hintText: "gobernador", border: InputBorder.none),
                ),
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: celebramos,
                  decoration: const InputDecoration(
                      hintText: "celebramos", border: InputBorder.none),
                ),
              ),
              ElevatedButton(
                  onPressed: register, child: const Text("Crear cuenta")),
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
                    GoRouter.of(context).go('/Cauno');
                  },
                  child: Image(
                    height: 50,
                    image: AssetImage('assets/images/atras.png'),
                  )),
              //   GestureDetector(
              //       onTap: () {
              //         audioController.playSfx(SfxType.buttonTap);

              //         GoRouter.of(context).go('/');
              //       },
              //       child: Image(
              //         height: 50,
              //         image: AssetImage('assets/images/home.png'),
              //       )),
              //   GestureDetector(
              //       onTap: () {
              //         audioController.playSfx(SfxType.buttonTap);

              //         GoRouter.of(context).push('/settings');
              //       },
              //       //alignment: Alignment.bottomCenter,
              //       child: Image(
              //         height: 50,
              //         image: AssetImage('assets/images/siguiente.png'),
              //       )),
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

void setState(Null Function() param0) {}
