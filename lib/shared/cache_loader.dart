import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        GoogleFonts.pendingFonts(),
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
      duration: const Duration(milliseconds: 500),
      child: widget.child,
    );
  }
}
