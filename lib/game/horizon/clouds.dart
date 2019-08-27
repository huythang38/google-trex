import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components/composed_component.dart';
import 'package:google_trex/game/horizon/config.dart';
import 'package:google_trex/game/util.dart';

class CloudManager extends PositionComponent with Resizable, ComposedComponent {
  Image spriteImage;
  CloudManager(this.spriteImage) : super();

  void updateWithSpeed(double t, double speed) {
    final double cloudSpeed = HorizonConfig.bgCloudSpeed * speed;
    final int numClouds = this.components.length;

    if (numClouds > 0) {
      components.forEach((c) {
        Cloud cloud = c as Cloud;
        cloud.updateWithSpeed(t, cloudSpeed);
      });

      Cloud lastCloud = components.last;
      if ((HorizonDimensions.width - lastCloud.x) > lastCloud.cloudGap) {
        addCloud();
      }
    } else {
      addCloud();
    }

    components.removeWhere((c) {
      Cloud cloud = c as Cloud;
      return cloud.toRemove;
    });
  }

  addCloud() {
    Cloud cloud = Cloud(spriteImage);
    cloud.x = HorizonDimensions.width;
    cloud.y = getRandomNum(CloudConfig.minSkyLevel,
        HorizonDimensions.posY - CloudConfig.maxSkyLevel);
    components.add(cloud);
  }

  void reset() {
    components.clear();
  }
}

class Cloud extends SpriteComponent {
  bool toRemove = false;
  final double cloudGap;

  Cloud(Image spriteImage)
      : cloudGap =
            getRandomNum(CloudConfig.minCloudGap, CloudConfig.maxCloudGap),
        super.fromSprite(
            CloudConfig.width,
            CloudConfig.height,
            Sprite.fromImage(
              spriteImage,
              width: CloudConfig.width,
              height: CloudConfig.height,
              y: 2.0,
              x: 166.0,
            ));

  void updateWithSpeed(double t, double speed) {
    if (toRemove) return;
    x -= speed * 60 * t;

    if (!isVisible) toRemove = true;
  }

  bool get isVisible {
    return x + CloudConfig.width > 0;
  }
}
