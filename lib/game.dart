import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flappy_ember/box_stack.dart';
import 'package:flappy_ember/ground.dart';
import 'package:flappy_ember/player.dart';
import 'package:flappy_ember/score.dart';
import 'package:flappy_ember/sky.dart';

class FlappyEmber extends FlameGame with TapDetector, HasCollisionDetection {
  static const initialSpeed = 200.0;
  late Player player;
  final _random = Random();
  double speed = FlappyEmber.initialSpeed;
  final _boxInterval = 2.0;
  bool _gameOver = false;
  bool get isGameOver => _gameOver;

  @override
  Future<void> onLoad() async {
    await images.loadAllImages();
    restart();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_gameOver) {
      return;
    }
    speed += 10 * dt;
  }

  void gameOver() {
    _gameOver = true;
    speed = 0;
    add(
      TextComponent(
        text: 'Game over!',
        position: size / 2,
        anchor: Anchor.center,
        priority: 10,
      ),
    );
  }

  @override
  void onTap() {
    if (_gameOver) {
      return restart();
    }
    player.fly();
  }

  void restart() {
    removeAll(children);
    _gameOver = false;
    speed = initialSpeed;
    removeAll(children);
    addAll([
      Sky(),
      Ground(),
      ScoreComponent(),
      player = Player(),
      ScreenHitbox(),
      TimerComponent(
        repeat: true,
        period: _boxInterval,
        onTick: () => add(BoxStack(isBottom: _random.nextBool())),
      )
    ]);
  }
}
