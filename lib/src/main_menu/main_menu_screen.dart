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

  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final gamesServicesController = context.watch<GamesServicesController?>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double isPortrait = 0;
    double isPortrait2 = 0;
    var _gap = SizedBox(height: 100);

    if (screenWidth >= screenHeight) {
      _gap = SizedBox(height: 0);

      isPortrait = screenHeight * 0.24;

      isPortrait2 = 110;

      isPortrait = screenHeight * 0.20;
      isPortrait2 = 130;
    } else {
      isPortrait = 150;
      isPortrait2 = 200;
    }
    return Scaffold(
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
              //         alignment: Alignment.centerRight,
              //         child: Image(
              //           height: 40,
              //           image: AssetImage('assets/images/configuracion.png'),
              //         ))),
              _gap,
              GestureDetector(
                  child: Align(
                      alignment: Alignment.center,
                      child: Image(
                        height: isPortrait,
                        image: AssetImage('assets/images/recovida.png'),
                      ))),
              GestureDetector(
                  child: Align(
                      alignment: Alignment.center,
                      child: Image(
                        height: isPortrait2,
                        image: AssetImage('assets/images/logo.gif'),
                      ))),

              
            ],
          ),
          squarishMainArea: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    audioController.playSfx(SfxType.buttonTap);

                    GoRouter.of(context).go('/play');
                  },
                  child: Image(
                    height: 70,
                    image: AssetImage('assets/images/star.png'),
                  )),
              
            ],
          ),
          rectangularMenuArea: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (gamesServicesController != null) ...[
                _hideUntilReady(
                  ready: gamesServicesController.signedIn,
                  child: ElevatedButton(
                    onPressed: () => gamesServicesController.showAchievements(),
                    child: const Text('Achievements'),
                  ),
                ),
                _hideUntilReady(
                  ready: gamesServicesController.signedIn,
                  child: ElevatedButton(
                    onPressed: () => gamesServicesController.showLeaderboard(),
                    child: const Text('Leaderboard'),
                  ),
                ),
              ],
              const Text('Ayudanos a ayudarte'),

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


