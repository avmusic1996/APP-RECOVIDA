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
            image: ExactAssetImage('assets/images/nature.jpg'),
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
              // GestureDetector(
              //     //alignment: Alignment.bottomCenter,
              //     child: Image(
              //   height: 200,
              //   image: AssetImage('assets/images/container.png'),
              // )),
              const Padding(
                padding: EdgeInsets.all(09),
                child: Text(
                  'Bienvenido',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'arial',
                      fontSize: 30),
                ),
              ),
              const SizedBox(height: 0),
              // Expanded(
              //   child: ListView(
              //     children: [
              //       for (final level in gameLevels)
              //         ListTile(
              //           //style: TextStyle(),
              //           enabled: playerProgress.highestLevelReached >=
              //               level.number - 1,
              //           onTap: () {
              //             final audioController =
              //                 context.read<AudioController>();
              //             audioController.playSfx(SfxType.buttonTap);

              //             GoRouter.of(context)
              //                 .go('/play/session/${level.number}');
              //           },
              //           leading: Text(level.number.toString()),
              //           title: Text('Level #${level.number}'),
              //           textColor: Colors.black,
              //         )
              //     ],
              //   ),
              // ),
              GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go('/jugar');
                  },
                  child: Image(
                    height: 50,
                    image: AssetImage('assets/images/jugar.png'),
                  )),
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
                    audioController.playSfx(SfxType.buttonTap);

                    GoRouter.of(context).go('/');
                  },
                  child: Image(
                    height: 50,
                    image: AssetImage('assets/images/home.png'),
                  )),
              GestureDetector(
                  onTap: () {
                    audioController.playSfx(SfxType.buttonTap);

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
