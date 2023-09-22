import 'dart:ui';

import 'package:flutter/material.dart';

class NeonEffect extends StatelessWidget {
  const NeonEffect({
    required this.child,
    required this.color,
    this.opacity = 1.0,
    this.sigma = 25.0,
    super.key,
  });

  final Widget child;
  final double opacity;
  final double sigma;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      children: [
        Transform.translate(
        offset: Offset.zero,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: sigma,
              sigmaY: sigma,
              tileMode: TileMode.decal,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
              child: Opacity(
                opacity: opacity,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(color, BlendMode.srcATop),
                  child: child,
                ),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
