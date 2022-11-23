import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flappy_ember/game.dart';

class Ground extends ParallaxComponent<FlappyEmber> {
  Ground() : super(priority: -1);

  @override
  Future<void> onLoad() async {
    final groundImage = Flame.images.fromCache('ground.png');
    parallax = Parallax([
      ParallaxLayer(ParallaxImage(groundImage, fill: LayerFill.none)),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax!.baseVelocity.x = gameRef.speed;
  }
}
