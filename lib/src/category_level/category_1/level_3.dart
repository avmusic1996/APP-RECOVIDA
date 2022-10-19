// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'providers/login_form_provider.dart';
import 'widgets/input_decorations.dart';
import 'widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../player_progress/player_progress.dart';
import '../../style/palette.dart';
import '../../style/responsive_screen.dart';
import '../../level_selection/levels.dart';
import '../panel_level.dart';

class LevelTres extends StatelessWidget {
  const LevelTres({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();
    final audioController = context.watch<AudioController>();
    final nombre = TextEditingController();

    final url = ("http://app-juegos.epizy.com/planificacion/nivel1.php");
    void showSnackBar(String msg) {
      final snack = SnackBar(content: Text(msg));
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }

    Future<void> register() async {
      final user = {
        "nombre": nombre.text,
      };
      //final res = await http.post(url, headers: headers, body: jsonEncode(user));
      final res = await http.post(Uri.parse(url), body: {
        "nombre": nombre.text,
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

      //Navigator.of(context).go('Cauno');
    }

    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          //   body: Container(
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: ExactAssetImage('assets/images/nature1.png'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Column(
            children: [
              SizedBox(height: 190),
              CardContainer(
                  child: Column(
                children: [
                  SizedBox(height: 10),
                  Text('Nombre', style: Theme.of(context).textTheme.headline4),
                  GestureDetector(
                      child: Center(
                          //alignment: Align.ment.bottomCenter,
                          child: Image(
                    height: 310,
                    image: AssetImage('assets/images/animationlogo.gif'),
                  ))),
                  SizedBox(height: 10),
                  ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(), child: _LoginForm())
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nombreForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: nombreForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              controller: nombre,
              autocorrect: false,
              //keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Ej: Lucas gomez',
                  labelText: 'Digite su nombre',
                  prefixIcon: Icons.account_circle),
              onChanged: (value) => nombreForm.nombre = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'El nombre debe terner mas letras';
              },
            ),
            SizedBox(height: 10),
            // TextFormField(
            //   autocorrect: false,
            //   obscureText: true,
            //   keyboardType: TextInputType.emailAddress,
            //   decoration: InputDecorations.authInputDecoration(
            //       hintText: '*****',
            //       labelText: 'Contraseña',
            //       prefixIcon: Icons.lock_outline),
            //   onChanged: (value) => nombreForm.password = value,
            //   validator: (value) {
            //     return (value != null && value.length >= 6)
            //         ? null
            //         : 'La contraseña debe de ser de 6 caracteres';
            //   },
            // ),
            SizedBox(height: 40),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text(
                      nombreForm.isLoading ? 'Espere' : 'siguiente',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                onPressed: nombreForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        if (!nombreForm.isValidForm()) return;

                        nombreForm.isLoading = true;

                        await Future.delayed(Duration(seconds: 2));

                        // TODO: validar si el nombre es correcto
                        nombreForm.isLoading = false;

                        Navigator.pushReplacementNamed(context, 'home');
                      })
          ],
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
