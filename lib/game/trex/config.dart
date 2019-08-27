import 'package:google_trex/game/collision/CollisionBox.dart';

class TrexConfig {
  static const double width = 88.0;
  static const double height = 94.0;

  static const double gravity = 0.7;
  static const double jumpVelocity = -13;
}

class TrexCollisionBoxes {
  static final List<CollisionBox> running = <CollisionBox>[
    CollisionBox(x: 40.0, y: 0.0, width: 40.0, height: 22.0),
    CollisionBox(x: 40.0, y: 22.0, width: 32.0, height: 8.0),
    CollisionBox(x: 0.0, y: 30.0, width: 64.0, height: 16.0),
    CollisionBox(x: 0.0, y: 46.0, width: 56.0, height: 10.0),
    CollisionBox(x: 8.0, y: 56.0, width: 44.0, height: 6.0),
    CollisionBox(x: 19.0, y: 62.0, width: 29.0, height: 24.0)
  ];
}
