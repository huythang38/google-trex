import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/sprite.dart';
import 'package:google_trex/game/horizon/config.dart';

class GroundMananger extends PositionComponent
    with Resizable, ComposedComponent {
  Ground firstGround, secondGround;

  GroundMananger(Image spriteImage) {
    Sprite softSprite = Sprite.fromImage(
      spriteImage,
      width: HorizonDimensions.width,
      height: HorizonDimensions.height,
      y: 104.0,
      x: 2.0,
    );

    Sprite bumpySprite = Sprite.fromImage(
      spriteImage,
      width: HorizonDimensions.width,
      height: HorizonDimensions.height,
      y: 104.0,
      x: 2.0 + HorizonDimensions.width,
    );

    this.firstGround = new Ground(softSprite);
    this.secondGround = new Ground(bumpySprite);

    this..add(firstGround)..add(secondGround);
  }

  void updateWithSpeed(double t, double speed) {
    Ground first = firstGround.x <= 0 ? firstGround : secondGround;
    Ground second = firstGround.x <= 0 ? secondGround : firstGround;
    first.x -= speed * 60 * t;
    second.x = first.x + HorizonDimensions.width;

    if (first.x <= -HorizonDimensions.width) {
      first.x += HorizonDimensions.width * 2;
      second.x = first.x - HorizonDimensions.width;
    }

    first.y = HorizonDimensions.posY - HorizonDimensions.incrementGroundY;
    second.y = HorizonDimensions.posY - HorizonDimensions.incrementGroundY;
  }
}

class Ground extends SpriteComponent with Resizable {
  Ground(Sprite sprite)
      : super.fromSprite(
            HorizonDimensions.width, HorizonDimensions.height, sprite);
}
