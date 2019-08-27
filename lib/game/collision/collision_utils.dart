import 'package:google_trex/game/collision/CollisionBox.dart';
import 'package:google_trex/game/obstacle/obstacle.dart';
import 'package:google_trex/game/trex/config.dart';
import 'package:google_trex/game/trex/trex.dart';

bool checkForCollision(Obstacle obstacle, Trex trex) {
  CollisionBox tRexBox = CollisionBox(
    x: trex.actual.x + 4,
    y: trex.actual.y + 4,
    width: TrexConfig.width - 8,
    height: TrexConfig.height - 8,
  );

  CollisionBox obstacleBox = CollisionBox(
    x: obstacle.x + 2,
    y: obstacle.y + 2,
    width: obstacle.type.width - 4,
    height: obstacle.type.height - 4,
  );

  if (boxCompare(tRexBox, obstacleBox)) {
    List<CollisionBox> collisionBoxes = obstacle.type.collisionBoxes;
    List<CollisionBox> tRexCollisionBoxes = TrexCollisionBoxes.running;

    bool crashed = false;

    collisionBoxes.forEach((obstacleCollisionBox) {
      CollisionBox adjObstacleBox =
          createAdjustedCollisionBox(obstacleCollisionBox, obstacleBox);

      tRexCollisionBoxes.forEach((tRexCollisionBox) {
        if (crashed) return;
        CollisionBox adjTrexBox =
            createAdjustedCollisionBox(tRexCollisionBox, tRexBox);
        crashed = boxCompare(adjTrexBox, adjObstacleBox);
      });
    });
    return crashed;
  }
  return false;
}

bool boxCompare(CollisionBox tRexBox, CollisionBox obstacleBox) {
  final double obstacleX = obstacleBox.x;
  final double obstacleY = obstacleBox.y;

  return (tRexBox.x < obstacleX + obstacleBox.width &&
      tRexBox.x + tRexBox.width > obstacleX &&
      tRexBox.y < obstacleBox.y + obstacleBox.height &&
      tRexBox.height + tRexBox.y > obstacleY);
}

CollisionBox createAdjustedCollisionBox(
    CollisionBox box, CollisionBox adjustment) {
  return CollisionBox(
      x: box.x + adjustment.x,
      y: box.y + adjustment.y,
      width: box.width,
      height: box.height);
}
