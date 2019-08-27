import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:google_trex/game/horizon/clouds.dart';
import 'package:google_trex/game/horizon/ground.dart';
import 'package:google_trex/game/obstacle/obstacle.dart';

class Horizon extends PositionComponent with Resizable, ComposedComponent {
  CloudManager cloudManager;
  GroundMananger groundManager;
  ObstacleManager obstacleManager;

  Horizon(Image spriteImage) {
    this.cloudManager = new CloudManager(spriteImage);
    this.groundManager = new GroundMananger(spriteImage);
    this.obstacleManager = new ObstacleManager(spriteImage);
    this..add(this.cloudManager)..add(groundManager)..add(obstacleManager);
  }

  updateWithSpeed(double t, double speed) {
    this.groundManager.updateWithSpeed(t, speed);
    this.cloudManager.updateWithSpeed(t, speed);
    this.obstacleManager.updateWithSpeed(t, speed);
  }

  reset() {
    cloudManager.reset();
    obstacleManager.reset();
  }
}
