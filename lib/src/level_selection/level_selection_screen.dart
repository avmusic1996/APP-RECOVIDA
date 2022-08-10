// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import 'levels.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/fondos.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      audioController.playSfx(SfxType.buttonTap);
                      GoRouter.of(context).go('/settings');
                    },
                    child: Image(
                      height: 40,
                      image: AssetImage('assets/images/configuracion.png'),
                    )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'Selecciona el nivel',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'arial',
                      fontSize: 30),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: ListView(
                children: [
                  for (final level in gameLevels)
                    ListTile(
                      //style: TextStyle(),
                      enabled: playerProgress.highestLevelReached >=
                          level.number - 1,
                      onTap: () {
                        final audioController = context.read<AudioController>();
                        audioController.playSfx(SfxType.buttonTap);

                        GoRouter.of(context)
                            .go('/play/session/${level.number}');
                      },
                      leading: Text(level.number.toString()),
                      title: Text('Level #${level.number}'),
                      textColor: Colors.white,
                    )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    child: Image(
                      height: 50,
                      image: AssetImage('assets/images/atras.png'),
                    )),
              ],
            ),
          ],
        ),
        // rectangularMenuArea: ElevatedButton(
        //   onPressed: () {
        //     GoRouter.of(context).pop();
        //   },
        //   child: const Text('Back'),
        // ),
      ),
    );
  }
}
