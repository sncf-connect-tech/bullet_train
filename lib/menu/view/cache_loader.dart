import 'package:bullet_train/design/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CacheLoader extends StatefulWidget {
  const CacheLoader({required this.child, super.key});

  final Widget child;

  @override
  State<CacheLoader> createState() => _CacheLoaderState();
}

class _CacheLoaderState extends State<CacheLoader> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final images = <Image>[];
      context.visitChildElements((element) {
        if (element.widget is Image) {
          images.add(element.widget as Image);
        }
      });

      await Future.wait<dynamic>([
        AppTheme.pendingFonts().onError((_, __) {}),
        Future.forEach(
          images,
          (image) => precacheImage(image.image, context),
        ),
      ]);

      setState(() {
        isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1 : 0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutExpo,
      child: widget.child,
    );
  }
}
