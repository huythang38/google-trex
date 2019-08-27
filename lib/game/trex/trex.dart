import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:google_trex/game/horizon/config.dart';
import 'package:google_trex/game/trex/config.dart';
import 'package:google_trex/game/trex/trex_type.dart';

class Trex extends PositionComponent with Resizable, ComposedComponent {
  TrexStatus status;
  TrexType trexType;
  double jumpVelocity;
  double posY;

  Trex(Image spriteImage) {
    this.trexType = new TrexType(spriteImage);
    reset();
    status = TrexStatus.waiting;
  }

  PositionComponent get actual {
    return trexType.getTrexWithType(status);
  }

  @override
  void render(Canvas canvas) {
    this.actual.render(canvas);
  }

  @override
  void resize(Size size) {
    this.y = HorizonDimensions.posY - TrexConfig.height;
    this.posY = this.y;
  }

  void update(double t) {
    if (status == TrexStatus.waiting) {
      this.posY = y;
    }

    if (status == TrexStatus.jumping) {
      posY += jumpVelocity;
      this.jumpVelocity += TrexConfig.gravity;
      if (this.posY > this.y) {
        this.status = TrexStatus.running;
        reset();
      }
    }

    this.actual.x = 40;
    this.actual.y = this.posY;
    this.actual.update(t);
  }

  void reset() {
    this.status = TrexStatus.running;
    this.jumpVelocity = TrexConfig.jumpVelocity;
    this.posY = this.y;
  }
}
