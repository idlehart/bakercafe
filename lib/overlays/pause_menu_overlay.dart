import 'package:baker/main.dart';
import 'package:flutter/material.dart';

class PauseMenuOverlay extends StatelessWidget {
  const PauseMenuOverlay({super.key, required this.baker});

  final BakerCafe baker;

  @override
  Widget build(BuildContext context) {
    final scoreKeeper = baker.scoreKeeper;
    return Center(
      child: Container(
          padding: const EdgeInsets.all(16),
          width: 400,
          height: 340,
          decoration: BoxDecoration(
            color: Colors.blueGrey[600],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Baker Cafe',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white30,
                  )),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 64,
                    )),
                onPressed: () {
                  baker.overlays.remove(pauseMenu);
                  scoreKeeper?.reset();
                  baker.start();
                },
                child: const Text('Start Game'),
              ),
              const SizedBox(
                height: 30,
              ),
              if (scoreKeeper != null && scoreKeeper.score > 0)
                Text(
                  scoreKeeper.scoreComponent.text,
                  style: TextStyle(fontSize: 24, color: Colors.lightBlue[600]),
                )
            ],
          )),
    );
  }
}
