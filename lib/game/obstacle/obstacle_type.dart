import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:google_trex/game/collision/CollisionBox.dart';

class ObstacleType {
  final String type;
  final double width;
  final double height;
  final double y;
  final double minGap;
  final List<CollisionBox> collisionBoxes;

  const ObstacleType._internal(
    this.type, {
    this.width,
    this.height,
    this.y,
    this.minGap,
    this.collisionBoxes,
  });

  static const oneSmall = ObstacleType._internal("oneSmall",
      width: 34.0,
      height: 70.0,
      y: 6.0,
      minGap: 100.0,
      collisionBoxes: <CollisionBox>[
        CollisionBox(
          x: 0.0,
          y: 16.0,
          width: 10.0,
          height: 28.0,
        ),
        CollisionBox(
          x: 10.0,
          y: 0.0,
          width: 10.0,
          height: 66.0,
        ),
        CollisionBox(
          x: 20.0,
          y: 8.0,
          width: 10.0,
          height: 28.0,
        )
      ]);
  static const oneLarge = ObstacleType._internal("oneLarge",
      width: 50.0,
      height: 100.0,
      y: 0.0,
      minGap: 100.0,
      collisionBoxes: <CollisionBox>[
        CollisionBox(
          x: 0.0,
          y: 24.0,
          width: 16.0,
          height: 38.0,
        ),
        CollisionBox(
          x: 16.0,
          y: 0.0,
          width: 14.0,
          height: 96.0,
        ),
        CollisionBox(
          x: 30.0,
          y: 20.0,
          width: 16.0,
          height: 40.0,
        )
      ]);

  static const twoSmall = ObstacleType._internal("twoSmall",
      width: 68.0,
      height: 70.0,
      y: 6.0,
      minGap: 100.0,
      collisionBoxes: <CollisionBox>[
        CollisionBox(
          x: 0.0,
          y: 16.0,
          width: 10.0,
          height: 28.0,
        ),
        CollisionBox(
          x: 10.0,
          y: 0.0,
          width: 44.0,
          height: 66.0,
        ),
        CollisionBox(
          x: 54.0,
          y: 14.0,
          width: 10.0,
          height: 36.0,
        )
      ]);
  static const twoLarge = ObstacleType._internal("twoLarge",
      width: 98.0,
      height: 100.0,
      y: 0.0,
      minGap: 100.0,
      collisionBoxes: <CollisionBox>[
        CollisionBox(
          x: 0.0,
          y: 24.0,
          width: 16.0,
          height: 38.0,
        ),
        CollisionBox(
          x: 16.0,
          y: 0.0,
          width: 64.0,
          height: 96.0,
        ),
        CollisionBox(
          x: 80.0,
          y: 20.0,
          width: 14.0,
          height: 38.0,
        )
      ]);

  static const threeSmall = ObstacleType._internal("threeSmall",
      width: 102.0,
      height: 70.0,
      y: 6.0,
      minGap: 100.0,
      collisionBoxes: <CollisionBox>[
        CollisionBox(
          x: 0.0,
          y: 16.0,
          width: 10.0,
          height: 28.0,
        ),
        CollisionBox(
          x: 10.0,
          y: 0.0,
          width: 78.0,
          height: 66.0,
        ),
        CollisionBox(
          x: 88.0,
          y: 8.0,
          width: 10.0,
          height: 32.0,
        )
      ]);
  static const threeLarge = ObstacleType._internal("threeLarge",
      width: 102.0,
      height: 100.0,
      y: 0.0,
      minGap: 100.0,
      collisionBoxes: <CollisionBox>[
        CollisionBox(
          x: 0.0,
          y: 24.0,
          width: 12.0,
          height: 34.0,
        ),
        CollisionBox(
          x: 12.0,
          y: 4.0,
          width: 10.0,
          height: 92.0,
        ),
        CollisionBox(
          x: 22.0,
          y: 14.0,
          width: 30.0,
          height: 82.0,
        ),
        CollisionBox(
          x: 52.0,
          y: 12.0,
          width: 16.0,
          height: 84.0,
        ),
        CollisionBox(
          x: 68.0,
          y: 0.0,
          width: 14.0,
          height: 96.0,
        ),
        CollisionBox(
          x: 82.0,
          y: 22.0,
          width: 16.0,
          height: 38.0,
        )
      ]);

  static Sprite spriteForType(ObstacleType type, Image spriteImage) {
    switch (type) {
      case oneSmall:
        return Sprite.fromImage(spriteImage,
            x: 446.0, y: 2.0, width: type.width, height: type.height);
      case oneLarge:
        return Sprite.fromImage(spriteImage,
            x: 652.0, y: 2.0, width: type.width, height: type.height);
      case twoSmall:
        return Sprite.fromImage(spriteImage,
            x: 548.0, y: 2.0, width: type.width, height: type.height);
      case twoLarge:
        return Sprite.fromImage(spriteImage,
            x: 652.0, y: 2.0, width: type.width, height: type.height);
      case threeSmall:
        return Sprite.fromImage(spriteImage,
            x: 548.0, y: 2.0, width: type.width, height: type.height);
      case threeLarge:
        return Sprite.fromImage(spriteImage,
            x: 850.0, y: 2.0, width: type.width, height: type.height);
      default:
        return null;
    }
  }
}
