import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/sprite.dart';
import 'package:google_trex/game/horizon/config.dart';

class GameOverPanel extends PositionComponent with ComposedComponent {
  SpriteComponent restartButton, gameOverText;
  bool isVisible = false;

  GameOverPanel(Image spriteImage) {
    this.restartButton = SpriteComponent.fromSprite(72.0, 64.0,
        Sprite.fromImage(spriteImage, x: 2, y: 2, width: 72, height: 64));

    this.gameOverText = SpriteComponent.fromSprite(381.0, 21.0,
        Sprite.fromImage(spriteImage, x: 954, y: 29, width: 381, height: 21));

    this..add(restartButton)..add(gameOverText);
  }

  @override
  void resize(Size size) {
    restartButton.x = (size.width - restartButton.width) / 2;
    restartButton.y = HorizonDimensions.posY - restartButton.height - 40;

    gameOverText.x = (size.width - gameOverText.width) / 2;
    gameOverText.y = restartButton.y - gameOverText.height - 30;
  }

  @override
  void render(Canvas canvas) {
    if (!isVisible) return;
    super.render(canvas);
  }
}
