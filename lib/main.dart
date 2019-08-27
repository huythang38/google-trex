import 'dart:ui' as ui;

import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_trex/game/Game.dart';

void main() async {
  await Flame.util.fullScreen();
  await Flame.util.setOrientation(DeviceOrientation.landscapeLeft);

  ui.Image spriteImage = await Flame.images.load("sprite.png");
  TrexGame game = new TrexGame(spriteImage);

  runApp(MaterialApp(
    title: 'TRex Game',
    home: Scaffold(
      body: GameWrapper(game),
    ),
  ));

  Flame.util.addGestureRecognizer(new TapGestureRecognizer()
    ..onTapDown = (TapDownDetails evt) => game.onTap());
}

class GameWrapper extends StatefulWidget {
  final TrexGame trexGame;
  GameWrapper(this.trexGame);

  @override
  _GameWrapperState createState() {
    return _GameWrapperState();
  }
}

class _GameWrapperState extends State<GameWrapper> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(ui.AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
        widget.trexGame.pause();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.trexGame.widget;
  }
}
