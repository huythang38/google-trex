import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:google_trex/game/trex/config.dart';

enum TrexStatus { jumping, running, waiting, crashed }

class TrexType {
  SpriteComponent _jumping, _crashed;
  AnimationComponent _running;

  TrexType(Image spriteImage) {
    // this._waiting = new SpriteComponent.fromSprite(
    //     TrexConfig.width,
    //     TrexConfig.height,
    //     Sprite.fromImage(spriteImage,
    //         width: 88.0, height: 94.0, x: 76.0, y: 2.0));

    this._running = new AnimationComponent(
        TrexConfig.width,
        TrexConfig.height,
        Animation.spriteList([
          Sprite.fromImage(spriteImage,
              width: 88.0, height: 94.0, x: 1514.0, y: 2.0),
          Sprite.fromImage(spriteImage,
              width: 88.0, height: 94.0, x: 1602.0, y: 2.0),
        ], stepTime: 0.2, loop: true));

    this._jumping = new SpriteComponent.fromSprite(
        TrexConfig.width,
        TrexConfig.height,
        Sprite.fromImage(spriteImage,
            width: 88.0, height: 94.0, x: 1338.0, y: 2.0));

    this._crashed = new SpriteComponent.fromSprite(
        TrexConfig.width,
        TrexConfig.height,
        Sprite.fromImage(spriteImage,
            width: 88.0, height: 94.0, x: 1778.0, y: 2.0));
  }

  PositionComponent getTrexWithType(TrexStatus status) {
    switch (status) {
      case TrexStatus.waiting:
        return _jumping;
      case TrexStatus.running:
        return _running;
      case TrexStatus.jumping:
        return _jumping;
      case TrexStatus.crashed:
        return _crashed;
      default:
        return null;
    }
  }
}
