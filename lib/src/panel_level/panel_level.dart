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
import '../level_selection/levels.dart';

class LevelSelection extends StatelessWidget {
  const LevelSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();
    final audioController = context.watch<AudioController>();

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
                  'Selecciona la categoria',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontFamily: 'Britannic Bold',
                      fontSize: 30),
                ),
              ),
              const SizedBox(height: 0),
              Expanded(
                child: ListView(
                  children: [
                    for (final level in gameLevels)
                      ListTile(
                        //style: TextStyle(),
                        enabled: playerProgress.highestLevelReached >=
                            level.number - 1,
                        onTap: () {
                          final audioController =
                              context.read<AudioController>();
                          audioController.playSfx(SfxType.buttonTap);

                          GoRouter.of(context)
                              .go('/play/session/${level.number}');
                        },
                        leading: Text(level.number.toString()),
                        title: Text('Level #${level.number}'),
                        textColor: Colors.black,
                      )
                  ],
                ),
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
          rectangularMenuArea: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go('/play');
                  },
                  child: Image(
                    height: 50,
                    image: AssetImage('assets/images/home.png'),
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
