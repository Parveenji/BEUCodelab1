import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class TypingTextAnimation extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextStyle? style;

  const TypingTextAnimation({
    super.key,
    required this.text,
    required this.textAlign,
    required this.style,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      displayFullTextOnTap: true,
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: style,
          cursor: "",
          speed: const Duration(milliseconds: 100),
          textAlign: textAlign,
        ),
      ],
      pause: const Duration(milliseconds: 100),
    );
  }
}
