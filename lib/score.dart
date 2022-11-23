import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flappy_ember/game.dart';
import 'package:flutter/widgets.dart';

class ScoreComponent extends HudMarginComponent<FlappyEmber> {
  ScoreComponent()
      : super(
          margin: const EdgeInsets.only(left: 20, top: 20),
          priority: 2,
        );

  late final TextComponent textComponent;
  static const baseText = 'Score:';

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(textComponent = TextComponent(text: '$baseText 0'));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!gameRef.isGameOver) {
      final score = (gameRef.speed - FlappyEmber.initialSpeed).toInt();
      textComponent.text = '$baseText $score';
    }
  }
}
