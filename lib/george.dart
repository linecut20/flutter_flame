import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_example/main.dart';

class George extends SpriteAnimationComponent
    with HasGameRef<SimGame>, CollisionCallbacks {
  George() : super(size: Vector2.all(100));
  late SpriteAnimation idleAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;

  int direction = 0;
  double animSpeed = 0.2;
  double moveSpeed = 100;

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    final georgePositionX = size.x / 2.6;
    final georgePositionY = size.y / 2;

    final spriteSheet = SpriteSheet(
        image: await gameRef.images.load('george.png'),
        srcSize: Vector2(48, 48));

    idleAnimation =
        spriteSheet.createAnimation(row: 0, to: 1, stepTime: animSpeed);
    downAnimation =
        spriteSheet.createAnimation(row: 0, to: 4, stepTime: animSpeed);
    leftAnimation =
        spriteSheet.createAnimation(row: 1, to: 4, stepTime: animSpeed);
    upAnimation =
        spriteSheet.createAnimation(row: 2, to: 4, stepTime: animSpeed);
    rightAnimation =
        spriteSheet.createAnimation(row: 3, to: 4, stepTime: animSpeed);

    position = Vector2(georgePositionX, georgePositionY);
    animation = idleAnimation;
    debugMode = true;

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    switch (direction) {
      case 0:
        animation = idleAnimation;
        break;
      case 1:
        animation = downAnimation;
        y += dt * moveSpeed;
        break;
      case 2:
        animation = leftAnimation;
        x -= dt * moveSpeed;
        break;

      case 3:
        animation = upAnimation;
        y -= dt * moveSpeed;
        break;
      case 4:
        animation = rightAnimation;
        x += dt * moveSpeed;
        break;
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    gameRef.hit.start();

    print('met...');
    super.onCollisionStart(intersectionPoints, other);
  }
}
