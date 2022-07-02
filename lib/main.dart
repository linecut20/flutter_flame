import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_example/button_controller.dart';
import 'package:flame_example/friends.dart';
import 'package:flame_example/george.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:tiled/tiled.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();

  runApp(MaterialApp(
    home: Scaffold(
      body: GameWidget(
        overlayBuilderMap: {
          'ButtonController': (BuildContext context, SimGame game) =>
              const ButtonController()
        },
        game: SimGame(),
      ),
    ),
  ));
}

class SimGame extends FlameGame
    with TapDetector, HasCollisionDetection, CollisionCallbacks {
  final George george = George();
  late AudioPool hit;

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    final _background = await TiledComponent.load('map.tmx', Vector2.all(16));

    add(_background);
    add(george);

    final friends = _background.tileMap.getLayer<ObjectGroup>('friends');

    for (var i in friends!.objects) {
      add(Friends()
        ..position = Vector2(i.x, i.y)
        ..width = i.width
        ..height = i.height
        ..debugMode = true);
    }

    //sound
    hit = await AudioPool.create('audio/sword_hit.wav', maxPlayers: 1);

    //bgn
    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load('hipjazz.mp3');
    overlays.add('ButtonController');

    //=====================================================

    camera.followComponent(george,
        worldBounds: const Rect.fromLTRB(0, 0, 1600, 1200));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onTapUp(TapUpInfo info) {
    if (george.isLoaded) {
      george.direction++;
      if (george.direction > 4) {
        george.direction = 0;
      }
    }
  }
}
