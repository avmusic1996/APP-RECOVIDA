// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../games_services/games_services.dart';
import '../settings/settings.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final gamesServicesController = context.watch<GamesServicesController?>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // double sizerecovide = 10;

    // if (width <= height) {
    //   // ignore: unused_local_variable
    //   double sizerecovida = 100;
    // } else {
    //   // ignore: unused_local_variable
    //   double sizerecovida = 140;
    // }

    return Scaffold(
      //backgroundColor: palette.backgroundMain,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/fondo2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ResponsiveScreen(
          mainAreaProminence: 0.45,
          topMessageArea: Column(
            children: [
              // GestureDetector(
              //     onTap: () {
              //       audioController.playSfx(SfxType.buttonTap);
              //       GoRouter.of(context).go('/settings');
              //     },
              //     child: Align(
              //         alignment: Alignment.center,
              //         child: Image(
              //           height: 140,
              //           image: AssetImage('assets/images/logo.gif'),
              //         ))),
              GestureDetector(
                  onTap: () {
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).go('/settings');
                  },
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Image(
                        height: 40,
                        image: AssetImage('assets/images/configuracion.png'),
                      ))),
            ],
          ),
          squarishMainArea: Center(
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      audioController.playSfx(SfxType.buttonTap);
                      GoRouter.of(context).go('/settings');
                    },
                    child: Align(
                        alignment: Alignment.center,
                        child: Image(
                          height: 140,
                          image: AssetImage('assets/images/logo.gif'),
                        ))),
                GestureDetector(
                    child: Align(
                        alignment: Alignment.center,
                        child: Image(
                          height: 100,
                          image: AssetImage('assets/images/recovida.png'),
                        ))),
              ],
            ),
          ),
          rectangularMenuArea: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    audioController.playSfx(SfxType.buttonTap);

                    GoRouter.of(context).go('/play');
                  },
                  child: Image(
                    height: 50,
                    image: AssetImage('assets/images/boton.png'),
                  )),
              _gap,
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
              // GestureDetector(
              //     onTap: () {
              //       audioController.playSfx(SfxType.buttonTap);
              //       GoRouter.of(context).go('/settings');
              //     },
              //     child: Align(
              //         //alignment: Alignment.centerRight,
              //         child: Image(
              //       height: 40,
              //       image: AssetImage('assets/images/configuracion.png'),
              //     ))),
              // _gap,
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
              // const Text('Music by Mr Smith'),
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

  static const _gap = SizedBox(height: 10);
}
