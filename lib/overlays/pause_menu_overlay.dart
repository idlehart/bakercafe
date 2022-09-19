import 'package:baker/main.dart';
import 'package:flutter/material.dart';

class PauseMenuOverlay extends StatelessWidget {
  const PauseMenuOverlay({super.key, required this.baker});

  final BakerCafe baker;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(16),
          width: 400,
          height: 340,
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade800,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DefaultTextStyle(
            style: const TextStyle(fontFamily: 'monogram'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Baker Cafe',
                    style: TextStyle(
                      fontSize: 44,
                      color: Colors.cyanAccent,
                    )),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 64,
                      )),
                  onPressed: () {
                    baker.overlays.remove(pauseMenu);
                    baker.start();
                  },
                  child: Text(
                    'Start Game',
                    style: TextStyle(
                        fontSize: 32, color: Colors.lightBlue.shade800, fontFamily: 'monogram'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Score: ${baker.score} ',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.lightBlue.shade500,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
