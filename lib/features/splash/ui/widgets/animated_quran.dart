import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';

class AnimatedQuran extends StatelessWidget {
  const AnimatedQuran({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: AppStyles.amiriStyle16.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            '',
            textAlign: TextAlign.center,
          )
        ],
        onTap: () {
         // print("Tap Event");
        },
      ),
    );
  }
}
