import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonController extends StatelessWidget {
  const ButtonController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                if (!FlameAudio.bgm.isPlaying) {
                  FlameAudio.bgm.play('hipjazz.mp3');
                }
              },
              icon: const Icon(Icons.volume_up_rounded)),
          const SizedBox(width: 10),
          IconButton(
              onPressed: () => FlameAudio.bgm.stop(),
              icon: const Icon(Icons.volume_off_rounded)),
        ],
      ),
    );
  }
}
