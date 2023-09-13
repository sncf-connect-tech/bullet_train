import 'package:bullet_train/game/entities/unicorn/behaviors/tapping_behavior.dart';
import 'package:bullet_train/gen/assets.gen.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

class Unicorn extends PositionedEntity with HasGameRef {
  Unicorn({
    required super.position,
  }) : super(
    anchor: Anchor.center,
    size: Vector2.all(32),
    behaviors: [
      TappingBehavior(),
    ],
  );

  @visibleForTesting
  Unicorn.test({
    required super.position,
    super.behaviors,
  }) : super(size: Vector2.all(32));

  SpriteAnimation? _animation;
  late SpriteAnimationTicker _animationTicker;

  @visibleForTesting
  SpriteAnimation get animation => _animation!;

  @visibleForTesting
  SpriteAnimationTicker get animationTicker => _animationTicker;

  @override
  Future<void> onLoad() async {
    _animation = await gameRef.loadSpriteAnimation(
      Assets.images.unicornAnimation.path,
      SpriteAnimationData.sequenced(
        amount: 16,
        stepTime: 0.1,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );
    final animationComponent =
    SpriteAnimationComponent(animation: _animation, size: size);
    _animationTicker = animationComponent.animationTicker!;
    resetAnimation();
    _animationTicker.onComplete = resetAnimation;

    await add(animationComponent);
  }

  /// Set the animation to the first frame by tricking the animation
  /// into thinking it finished the last frame.
  void resetAnimation() {
    _animationTicker
      ..currentIndex = _animation!.frames.length - 1
      ..update(0.1)
      ..currentIndex = 0;
  }

  /// Plays the animation.
  void playAnimation() => _animationTicker.reset();

  /// Returns whether the animation is playing or not.
  bool isAnimationPlaying() => !_animationTicker.isFirstFrame;
}
