import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:google_trex/game/collision/collision_utils.dart';
import 'package:google_trex/game/config.dart';
import 'package:google_trex/game/game_over/game_over.dart';
import 'package:google_trex/game/horizon/config.dart';
import 'package:google_trex/game/horizon/horizon.dart';
import 'package:google_trex/game/obstacle/obstacle.dart';
import 'package:google_trex/game/trex/trex.dart';
import 'package:google_trex/game/trex/trex_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum GameStatus { waiting, playing, gameOver, pausing }

class TrexGame extends BaseGame {
  GameOverPanel gameOverPanel;
  Horizon horizon;
  Trex trex;
  double currentSpeed;
  GameStatus status = GameStatus.waiting;

  final TextConfig textConfig = TextConfig(
      color: const Color(0xFF000000),
      fontFamily: "PixelEmulator",
      fontSize: 20);
  double score = 0;
  int hiScore = 0;

  TrexGame(Image spriteImage) {
    initialize(spriteImage);
  }

  void initialize(Image spriteImage) async {
    hiScore = await getHightScore();
    resize(await Flame.util.initialDimensions());
    HorizonDimensions.posY =
        size.height / 2 + 40 + HorizonDimensions.incrementGroundY;

    this.currentSpeed = GameConfig.speed;
    this.horizon = new Horizon(spriteImage);
    this.trex = new Trex(spriteImage);
    this.gameOverPanel = new GameOverPanel(spriteImage);

    this..add(horizon)..add(trex)..add(gameOverPanel);
  }

  Future<int> getHightScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("hiScore") ?? 0;
  }

  void saveHightScore(int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("hiScore", score);
  }

  @override
  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xfff7f7f7);
    canvas.drawRect(bgRect, bgPaint);

    textConfig.render(canvas, "HI ${hiScore.toString().padLeft(5, '0')}",
        Position(size.width - 230, 10));
    textConfig.render(canvas, score.floor().toString().padLeft(5, '0'),
        Position(size.width - 90, 10));

    super.render(canvas);
  }

  void onTap() {
    switch (status) {
      case GameStatus.waiting:
        status = GameStatus.playing;
        break;
      case GameStatus.gameOver:
        restart();
        break;
      case GameStatus.pausing:
        status = GameStatus.playing;
        return;
      default:
        break;
    }

    trex.status = TrexStatus.jumping;
  }

  @override
  void update(double t) {
    trex.update(t);
    horizon.updateWithSpeed(0.0, this.currentSpeed);
    if (status != GameStatus.playing) return;
    score += currentSpeed * t * (currentSpeed / GameConfig.speed);

    horizon.updateWithSpeed(t, this.currentSpeed);
    Obstacle obstacle = horizon.obstacleManager.components.firstWhere((c) {
      Obstacle obs = c as Obstacle;
      return obs.x > 0;
    });
    checkHiScore();
    bool collision = obstacle != null && checkForCollision(obstacle, trex);
    if (!collision) {
      if (this.currentSpeed < GameConfig.maxSpeed) {
        this.currentSpeed += GameConfig.velocity;
      }
    } else {
      doGameOver(t);
    }
  }

  void checkHiScore() {
    if (score.floor() > hiScore) {
      hiScore = score.floor();
      saveHightScore(hiScore);
    }
  }

  void restart() {
    status = GameStatus.playing;
    trex.reset();
    horizon.reset();
    currentSpeed = GameConfig.speed;
    score = 0;
    gameOverPanel.isVisible = false;
  }

  void doGameOver(double t) {
    gameOverPanel.isVisible = true;
    trex.status = TrexStatus.crashed;
    status = GameStatus.gameOver;
    trex.update(t);
  }

  void pause() {
    trex.status = TrexStatus.waiting;
    status = GameStatus.pausing;
  }
}
