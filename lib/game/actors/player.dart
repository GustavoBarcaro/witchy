import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:witchy/game.dart';
import 'package:witchy/game/actors/enemy.dart';
import 'package:witchy/game/components/lightning_attack.dart';

class Player extends SpriteAnimationComponent with HasGameRef<WitchyGame> {
  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _meleeAnimation;
  late final SpriteAnimation _magicAnimation;

  Player({super.priority});

  final double _animationSpeed = .20;

  Future<void> _loadAnimations() async {
    final idleSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images
            .load('character/character_idle_spritesheet.png'),
        columns: 4,
        rows: 1);

    final meleeSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image:
            await gameRef.images.load('character/melee_attack_spritesheet.png'),
        columns: 4,
        rows: 1);

    final magicSpriteSheet = SpriteSheet.fromColumnsAndRows(
        image:
            await gameRef.images.load('character/magic_attack_spritesheet.png'),
        columns: 8,
        rows: 1);

    _idleAnimation =
        idleSpriteSheet.createAnimation(row: 0, stepTime: _animationSpeed);

    _meleeAnimation = meleeSpriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed / 2, loop: false);

    _magicAnimation = magicSpriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed / 2, loop: false);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadAnimations().then((_) => {animation = _idleAnimation});
    // sprite = await gameRef.loadSprite('character/character_base.png');
    position = Vector2(16.0, gameRef.size[1] / 2.0 - 96.0);
    size = Vector2.all(128.0);
  }

  void playIdleAnimation() {
    animation = _idleAnimation;
  }

  void playMeleeAnimation() {
    _meleeAnimation.reset();
    animation = _meleeAnimation;
  }

  void playMagicAnimation() {
    _magicAnimation.reset();
    animation = _magicAnimation;
  }

  void meleeAttack(Enemy enemy, int damage) {
    final originalPosition = Vector2(16.0, gameRef.size[1] / 2.0 - 96.0);

    gameRef.playerAttacking = true;
    size = Vector2.all(172);
    priority = 1;
    anchor = Anchor.center;
    position = Vector2(enemy.position.x - enemy.size.x / 2, enemy.position.y);
    playMeleeAnimation();
    Future.delayed(const Duration(milliseconds: 800), () {
      size = Vector2.all(128);
      position = originalPosition;
      anchor = Anchor.topLeft;
      playIdleAnimation();
      enemy.health -= damage;
      gameRef.playerTurn = false;
      gameRef.playerAttacking = false;
      if (enemy.health <= 0) {
        gameRef.removeTarget();
      }
    });
  }

  void magicAttack(Enemy enemy, int damage) {
    gameRef.playerAttacking = true;
    size = Vector2.all(160);
    playMagicAnimation();
    Future.delayed(const Duration(milliseconds: 800), () {
      gameRef.add(LightningAttack(
          position:
              Vector2(enemy.position.x, enemy.position.y - enemy.size.y)));
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      size = Vector2.all(128);
      playIdleAnimation();
      enemy.health -= damage;
      gameRef.playerTurn = false;
      gameRef.playerAttacking = false;
      if (enemy.health <= 0) {
        gameRef.removeTarget();
      }
    });
  }
}
