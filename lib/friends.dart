import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Friends extends PositionComponent with CollisionCallbacks {
  @override
  Future<void>? onLoad() {
    super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    print('away..');
  }
}
