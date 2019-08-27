import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/sprite.dart';
import 'package:google_trex/game/horizon/config.dart';
import 'package:google_trex/game/obstacle/config.dart';
import 'package:google_trex/game/obstacle/obstacle_type.dart';
import 'package:google_trex/game/util.dart';

class ObstacleManager extends PositionComponent
    with Resizable, ComposedComponent {
  Image spriteImage;
  ObstacleManager(this.spriteImage) : super();

  void updateWithSpeed(double t, double speed) {
    components.removeWhere((c) {
      Obstacle obstacle = c as Obstacle;
      return obstacle.toRemove;
    });

    if (components.length > 0) {
      components.forEach((c) {
        Obstacle obstacle = c as Obstacle;
        obstacle.updateWithSpeed(t, speed);
      });

      Obstacle lastObstacle = components.last as Obstacle;
      if ((lastObstacle.x + lastObstacle.width + lastObstacle.gap) <
          HorizonDimensions.width) {
        this.addNewObstacle(speed);
      }
    } else {
      addNewObstacle(speed);
    }
  }

  void addNewObstacle(double speed) {
    ObstacleType type = randomType(speed);
    Sprite obstacleSprite = ObstacleType.spriteForType(type, spriteImage);
    Obstacle obstacle = Obstacle(type, obstacleSprite, speed);

    obstacle.x = HorizonDimensions.width;

    components.add(obstacle);
  }

  ObstacleType randomType(double speed) {
    int r = speed < 6 ? 3 : 6;
    switch (rnd.nextInt(r)) {
      case 0:
        return ObstacleType.oneSmall;
      case 1:
        return ObstacleType.oneLarge;
      case 2:
        return ObstacleType.twoSmall;
      case 3:
        return ObstacleType.twoLarge;
      case 4:
        return ObstacleType.threeSmall;
      case 5:
        return ObstacleType.threeLarge;
      default:
        return null;
    }
  }

  void reset() {
    components.clear();
  }
}

class Obstacle extends SpriteComponent with Resizable {
  ObstacleType type;

  bool toRemove = false;
  bool followingObstacleCreated = false;
  double gap = 0.0;
  double width = 0.0;

  Obstacle(this.type, Sprite sprite, double speed)
      : super.fromSprite(type.width, type.height, sprite) {
    this.y = HorizonDimensions.posY - type.height - type.y;
    Rect actualSrc = this.sprite.src;
    this.sprite.src =
        Rect.fromLTWH(actualSrc.left, actualSrc.top, width, actualSrc.height);

    gap = this.getGap(speed);
    this.width = width;
  }

  void updateWithSpeed(double t, double speed) {
    if (toRemove) return;
    x -= speed * 60 * t;

    if (!isVisible) toRemove = true;
  }

  bool get isVisible {
    return x > -(width + gap);
  }

  double getGap(double speed) {
    double minGap = (width * speed * type.minGap * 0.01).round() / 1;
    minGap = minGap < 300 ? 300 : minGap > 1200 ? 1200 : minGap;
    double maxGap = (minGap * ObstacleConfig.maxGapCoefficient).round() / 1;
    return getRandomNum(minGap, maxGap);
  }
}
