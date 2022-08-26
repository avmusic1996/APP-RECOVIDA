// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import '../level_selection/levels.dart';

// class BatmanPageRoute extends PageRouteBuilder
// {
//   final Widget child;
//   BatmanPageRoute(this.child)
//     :super(
//       pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation)
//       {
//         return child;
//       }, transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child)
//       {
//         return FadeTransition
//         (opacity: animation,
//         child: child,
//         );
//       }
//     );
// }
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//       onGenerateRoute: (settings) {
//         switch (settings.name) {
//           case '/second':
//             return PageTransition(
//               child: ThirdPage(),
//               type: PageTransitionType.fade,
//               settings: settings,
//               reverseDuration: Duration(seconds: 3),
//             );
//             break;
//           default:
//             return null;
//         }
//       },
//     );
//   }
// }
//   /// Page Title
// class ThirdPage extends StatelessWidget {
//   /// Page Title
//   final String title;

//   /// second page constructor
//   const ThirdPage({Key? key, required this.title}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Page Transition Plugin"),
//       ),
//       body: Center(
//         child: Text('ThirdPage Page'),
//       ),
//     );
//   }
// }

class OrientationSwitcher extends StatelessWidget {
  final List<Widget> children;
  const OrientationSwitcher({
    Key? key,
    required this.children,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? Column(children: children)
        : Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
  }
}

class LevelSelection extends StatelessWidget {
  const LevelSelection({super.key});
  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();
    final audioController = context.watch<AudioController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double isPortrait2 = 0;
    double isPortrait3 = 0;
    var _gap = SizedBox(height: 0);

    if (screenWidth >= screenHeight) {
      _gap = SizedBox(height: 0);
      isPortrait2 = screenHeight * 0.37;
      isPortrait3 = screenWidth * 0.20;
      ;
    } else {
      isPortrait2 = screenHeight * 0.22;
      isPortrait3 = screenWidth * 0.80;
      ;
    }
    ;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/fondolevels.png'),
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
                  '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'arial',
                      fontSize: 30),
                ),
              ),
              const SizedBox(height: 0),

              OrientationSwitcher(children: <Widget>[
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go('/Cauno');
                  },
                  child: Container(
                    height: isPortrait2,
                    width: isPortrait3,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8.0),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      // color:Colors.green,
                      image: new DecorationImage(
                        image: ExactAssetImage('assets/images/cate1.gif'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),

                    // child: Text("1",style: TextStyle(color:Color.fromARGB(255, 255, 255, 255),fontSize:14),),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go('/Cados');
                  },
                  child: Container(
                    height: isPortrait2,
                    width: isPortrait3,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8.0),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      image: new DecorationImage(
                        image: ExactAssetImage('assets/images/cate2.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),

                    // child: Text("2",style: TextStyle(color:Color.fromARGB(255, 255, 255, 255),fontSize:14),),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go('/Catres');
                  },
                  child: Container(
                    height: isPortrait2,
                    width: isPortrait3,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8.0),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      image: new DecorationImage(
                        image: ExactAssetImage('assets/images/cate3.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),

                    // child: Text("1",style: TextStyle(color:Color.fromARGB(255, 255, 255, 255),fontSize:14),
                    // ),
                  ),
                )
                // place children here like its a column or row.
              ]),

              //   children: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     GestureDetector(
              //         onTap: () {
              //           audioController.playSfx(SfxType.buttonTap);

              //           GoRouter.of(context).go('/play');
              //         },
              //         child: Image(
              //           height: 70,
              //           image: AssetImage('assets/images/star.png'),
              //         )),
              //   ],
              // ),
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
                    GoRouter.of(context).go('/play');
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
