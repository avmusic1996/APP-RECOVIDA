// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../games_services/games_services.dart';
import '../settings/settings.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import 'package:lottie/lottie.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final gamesServicesController = context.watch<GamesServicesController?>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/fondo2.png'),
            fit: BoxFit.cover,
          ),
        ),

        // alignment: Alignment.topCenter,
        // child:
        //     Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       GestureDetector(
        //           onTap: () {
        //             audioController.playSfx(SfxType.buttonTap);
        //             GoRouter.of(context).go('/settings');
        //           },
        //           child: Image(
        //             height: 40,
        //             image: AssetImage('assets/images/configuracion.png'),
        //           )),
        //     ],
        //   ),
        //   Lottie.asset('assets/images/logo.json'),
        //   GestureDetector(
        //       child: Image(
        //     height: 170,
        //     image: AssetImage('assets/images/recovida.png'),
        //   )),
        //   GestureDetector(
        //     child: const Text(
        //       'AYUDANOS A AYUDARTE',
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         fontFamily: 'Arial',
        //         fontSize: 20,
        //         height: 1,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        //   _gap,
        //   GestureDetector(
        //       onTap: () {
        //         audioController.playSfx(SfxType.buttonTap);

        //         GoRouter.of(context).go('/play');
        //       },
        //       child: Image(
        //         height: 20,
        //         image: AssetImage('assets/images/boton.png'),
        //       )),
        //   _gap,
        // ]),

        child: ResponsiveScreen(
          mainAreaProminence: 0.85,
          squarishMainArea: GestureDetector(
              onTap: () {
                audioController.playSfx(SfxType.buttonTap);
                GoRouter.of(context).go('/settings');
              },
              child: Image(
                height: 20,
                image: AssetImage('assets/images/configuracion.png'),
              )),
          rectangularMenuArea: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                  child: Image(
                height: 120,
                image: AssetImage('assets/images/recovida.png'),
              )),
              GestureDetector(
                  onTap: () {
                    audioController.playSfx(SfxType.buttonTap);

                    GoRouter.of(context).go('/play');
                  },
                  child: Image(
                    height: 50,
                    image: AssetImage('assets/images/boton.png'),
                  )),

              if (gamesServicesController != null) ...[
                _hideUntilReady(
                  ready: gamesServicesController.signedIn,
                  child: ElevatedButton(
                    onPressed: () => gamesServicesController.showAchievements(),
                    child: const Text('Achievements'),
                  ),
                ),
                _gap,
                _hideUntilReady(
                  ready: gamesServicesController.signedIn,
                  child: ElevatedButton(
                    onPressed: () => gamesServicesController.showLeaderboard(),
                    child: const Text('Leaderboard'),
                  ),
                ),
                _gap,
              ],

              _gap,
              // Padding(
              //   padding: const EdgeInsets.only(top: 32),
              //   child: ValueListenableBuilder<bool>(
              //     valueListenable: settingsController.muted,
              //     builder: (context, muted, child) {
              //       return IconButton(
              //         onPressed: () => settingsController.toggleMuted(),
              //         icon: Icon(muted ? Icons.volume_off : Icons.volume_up),
              //       );
              //     },
              //   ),
              // ),
              // _gap,
              // const Text('Musica'),
              // _gap,
            ],
          ),
        ),
      ),
    );
  }

  /// Prevents the game from showing game-services-related menu items
  /// until we're sure the player is signed in.
  ///
  /// This normally happens immediately after game start, so players will not
  /// see any flash. The exception is folks who decline to use Game Center
  /// or Google Play Game Services, or who haven't yet set it up.
  Widget _hideUntilReady({required Widget child, required Future<bool> ready}) {
    return FutureBuilder<bool>(
      future: ready,
      builder: (context, snapshot) {
        // Use Visibility here so that we have the space for the buttons
        // ready.
        return Visibility(
          visible: snapshot.data ?? false,
          maintainState: true,
          maintainSize: true,
          maintainAnimation: true,
          child: child,
        );
      },
    );
  }

  static const _gap = SizedBox(height: 30);
  static const _gap1 = SizedBox(height: 10);
}
