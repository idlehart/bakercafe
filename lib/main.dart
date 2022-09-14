import 'package:baker/components/order_tray.dart';
import 'package:baker/components/serving_tray.dart';
import 'package:baker/components/sprite_tray.dart';
import 'package:baker/components/text_box.dart';
import 'package:baker/overlays/pause_menu_overlay.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

const pauseMenu = 'PauseMenu';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final baker = BakerCafe();
  // runApp(GameWidget(game: baker));
  runApp(
    GameWidget<BakerCafe>(
      game: baker,
      initialActiveOverlays: const [
        pauseMenu,
      ],
      overlayBuilderMap: {
        'PauseMenu': (context, game) {
          return PauseMenuOverlay(baker: game);
        }
      },
    ),
  );
}

class BakerCafe extends FlameGame with HasTappables {
  late OrderTray orderTray;
  late SpriteTray spriteTray;
  late ServingTray servingTray;
  ScoreKeeper? scoreKeeper;

  static late int score;

  bool gameOver = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  loadCompomponents() {
    add(scoreKeeper = ScoreKeeper(game: this));
    add(
      orderTray = OrderTray()
        ..size = Vector2(size[0] * .8, size[1] * .25)
        ..position = Vector2(size[0] / 2, size[1] * .2),
    );
    add(
      servingTray = ServingTray()
        ..size = Vector2(size[0] * .8, size[1] * .4)
        ..position = Vector2(size[0] / 2, size[1] / 2 + 50),
    );
    add(
      spriteTray = SpriteTray(
        Vector2(size[0] / 2, size[1] * .9),
        Vector2(size[0] * .8, 60),
      ),
    );
  }

  void start() {
    removeAll(children);
    gameOver = false;
    loadCompomponents();
    resumeEngine();
  }
}

class ScoreKeeper extends Component {
  ScoreKeeper({required this.game}) {
    scoreComponent = TextBox('Score: $_score');
  }
  final BakerCafe game;

  int _score = 0;
  int get score => _score;
  late TextComponent scoreComponent;

  @override
  Future<void>? onLoad() {
    add(scoreComponent);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    scoreComponent.text = 'Score: $_score';
    super.update(dt);
  }

  void reset() {
    _score = 0;
  }

  void updateScore() {
    _score++;
  }
}
