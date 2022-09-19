import 'package:baker/components/order_tray.dart';
import 'package:baker/components/score_keeper.dart';
import 'package:baker/components/serving_tray.dart';
import 'package:baker/components/sprite_tray.dart';
import 'package:baker/overlays/pause_menu_overlay.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_fire_atlas/flame_fire_atlas.dart';
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
  late FireAtlas atlas;
  late FireAtlas paperAtlas;
  late FireAtlas fastfoodAtlas;
  late OrderTray orderTray;
  late SpriteTray spriteTray;
  late ServingTray servingTray;
  late ScoreKeeper? scoreKeeper;
  late SpriteComponent fastfood;
  int orderNummber = 1;

  int score = 0;
  Paint scorePaint = Paint()..color = Colors.black;

  bool gameOver = false;

  @override
  Future<void> onLoad() async {
    atlas = await loadFireAtlas('food-sprites.fa');
    fastfoodAtlas = await loadFireAtlas('fastfoodBackdrop.fa');
    paperAtlas = await loadFireAtlas('paper.fa');
    super.onLoad();
    Flame.device.setLandscape();

    camera.viewport = FixedResolutionViewport(Vector2(900, 570));
    add(fastfood = SpriteComponent()
      ..sprite = fastfoodAtlas.getSprite('backdrop')
      ..anchor = Anchor.topLeft
      ..position = Vector2.all(0)
      ..size = Vector2(900, 600));
  }

  void loadCompomponents() {
    add(scoreKeeper = ScoreKeeper()
      ..position = Vector2(size.x / 2, size.y * .45)
      ..anchor = Anchor.center);
    add(orderTray = OrderTray()
      ..size = Vector2(size[0] * .8, size[1] * .25)
      ..position = Vector2(size[0] / 2, size[1] * .2));
    add(servingTray = ServingTray()
      ..size = Vector2(size[0] * .8, size[1] * .4)
      ..position = Vector2(size[0] / 2, size[1] / 2 + 50));
    add(spriteTray = SpriteTray(
        Vector2(size[0] / 2, size[1] * .9), Vector2(size[0] * .8, 60)));
  }

  void start() {
    gameOver = false;
    score = 0;
    orderNummber = 1;
    removeAll(children.where((element) => element != fastfood));

    loadCompomponents();
    resumeEngine();
  }
}
